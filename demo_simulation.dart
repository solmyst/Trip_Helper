// Trip Helper - Interactive Demo Simulation
// This demonstrates the actual app logic working

import 'dart:math';

void main() {
  print('🎬 TRIP HELPER - INTERACTIVE DEMO');
  print('=' * 50);
  
  // Simulate user opening the app
  runTripHelperDemo();
}

void runTripHelperDemo() {
  print('\n📱 LAUNCHING TRIP HELPER APP...\n');
  
  // Step 1: Splash Screen
  showSplashScreen();
  
  // Step 2: Home Screen with user input
  var userInput = getUserInput();
  
  // Step 3: Calculate trip
  var tripResult = calculateTrip(userInput);
  
  // Step 4: Show results
  showTripResults(tripResult);
  
  // Step 5: Show detailed breakdowns
  showDetailedBreakdowns(tripResult);
  
  // Step 6: Emergency services demo
  showEmergencyServices();
  
  print('\n🎉 DEMO COMPLETE!');
  print('Your Trip Helper app is ready for Google Play Store! 🚀');
}

void showSplashScreen() {
  print('┌─────────────────────────────────┐');
  print('│                                 │');
  print('│            🗺️                   │');
  print('│                                 │');
  print('│        Trip Helper              │');
  print('│                                 │');
  print('│  Plan your road trips with      │');
  print('│        confidence               │');
  print('│                                 │');
  print('│            ⏳                   │');
  print('│                                 │');
  print('└─────────────────────────────────┘');
  print('\n✅ Location detected: New Delhi, India');
  print('✅ GPS permissions granted');
  print('✅ App initialized successfully\n');
}

Map<String, dynamic> getUserInput() {
  print('🏠 HOME SCREEN - TRIP PLANNING');
  print('─' * 35);
  
  // Simulate user input
  var input = {
    'from': 'New Delhi, India',
    'to': 'Agra, India',
    'fromLat': 28.6139,
    'fromLng': 77.2090,
    'toLat': 27.1767,
    'toLng': 78.0081,
    'carBrand': 'Maruti Suzuki',
    'carModel': 'Swift',
    'fuelType': 'petrol',
    'mileage': 18.5,
    'people': 2,
  };
  
  print('📍 From: ${input['from']}');
  print('📍 To: ${input['to']}');
  print('🚗 Car: ${input['carBrand']} ${input['carModel']}');
  print('⛽ Fuel: ${input['fuelType'].toString().toUpperCase()}');
  print('📊 Mileage: ${input['mileage']} km/l');
  print('👥 People: ${input['people']}');
  print('\n🔄 [Calculate My Trip] - PRESSED!\n');
  
  return input;
}

Map<String, dynamic> calculateTrip(Map<String, dynamic> input) {
  print('⚡ CALCULATING TRIP...');
  print('─' * 25);
  
  // Real distance calculation using Haversine formula
  double distance = calculateDistance(
    input['fromLat'], input['fromLng'],
    input['toLat'], input['toLng']
  );
  
  print('📏 Distance calculation: ${distance.toStringAsFixed(1)} km');
  
  // Time estimation (average 60 km/h)
  int timeMinutes = (distance / 60 * 60).round();
  print('⏰ Time estimation: ${formatTime(timeMinutes)}');
  
  // Find tolls on route
  var tolls = findTollsOnRoute();
  double tollCost = tolls.fold(0.0, (sum, toll) => sum + toll['cost']);
  print('🛣️  Toll detection: ${tolls.length} tolls found');
  
  // Calculate fuel cost
  double fuelNeeded = distance / input['mileage'];
  double fuelPrice = 105.0; // ₹ per liter
  double fuelCost = fuelNeeded * fuelPrice;
  print('⛽ Fuel calculation: ${fuelNeeded.toStringAsFixed(1)}L needed');
  
  // Calculate food cost
  double foodCost = calculateFoodCost(timeMinutes, input['people']);
  print('🍽️  Food estimation: ₹${foodCost.toStringAsFixed(0)}');
  
  double totalCost = tollCost + fuelCost + foodCost;
  
  print('\n✅ CALCULATION COMPLETE!');
  print('💰 Total Trip Cost: ₹${totalCost.toStringAsFixed(0)}\n');
  
  return {
    'distance': distance,
    'timeMinutes': timeMinutes,
    'tolls': tolls,
    'tollCost': tollCost,
    'fuelNeeded': fuelNeeded,
    'fuelCost': fuelCost,
    'foodCost': foodCost,
    'totalCost': totalCost,
    'input': input,
  };
}

void showTripResults(Map<String, dynamic> result) {
  print('📊 TRIP RESULTS SCREEN');
  print('═' * 30);
  
  print('🟢 ${result['input']['from']}');
  print('┃');
  print('┃  ${result['distance'].toStringAsFixed(0)} km • ${formatTime(result['timeMinutes'])} • ${result['tolls'].length} tolls');
  print('┃');
  print('🔴 ${result['input']['to']}        ₹${result['totalCost'].toStringAsFixed(0)}');
  print('                           Total Cost');
  print('');
  print('🚗 ${result['input']['carBrand']} ${result['input']['carModel']}');
  print('   ${result['input']['fuelType'].toString().toUpperCase()} • ${result['input']['mileage']} km/l');
  print('');
  
  print('💸 EXPENSE BREAKDOWN:');
  print('─' * 25);
  print('🛣️  Toll Expenses:     ₹${result['tollCost'].toStringAsFixed(0)} (${result['tolls'].length} tolls)');
  print('⛽ Fuel Expenses:    ₹${result['fuelCost'].toStringAsFixed(0)} (${result['fuelNeeded'].toStringAsFixed(1)}L)');
  print('🍽️  Food Expenses:     ₹${result['foodCost'].toStringAsFixed(0)} (${result['input']['people']} people)');
  print('');
}

void showDetailedBreakdowns(Map<String, dynamic> result) {
  print('🔍 DETAILED BREAKDOWNS (Tap to Expand)');
  print('═' * 40);
  
  // Toll Details
  print('\n🛣️  TOLL DETAILS:');
  print('─' * 20);
  for (int i = 0; i < result['tolls'].length; i++) {
    var toll = result['tolls'][i];
    print('${i + 1}️⃣ ${toll['name']}');
    print('   📍 ${toll['location']}');
    print('   💰 ₹${toll['cost']}');
    print('   🛣️  ${toll['highway']}');
    print('');
  }
  
  // Fuel Details
  print('⛽ FUEL CALCULATION:');
  print('─' * 20);
  print('Distance: ${result['distance'].toStringAsFixed(1)} km');
  print('Car Mileage: ${result['input']['mileage']} km/l');
  print('Fuel Needed: ${result['fuelNeeded'].toStringAsFixed(1)} L');
  print('Price per Liter: ₹105');
  print('Total Fuel Cost: ₹${result['fuelCost'].toStringAsFixed(0)}');
  print('');
  
  // Food Details
  print('🍽️  FOOD BREAKDOWN:');
  print('─' * 20);
  print('Number of People: ${result['input']['people']}');
  print('Travel Duration: ${formatTime(result['timeMinutes'])}');
  print('Estimated Meals: ${getMealCount(result['timeMinutes'])}');
  print('Cost per Person: ₹${(result['foodCost'] / result['input']['people']).toStringAsFixed(0)}');
  print('Total Food Cost: ₹${result['foodCost'].toStringAsFixed(0)}');
  print('');
}

void showEmergencyServices() {
  print('🚨 EMERGENCY SERVICES');
  print('═' * 25);
  print('');
  print('[Police: 100]    [Ambulance: 108]');
  print('[Fire: 101]      [Highway: 1033]');
  print('');
  print('📞 Tap any number to call emergency services');
  print('✅ All numbers are official Indian emergency contacts');
  print('');
}

// Helper functions for calculations
double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
  const double earthRadius = 6371; // Earth's radius in kilometers
  
  double dLat = degreesToRadians(lat2 - lat1);
  double dLng = degreesToRadians(lng2 - lng1);
  
  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(degreesToRadians(lat1)) * cos(degreesToRadians(lat2)) *
      sin(dLng / 2) * sin(dLng / 2);
  
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  
  return earthRadius * c;
}

double degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}

List<Map<String, dynamic>> findTollsOnRoute() {
  // Simulated toll data for Delhi-Agra route
  return [
    {
      'name': 'Kherki Daula Toll Plaza',
      'location': 'NH-8, Gurgaon',
      'cost': 65.0,
      'highway': 'NH-8'
    },
    {
      'name': 'Mathura Toll Plaza',
      'location': 'NH-2, Mathura',
      'cost': 65.0,
      'highway': 'NH-2'
    },
  ];
}

double calculateFoodCost(int timeMinutes, int people) {
  double hours = timeMinutes / 60;
  double costPerPerson;
  
  if (hours <= 6) {
    costPerPerson = 250; // Light meal/snacks
  } else if (hours <= 10) {
    costPerPerson = 500; // 2 meals
  } else {
    costPerPerson = 750; // 3 meals
  }
  
  return costPerPerson * people;
}

String formatTime(int minutes) {
  int hours = minutes ~/ 60;
  int mins = minutes % 60;
  
  if (hours > 0) {
    return '${hours}h ${mins}m';
  } else {
    return '${mins}m';
  }
}

int getMealCount(int timeMinutes) {
  double hours = timeMinutes / 60;
  if (hours <= 6) return 1;
  if (hours <= 10) return 2;
  return 3;
}