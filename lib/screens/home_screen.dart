import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../providers/trip_provider.dart';
import '../models/trip_model.dart';
import '../utils/app_theme.dart';
import '../widgets/location_input_widget.dart';
import '../widgets/car_selection_widget.dart';
import '../widgets/recent_searches_widget.dart';
import 'trip_result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  
  CarModel? _selectedCar;
  int _numberOfPeople = 2;
  
  double? _fromLat, _fromLng, _toLat, _toLng;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  void _initializeLocation() {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    if (locationProvider.currentAddress != null) {
      _fromController.text = locationProvider.currentAddress!;
      _fromLat = locationProvider.currentPosition?.latitude;
      _fromLng = locationProvider.currentPosition?.longitude;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Helper'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome message
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.route,
                        size: 48,
                        color: AppTheme.primaryColor,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Plan Your Road Trip',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Get accurate toll and fuel cost estimates',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Location inputs
              LocationInputWidget(
                fromController: _fromController,
                toController: _toController,
                onFromLocationSelected: (lat, lng) {
                  _fromLat = lat;
                  _fromLng = lng;
                },
                onToLocationSelected: (lat, lng) {
                  _toLat = lat;
                  _toLng = lng;
                },
              ),
              const SizedBox(height: 24),

              // Car selection
              CarSelectionWidget(
                onCarSelected: (car) {
                  setState(() {
                    _selectedCar = car;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Number of people
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Number of People',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _numberOfPeople > 1
                                ? () => setState(() => _numberOfPeople--)
                                : null,
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _numberOfPeople.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: _numberOfPeople < 8
                                ? () => setState(() => _numberOfPeople++)
                                : null,
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Recent searches
              const RecentSearchesWidget(),
              const SizedBox(height: 32),

              // Calculate button
              Consumer<TripProvider>(
                builder: (context, tripProvider, child) {
                  return ElevatedButton(
                    onPressed: tripProvider.isLoading ? null : _calculateTrip,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: tripProvider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Calculate My Trip',
                            style: TextStyle(fontSize: 18),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calculateTrip() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_selectedCar == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a car')),
      );
      return;
    }

    if (_fromLat == null || _fromLng == null || _toLat == null || _toLng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select valid locations')),
      );
      return;
    }

    final tripProvider = Provider.of<TripProvider>(context, listen: false);
    
    await tripProvider.calculateTrip(
      fromLocation: _fromController.text,
      toLocation: _toController.text,
      fromLat: _fromLat!,
      fromLng: _fromLng!,
      toLat: _toLat!,
      toLng: _toLng!,
      car: _selectedCar!,
      numberOfPeople: _numberOfPeople,
    );

    if (tripProvider.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tripProvider.error!)),
      );
    } else if (tripProvider.currentTrip != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const TripResultScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }
}