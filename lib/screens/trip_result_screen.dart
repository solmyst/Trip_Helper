import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/trip_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/trip_summary_widget.dart';
import '../widgets/expense_breakdown_widget.dart';
import '../widgets/emergency_services_widget.dart';

class TripResultScreen extends StatelessWidget {
  const TripResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
        actions: [
          IconButton(
            onPressed: () => _shareTrip(context),
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Consumer<TripProvider>(
        builder: (context, tripProvider, child) {
          final trip = tripProvider.currentTrip;
          
          if (trip == null) {
            return const Center(
              child: Text('No trip data available'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Trip summary
                TripSummaryWidget(trip: trip),
                const SizedBox(height: 16),
                
                // Map placeholder (would integrate Google Maps here)
                Card(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            size: 48,
                            color: AppTheme.textSecondary,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Map View',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Google Maps integration coming soon',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Expense breakdown
                ExpenseBreakdownWidget(trip: trip),
                const SizedBox(height: 16),
                
                // Emergency services
                const EmergencyServicesWidget(),
                const SizedBox(height: 16),
                
                // Feedback section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Feedback',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Is the information accurate?',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _provideFeedback(context, true),
                                icon: const Icon(Icons.thumb_up, color: AppTheme.successColor),
                                label: const Text('Yes'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppTheme.successColor,
                                  side: const BorderSide(color: AppTheme.successColor),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => _provideFeedback(context, false),
                                icon: const Icon(Icons.thumb_down, color: AppTheme.errorColor),
                                label: const Text('No'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppTheme.errorColor,
                                  side: const BorderSide(color: AppTheme.errorColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  void _shareTrip(BuildContext context) {
    final trip = Provider.of<TripProvider>(context, listen: false).currentTrip;
    if (trip != null) {
      // Implement sharing functionality
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Share functionality coming soon')),
      );
    }
  }

  void _provideFeedback(BuildContext context, bool isPositive) {
    if (isPositive) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thank you for your feedback!'),
          backgroundColor: AppTheme.successColor,
        ),
      );
    } else {
      _showFeedbackDialog(context);
    }
  }

  void _showFeedbackDialog(BuildContext context) {
    final feedbackController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Feedback'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please let us know what information was incorrect:'),
            const SizedBox(height: 16),
            TextField(
              controller: feedbackController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Enter your feedback here...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Submit feedback
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feedback submitted. Thank you!')),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}