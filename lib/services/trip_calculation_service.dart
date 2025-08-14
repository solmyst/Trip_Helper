import 'dart:math';
import '../models/trip_model.dart';

class TripCalculationService {
  // Indian toll data - this would ideally come from an API
  static const List<Map<String, dynamic>> _indianTolls = [
    {
      'name': 'Kherki Daula Toll Plaza',
      'location': 'NH-8, Gurgaon',
      'lat': 28.4089,
      'lng': 76.9176,
      'cost': 65.0,
      'highway': 'NH-8'
    },
    {
      'name': 'Panipat Toll Plaza',
      'location': 'NH-1, Panipat',
      'lat': 29.3909,
      'lng': 76.9635,
      'cost': 85.0,
      'highway': 'NH-1'
    },
    // Add more toll plazas as needed
  ];

  // Average fuel prices in India (₹ per liter)
  static const Map<String, double> _fuelPrices = {
    'petrol': 105.0,
    'diesel': 95.0,
    'cng': 75.0,
  };

  Future<TripModel> calculateTrip({
    required String fromLocation,
    required String toLocation,
    required double fromLat,
    required double fromLng,
    required double toLat,
    required double toLng,
    required CarModel car,
    required int numberOfPeople,
  }) async {
    // Calculate distance using Haversine formula
    double distance = _calculateDistance(fromLat, fromLng, toLat, toLng);
    
    // Estimate travel time (assuming average speed of 60 km/h)
    int estimatedTime = (distance / 60 * 60).round(); // in minutes
    
    // Find tolls on route (simplified - in reality would use route API)
    List<TollModel> tolls = _findTollsOnRoute(fromLat, fromLng, toLat, toLng);
    
    // Calculate fuel estimate
    FuelEstimate fuelEstimate = _calculateFuelEstimate(distance, car);
    
    // Calculate food estimate
    FoodEstimate foodEstimate = _calculateFoodEstimate(estimatedTime, numberOfPeople);
    
    return TripModel(
      fromLocation: fromLocation,
      toLocation: toLocation,
      fromLat: fromLat,
      fromLng: fromLng,
      toLat: toLat,
      toLng: toLng,
      car: car,
      numberOfPeople: numberOfPeople,
      distance: distance,
      estimatedTime: estimatedTime,
      tolls: tolls,
      fuelEstimate: fuelEstimate,
      foodEstimate: foodEstimate,
    );
  }

  double _calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    const double earthRadius = 6371; // Earth's radius in kilometers
    
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLng = _degreesToRadians(lng2 - lng1);
    
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) *
        sin(dLng / 2) * sin(dLng / 2);
    
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  List<TollModel> _findTollsOnRoute(double fromLat, double fromLng, double toLat, double toLng) {
    List<TollModel> routeTolls = [];
    
    // Simplified logic - in reality, you'd use Google Directions API
    // For now, we'll check if any tolls are within a certain radius of the route
    for (var tollData in _indianTolls) {
      double tollLat = tollData['lat'];
      double tollLng = tollData['lng'];
      
      // Check if toll is roughly on the route (simplified)
      double distanceFromStart = _calculateDistance(fromLat, fromLng, tollLat, tollLng);
      double distanceFromEnd = _calculateDistance(tollLat, tollLng, toLat, toLng);
      double directDistance = _calculateDistance(fromLat, fromLng, toLat, toLng);
      
      // If the toll is roughly on the path (with some tolerance)
      if (distanceFromStart + distanceFromEnd <= directDistance + 50) {
        routeTolls.add(TollModel(
          name: tollData['name'],
          location: tollData['location'],
          cost: tollData['cost'],
          lat: tollLat,
          lng: tollLng,
          highway: tollData['highway'],
        ));
      }
    }
    
    return routeTolls;
  }

  FuelEstimate _calculateFuelEstimate(double distance, CarModel car) {
    double fuelNeeded = distance / car.mileage;
    double fuelPrice = _fuelPrices[car.fuelType] ?? 100.0;
    double totalCost = fuelNeeded * fuelPrice;
    
    // Mock nearby fuel stations
    List<FuelStation> nearbyStations = [
      FuelStation(
        name: 'Indian Oil Petrol Pump',
        location: 'Highway Service Station',
        lat: 0.0, // Would be calculated based on route
        lng: 0.0,
        price: fuelPrice,
        brand: 'Indian Oil',
      ),
      FuelStation(
        name: 'HP Petrol Pump',
        location: 'Highway Service Station',
        lat: 0.0,
        lng: 0.0,
        price: fuelPrice + 2,
        brand: 'HP',
      ),
    ];
    
    return FuelEstimate(
      fuelNeeded: fuelNeeded,
      fuelPricePerLiter: fuelPrice,
      totalCost: totalCost,
      nearbyStations: nearbyStations,
    );
  }

  FoodEstimate _calculateFoodEstimate(int travelTimeMinutes, int numberOfPeople) {
    double hours = travelTimeMinutes / 60;
    double costPerPerson = 0;
    int numberOfMeals = 0;
    String breakdown = '';
    
    if (hours <= 6) {
      costPerPerson = 250; // ₹250 per person for snacks/light meal
      numberOfMeals = 1;
      breakdown = 'Light meal/snacks for ${hours.toStringAsFixed(1)} hours journey';
    } else if (hours <= 10) {
      costPerPerson = 500; // ₹500 per person for 1-2 meals
      numberOfMeals = 2;
      breakdown = '2 meals for ${hours.toStringAsFixed(1)} hours journey';
    } else {
      costPerPerson = 750; // ₹750 per person for multiple meals
      numberOfMeals = 3;
      breakdown = '3 meals for ${hours.toStringAsFixed(1)} hours journey';
    }
    
    double totalCost = costPerPerson * numberOfPeople;
    
    return FoodEstimate(
      totalCost: totalCost,
      numberOfMeals: numberOfMeals,
      breakdown: breakdown,
    );
  }
}