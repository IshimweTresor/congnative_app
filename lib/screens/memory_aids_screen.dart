import 'package:flutter/material.dart';

class MemoryAidsScreen extends StatefulWidget {
  const MemoryAidsScreen({super.key});

  @override
  MemoryAidsScreenState createState() => MemoryAidsScreenState();
}

class MemoryAidsScreenState extends State<MemoryAidsScreen> {
  final List<Map<String, dynamic>> _memoryAids = [
    {
      'title': 'Today\'s Date',
      'content': DateTime.now().toString().split(' ')[0],
      'icon': Icons.calendar_today,
      'color': Colors.blue,
    },
    {
      'title': 'Important Phone Numbers',
      'content': 'Emergency: 911\nFamily: Contact List',
      'icon': Icons.phone,
      'color': Colors.green,
    },
    {
      'title': 'Daily Schedule',
      'content': 'Morning: Breakfast\nAfternoon: Activities\nEvening: Dinner',
      'icon': Icons.schedule,
      'color': Colors.orange,
    },
    {
      'title': 'Personal Information',
      'content': 'Name: [Your Name]\nAddress: [Your Address]',
      'icon': Icons.person,
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Aids'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Reference',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _memoryAids.length,
                itemBuilder: (context, index) {
                  final aid = _memoryAids[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: (aid['color'] as Color).withValues(
                                    alpha: 0.1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  aid['icon'] as IconData,
                                  color: aid['color'] as Color,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  aid['title'] as String,
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            aid['content'] as String,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddMemoryAidDialog();
        },
        tooltip: 'Add Memory Aid',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddMemoryAidDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add Memory Aid'),
            content: const Text('This feature is coming soon!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
