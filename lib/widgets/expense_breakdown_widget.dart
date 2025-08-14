import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/trip_model.dart';
import '../utils/app_theme.dart';

class ExpenseBreakdownWidget extends StatelessWidget {
  final TripModel trip;

  const ExpenseBreakdownWidget({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    
    return Column(
      children: [
        // Toll expenses
        _buildExpenseCard(
          context: context,
          title: 'Toll Expenses',
          icon: Icons.toll,
          amount: trip.totalTollCost,
          subtitle: '${trip.tolls.length} toll${trip.tolls.length != 1 ? 's' : ''}',
          onTap: () => _showTollDetails(context),
        ),
        const SizedBox(height: 12),
        
        // Fuel expenses
        _buildExpenseCard(
          context: context,
          title: 'Fuel Expenses',
          icon: Icons.local_gas_station,
          amount: trip.fuelEstimate.totalCost,
          subtitle: '${trip.fuelEstimate.fuelNeeded.toStringAsFixed(1)}L needed',
          onTap: () => _showFuelDetails(context),
        ),
        const SizedBox(height: 12),
        
        // Food expenses
        _buildExpenseCard(
          context: context,
          title: 'Food Expenses',
          icon: Icons.restaurant,
          amount: trip.foodEstimate.totalCost,
          subtitle: '${trip.numberOfPeople} people • ${trip.foodEstimate.numberOfMeals} meals',
          onTap: () => _showFoodDetails(context),
        ),
      ],
    );
  }

  Widget _buildExpenseCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required double amount,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    currencyFormat.format(amount),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppTheme.textSecondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTollDetails(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.toll, color: AppTheme.primaryColor),
                  const SizedBox(width: 8),
                  const Text(
                    'Toll Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    currencyFormat.format(trip.totalTollCost),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: trip.tolls.length,
                  itemBuilder: (context, index) {
                    final toll = trip.tolls[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(toll.name),
                        subtitle: Text('${toll.location} • ${toll.highway}'),
                        trailing: Text(
                          currencyFormat.format(toll.cost),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFuelDetails(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.local_gas_station, color: AppTheme.primaryColor),
                  const SizedBox(width: 8),
                  const Text(
                    'Fuel Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    currencyFormat.format(trip.fuelEstimate.totalCost),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Fuel calculation breakdown
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildDetailRow('Distance', '${trip.distance.toStringAsFixed(1)} km'),
                      _buildDetailRow('Car Mileage', '${trip.car.mileage} km/l'),
                      _buildDetailRow('Fuel Needed', '${trip.fuelEstimate.fuelNeeded.toStringAsFixed(1)} L'),
                      _buildDetailRow('Price per Liter', currencyFormat.format(trip.fuelEstimate.fuelPricePerLiter)),
                      const Divider(),
                      _buildDetailRow('Total Cost', currencyFormat.format(trip.fuelEstimate.totalCost), isTotal: true),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Nearby fuel stations
              const Text(
                'Nearby Fuel Stations',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: trip.fuelEstimate.nearbyStations.length,
                  itemBuilder: (context, index) {
                    final station = trip.fuelEstimate.nearbyStations[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppTheme.secondaryColor.withOpacity(0.1),
                          child: const Icon(
                            Icons.local_gas_station,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                        title: Text(station.name),
                        subtitle: Text('${station.location} • ${station.brand}'),
                        trailing: Text(
                          '${currencyFormat.format(station.price)}/L',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFoodDetails(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.restaurant, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'Food Expenses',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  currencyFormat.format(trip.foodEstimate.totalCost),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildDetailRow('Number of People', '${trip.numberOfPeople}'),
                    _buildDetailRow('Travel Duration', _formatDuration(trip.estimatedTime)),
                    _buildDetailRow('Estimated Meals', '${trip.foodEstimate.numberOfMeals}'),
                    _buildDetailRow('Cost per Person', currencyFormat.format(trip.foodEstimate.totalCost / trip.numberOfPeople)),
                    const Divider(),
                    _buildDetailRow('Total Cost', currencyFormat.format(trip.foodEstimate.totalCost), isTotal: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            Text(
              trip.foodEstimate.breakdown,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? AppTheme.textPrimary : AppTheme.textSecondary,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isTotal ? AppTheme.primaryColor : AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    
    if (hours > 0) {
      return '${hours}h ${mins}m';
    } else {
      return '${mins}m';
    }
  }
}