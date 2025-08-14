import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../utils/app_theme.dart';

class LocationInputWidget extends StatelessWidget {
  final TextEditingController fromController;
  final TextEditingController toController;
  final Function(double lat, double lng) onFromLocationSelected;
  final Function(double lat, double lng) onToLocationSelected;

  const LocationInputWidget({
    super.key,
    required this.fromController,
    required this.toController,
    required this.onFromLocationSelected,
    required this.onToLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trip Route',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            // From location
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: AppTheme.successColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: fromController,
                    decoration: const InputDecoration(
                      labelText: 'From',
                      hintText: 'Enter starting location',
                      prefixIcon: Icon(Icons.my_location),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter starting location';
                      }
                      return null;
                    },
                  ),
                ),
                Consumer<LocationProvider>(
                  builder: (context, locationProvider, child) {
                    return IconButton(
                      onPressed: locationProvider.isLoading
                          ? null
                          : () => _useCurrentLocation(context),
                      icon: locationProvider.isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.gps_fixed),
                      tooltip: 'Use current location',
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Swap button
            Center(
              child: IconButton(
                onPressed: _swapLocations,
                icon: const Icon(Icons.swap_vert),
                style: IconButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // To location
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: AppTheme.errorColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: toController,
                    decoration: const InputDecoration(
                      labelText: 'To',
                      hintText: 'Enter destination',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter destination';
                      }
                      if (value == fromController.text) {
                        return 'Destination cannot be same as starting location';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _useCurrentLocation(BuildContext context) async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    await locationProvider.getCurrentLocation();
    
    if (locationProvider.currentAddress != null) {
      fromController.text = locationProvider.currentAddress!;
      onFromLocationSelected(
        locationProvider.currentPosition!.latitude,
        locationProvider.currentPosition!.longitude,
      );
    } else if (locationProvider.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(locationProvider.error!)),
      );
    }
  }

  void _swapLocations() {
    final temp = fromController.text;
    fromController.text = toController.text;
    toController.text = temp;
  }
}