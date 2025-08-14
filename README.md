# Trip Helper

A Flutter app that helps travelers plan road trips with accurate expense estimation and real-time information for Indian highways.

## Features

### Core Features
- **Route Planning**: Enter source and destination to get detailed trip information
- **Expense Calculation**: 
  - Toll cost estimation with detailed breakdown
  - Fuel cost calculation based on car specifications
  - Food expense estimation based on travel duration
- **Car Management**: Input car details for accurate fuel calculations
- **Location Services**: Auto-detect current location
- **Recent Searches**: Quick access to previous trip searches

### Emergency Services
- Quick access to emergency numbers (Police: 100, Ambulance: 108, etc.)
- Highway helpline integration
- Roadside assistance (coming soon)

### Additional Features
- Clean, intuitive UI following Material Design
- Detailed expense breakdowns with tap-to-expand
- Feedback system for data accuracy
- AdMob integration for monetization

## Technology Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **State Management**: Provider
- **Maps**: Google Maps Flutter
- **Location**: Geolocator, Geocoding
- **Monetization**: Google Mobile Ads
- **UI**: Material Design 3

## Setup Instructions

### Prerequisites
1. Flutter SDK (3.0+)
2. Android Studio / VS Code
3. Google Maps API Key
4. AdMob Account

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd trip_helper
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Google Maps API**
   - Get API key from Google Cloud Console
   - Enable Maps SDK for Android
   - Replace `YOUR_GOOGLE_MAPS_API_KEY` in `android/app/src/main/AndroidManifest.xml`

4. **Configure AdMob**
   - Create AdMob account and app
   - Replace the AdMob App ID in `AndroidManifest.xml`
   - Update ad unit IDs in the code

5. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   └── trip_model.dart
├── providers/                # State management
│   ├── trip_provider.dart
│   └── location_provider.dart
├── screens/                  # UI screens
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   └── trip_result_screen.dart
├── services/                 # Business logic
│   └── trip_calculation_service.dart
├── utils/                    # Utilities
│   └── app_theme.dart
└── widgets/                  # Reusable widgets
    ├── location_input_widget.dart
    ├── car_selection_widget.dart
    ├── recent_searches_widget.dart
    ├── trip_summary_widget.dart
    ├── expense_breakdown_widget.dart
    └── emergency_services_widget.dart
```

## Key Implementation Details

### Trip Calculation Logic
- **Distance**: Calculated using Haversine formula
- **Toll Detection**: Simplified algorithm to find tolls on route
- **Fuel Estimation**: Based on distance, car mileage, and current fuel prices
- **Food Estimation**: Time-based calculation with Indian pricing

### Data Sources
- **Toll Data**: Hardcoded Indian toll plaza information (expandable)
- **Fuel Prices**: Average Indian fuel prices (can be made dynamic)
- **Emergency Numbers**: Standard Indian emergency service numbers

### Future Enhancements
1. **Real-time Data Integration**
   - Live toll prices via APIs
   - Real-time fuel prices
   - Traffic-based route optimization

2. **Enhanced Features**
   - Offline maps support
   - Weather information
   - Hotel/restaurant recommendations
   - Multi-stop trip planning

3. **Business Features**
   - User accounts and trip history
   - Social sharing
   - Premium features
   - Partnership integrations

## Google Play Store Preparation

### Pre-launch Checklist
- [ ] Test on multiple devices and screen sizes
- [ ] Optimize app performance and memory usage
- [ ] Implement proper error handling
- [ ] Add app icons and splash screens
- [ ] Create store listing assets
- [ ] Test offline scenarios
- [ ] Implement analytics
- [ ] Add privacy policy
- [ ] Test payment/ad integration

### Store Listing Requirements
- App name: "Trip Helper"
- Category: Travel & Local
- Target audience: 18+ (due to navigation features)
- Content rating: Everyone
- Privacy policy: Required (location data usage)

## Contributing

This is a solo project, but suggestions and feedback are welcome!

## License

This project is proprietary. All rights reserved.

## Contact

For questions or support, please contact [Your Contact Information]