import 'package:flutter/material.dart';
import '../models/trip_model.dart';
import '../utils/app_theme.dart';

class CarSelectionWidget extends StatefulWidget {
  final Function(CarModel) onCarSelected;

  const CarSelectionWidget({
    super.key,
    required this.onCarSelected,
  });

  @override
  State<CarSelectionWidget> createState() => _CarSelectionWidgetState();
}

class _CarSelectionWidgetState extends State<CarSelectionWidget> {
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _mileageController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _fastagBalanceController = TextEditingController();
  
  String _selectedFuelType = 'petrol';
  
  final List<String> _fuelTypes = ['petrol', 'diesel', 'cng'];
  final List<String> _popularBrands = [
    'Maruti Suzuki', 'Hyundai', 'Tata', 'Mahindra', 'Honda', 'Toyota', 'Ford'
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vehicle Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            // Car brand
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Car Brand',
                prefixIcon: Icon(Icons.directions_car),
              ),
              items: _popularBrands.map((brand) {
                return DropdownMenuItem(
                  value: brand,
                  child: Text(brand),
                );
              }).toList(),
              onChanged: (value) {
                _brandController.text = value ?? '';
                _updateCarModel();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select car brand';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Car model
            TextFormField(
              controller: _modelController,
              decoration: const InputDecoration(
                labelText: 'Car Model',
                hintText: 'e.g., Swift, i20, Nexon',
                prefixIcon: Icon(Icons.car_rental),
              ),
              onChanged: (_) => _updateCarModel(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter car model';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Fuel type
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Fuel Type',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SegmentedButton<String>(
                    segments: _fuelTypes.map((type) {
                      return ButtonSegment<String>(
                        value: type,
                        label: Text(type.toUpperCase()),
                      );
                    }).toList(),
                    selected: {_selectedFuelType},
                    onSelectionChanged: (Set<String> newSelection) {
                      setState(() {
                        _selectedFuelType = newSelection.first;
                      });
                      _updateCarModel();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Mileage
            TextFormField(
              controller: _mileageController,
              decoration: const InputDecoration(
                labelText: 'Mileage (km/l)',
                hintText: 'Enter your car\'s mileage',
                prefixIcon: Icon(Icons.local_gas_station),
                suffixText: 'km/l',
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => _updateCarModel(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter mileage';
                }
                final mileage = double.tryParse(value);
                if (mileage == null || mileage <= 0) {
                  return 'Please enter valid mileage';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Optional fields
            ExpansionTile(
              title: const Text('Optional Details'),
              children: [
                const SizedBox(height: 8),
                TextFormField(
                  controller: _vehicleNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Vehicle Number (Optional)',
                    hintText: 'e.g., DL 01 AB 1234',
                    prefixIcon: Icon(Icons.confirmation_number),
                  ),
                  onChanged: (_) => _updateCarModel(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _fastagBalanceController,
                  decoration: const InputDecoration(
                    labelText: 'FASTag Balance (Optional)',
                    hintText: 'Current FASTag balance',
                    prefixIcon: Icon(Icons.account_balance_wallet),
                    prefixText: '₹ ',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (_) => _updateCarModel(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updateCarModel() {
    if (_brandController.text.isNotEmpty &&
        _modelController.text.isNotEmpty &&
        _mileageController.text.isNotEmpty) {
      
      final mileage = double.tryParse(_mileageController.text);
      if (mileage != null && mileage > 0) {
        final fastagBalance = _fastagBalanceController.text.isNotEmpty
            ? double.tryParse(_fastagBalanceController.text)
            : null;
        
        final car = CarModel(
          brand: _brandController.text,
          model: _modelController.text,
          fuelType: _selectedFuelType,
          mileage: mileage,
          vehicleNumber: _vehicleNumberController.text.isNotEmpty
              ? _vehicleNumberController.text
              : null,
          fastagBalance: fastagBalance,
        );
        
        widget.onCarSelected(car);
      }
    }
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _mileageController.dispose();
    _vehicleNumberController.dispose();
    _fastagBalanceController.dispose();
    super.dispose();
  }
}