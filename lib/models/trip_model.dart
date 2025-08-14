class TripModel {
  final String fromLocation;
  final String toLocation;
  final double fromLat;
  final double fromLng;
  final double toLat;
  final double toLng;
  final CarModel car;
  final int numberOfPeople;
  final double distance;
  final int estimatedTime; // in minutes
  final List<TollModel> tolls;
  final FuelEstimate fuelEstimate;
  final FoodEstimate foodEstimate;

  TripModel({
    required this.fromLocation,
    required this.toLocation,
    required this.fromLat,
    required this.fromLng,
    required this.toLat,
    required this.toLng,
    required this.car,
    required this.numberOfPeople,
    required this.distance,
    required this.estimatedTime,
    required this.tolls,
    required this.fuelEstimate,
    required this.foodEstimate,
  });

  double get totalTollCost => tolls.fold(0.0, (sum, toll) => sum + toll.cost);
  
  double get totalTripCost => 
      totalTollCost + fuelEstimate.totalCost + foodEstimate.totalCost;
}

class CarModel {
  final String brand;
  final String model;
  final String fuelType; // petrol, diesel, cng
  final double mileage; // km per liter
  final String? vehicleNumber;
  final double? fastagBalance;

  CarModel({
    required this.brand,
    required this.model,
    required this.fuelType,
    required this.mileage,
    this.vehicleNumber,
    this.fastagBalance,
  });
}

class TollModel {
  final String name;
  final String location;
  final double cost;
  final double lat;
  final double lng;
  final String highway;

  TollModel({
    required this.name,
    required this.location,
    required this.cost,
    required this.lat,
    required this.lng,
    required this.highway,
  });
}

class FuelEstimate {
  final double fuelNeeded; // in liters
  final double fuelPricePerLiter;
  final double totalCost;
  final List<FuelStation> nearbyStations;

  FuelEstimate({
    required this.fuelNeeded,
    required this.fuelPricePerLiter,
    required this.totalCost,
    required this.nearbyStations,
  });
}

class FuelStation {
  final String name;
  final String location;
  final double lat;
  final double lng;
  final double price;
  final String brand;

  FuelStation({
    required this.name,
    required this.location,
    required this.lat,
    required this.lng,
    required this.price,
    required this.brand,
  });
}

class FoodEstimate {
  final double totalCost;
  final int numberOfMeals;
  final String breakdown;

  FoodEstimate({
    required this.totalCost,
    required this.numberOfMeals,
    required this.breakdown,
  });
}