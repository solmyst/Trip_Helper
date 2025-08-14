class AppConstants {
  // App Information
  static const String appName = 'Trip Helper';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Plan your road trips with confidence';
  
  // API Keys (Replace with your actual keys)
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  static const String admobAppId = 'ca-app-pub-3940256099942544~3347511713'; // Test ID
  static const String admobBannerId = 'ca-app-pub-3940256099942544/6300978111'; // Test ID
  
  // Indian Emergency Numbers
  static const Map<String, String> emergencyNumbers = {
    'police': '100',
    'ambulance': '108',
    'fire': '101',
    'highway': '1033',
    'women_helpline': '1091',
    'child_helpline': '1098',
  };
  
  // Fuel Prices (₹ per liter) - Update regularly
  static const Map<String, double> fuelPrices = {
    'petrol': 105.0,
    'diesel': 95.0,
    'cng': 75.0,
  };
  
  // Popular Indian Car Brands
  static const List<String> carBrands = [
    'Maruti Suzuki',
    'Hyundai',
    'Tata',
    'Mahindra',
    'Honda',
    'Toyota',
    'Ford',
    'Kia',
    'MG Motor',
    'Skoda',
    'Volkswagen',
    'Renault',
    'Nissan',
  ];
  
  // Food cost per person based on travel duration (in hours)
  static const Map<String, Map<String, dynamic>> foodCosts = {
    'short': {'hours': 6, 'cost': 250, 'meals': 1}, // 0-6 hours
    'medium': {'hours': 10, 'cost': 500, 'meals': 2}, // 6-10 hours
    'long': {'hours': 24, 'cost': 750, 'meals': 3}, // 10+ hours
  };
  
  // App URLs
  static const String privacyPolicyUrl = 'https://your-website.com/privacy-policy';
  static const String termsOfServiceUrl = 'https://your-website.com/terms-of-service';
  static const String supportEmail = 'support@triphelper.com';
  
  // Shared Preferences Keys
  static const String keyRecentSearches = 'recent_searches';
  static const String keyUserPreferences = 'user_preferences';
  static const String keyFirstLaunch = 'first_launch';
}