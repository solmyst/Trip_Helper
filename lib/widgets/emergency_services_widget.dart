import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_theme.dart';

class EmergencyServicesWidget extends StatelessWidget {
  const EmergencyServicesWidget({super.key});

  static const List<Map<String, dynamic>> _emergencyServices = [
    {
      'title': 'Police',
      'number': '100',
      'icon': Icons.local_police,
      'color': Colors.blue,
      'description': 'Emergency police assistance',
    },
    {
      'title': 'Ambulance',
      'number': '108',
      'icon': Icons.local_hospital,
      'color': Colors.red,
      'description': 'Medical emergency services',
    },
    {
      'title': 'Fire Brigade',
      'number': '101',
      'icon': Icons.local_fire_department,
      'color': Colors.orange,
      'description': 'Fire emergency services',
    },
    {
      'title': 'Highway Helpline',
      'number': '1033',
      'icon': Icons.support_agent,
      'color': Colors.green,
      'description': 'Highway assistance and support',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.emergency,
                  color: AppTheme.errorColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Emergency Services',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Tap to call in case of emergency',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _emergencyServices.length,
              itemBuilder: (context, index) {
                final service = _emergencyServices[index];
                return _buildEmergencyButton(
                  context: context,
                  title: service['title'],
                  number: service['number'],
                  icon: service['icon'],
                  color: service['color'],
                  description: service['description'],
                );
              },
            ),
            const SizedBox(height: 16),
            
            // Additional services
            ExpansionTile(
              title: const Text('Additional Services'),
              children: [
                _buildServiceTile(
                  context: context,
                  title: 'Roadside Assistance',
                  subtitle: 'Coming soon - Mechanic on call',
                  icon: Icons.build,
                  onTap: () => _showComingSoon(context),
                ),
                _buildServiceTile(
                  context: context,
                  title: 'Nearby Washrooms',
                  subtitle: 'Find restrooms along your route',
                  icon: Icons.wc,
                  onTap: () => _showComingSoon(context),
                ),
                _buildServiceTile(
                  context: context,
                  title: 'Nearby Hotels',
                  subtitle: 'Find accommodation options',
                  icon: Icons.hotel,
                  onTap: () => _showComingSoon(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyButton({
    required BuildContext context,
    required String title,
    required String number,
    required IconData icon,
    required Color color,
    required String description,
  }) {
    return InkWell(
      onTap: () => _showCallConfirmation(context, title, number, description),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: color,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    number,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showCallConfirmation(
    BuildContext context,
    String service,
    String number,
    String description,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Call $service'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.phone, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                Text(
                  number,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              _makeCall(context, number);
            },
            icon: const Icon(Icons.phone),
            label: const Text('Call'),
          ),
        ],
      ),
    );
  }

  void _makeCall(BuildContext context, String number) {
    // In a real app, you would use url_launcher to make the call
    // For now, we'll just copy the number to clipboard
    Clipboard.setData(ClipboardData(text: number));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Emergency number $number copied to clipboard'),
        action: SnackBarAction(
          label: 'Call',
          onPressed: () {
            // This would open the phone dialer
            // launch('tel:$number');
          },
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This feature is coming soon!'),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }
}