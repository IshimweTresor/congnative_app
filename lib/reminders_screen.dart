import 'package:flutter/material.dart';
import 'widgets/common/simple_button.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  RemindersScreenState createState() => RemindersScreenState();
}

class RemindersScreenState extends State<RemindersScreen> {
  List<Reminder> reminders = [
    Reminder('Take morning medicine', '8:00 AM', Icons.medication, true),
    Reminder('Lunch time', '12:00 PM', Icons.restaurant, true),
    Reminder('Call mom', '3:00 PM', Icons.phone, false),
    Reminder('Evening walk', '6:00 PM', Icons.directions_walk, true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _addReminder(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.notifications, color: Colors.orange, size: 32),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Reminders',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        '${reminders.where((r) => r.isActive).length} active reminders',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  final reminder = reminders[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              reminder.isActive
                                  ? Colors.orange.withValues(alpha: 0.1)
                                  : Colors.grey.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          reminder.icon,
                          color:
                              reminder.isActive ? Colors.orange : Colors.grey,
                          size: 32,
                        ),
                      ),
                      title: Text(
                        reminder.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        reminder.time,
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: Switch(
                        value: reminder.isActive,
                        onChanged: (value) {
                          setState(() {
                            reminder.isActive = value;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            SimpleButton(
              text: 'Add New Reminder',
              icon: Icons.add,
              onPressed: _addReminder,
            ),
          ],
        ),
      ),
    );
  }

  void _addReminder() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add Reminder'),
            content: const Text(
              'This would open a form to add a new reminder.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }
}

class Reminder {
  String title;
  String time;
  IconData icon;
  bool isActive;

  Reminder(this.title, this.time, this.icon, this.isActive);
}
