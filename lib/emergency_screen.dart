import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/common/simple_button.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Help'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Emergency warning
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: Column(
                children: [
                  Icon(Icons.warning, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text(
                    'Emergency Contacts',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap a button to call for help',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Emergency buttons
            SimpleButton(
              text: 'Call 911',
              icon: Icons.local_hospital,
              color: Colors.red,
              onPressed: () => _makeEmergencyCall(context, '911'),
            ),

            SimpleButton(
              text: 'Call Family',
              icon: Icons.family_restroom,
              color: Colors.blue,
              onPressed: () => _makeEmergencyCall(context, 'family'),
            ),

            SimpleButton(
              text: 'Call Doctor',
              icon: Icons.medical_services,
              color: Colors.green,
              onPressed: () => _makeEmergencyCall(context, 'doctor'),
            ),

            SimpleButton(
              text: 'Send Location',
              icon: Icons.location_on,
              color: Colors.orange,
              onPressed: () => _sendLocation(context),
            ),

            const Spacer(),

            // Calm down section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(Icons.self_improvement, color: Colors.blue, size: 32),
                  const SizedBox(height: 8),
                  const Text(
                    'Take deep breaths. Help is coming.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _makeEmergencyCall(BuildContext context, String type) {
    HapticFeedback.heavyImpact();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Calling $type'),
            content: Text('This would call $type in a real app.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _sendLocation(BuildContext context) {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Location Sent'),
            content: const Text(
              'Your location has been shared with emergency contacts.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
