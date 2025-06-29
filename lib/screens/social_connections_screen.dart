import 'package:flutter/material.dart';

class SocialConnectionsScreen extends StatefulWidget {
  const SocialConnectionsScreen({super.key});

  @override
  SocialConnectionsScreenState createState() =>
      SocialConnectionsScreenState();
}

class SocialConnectionsScreenState extends State<SocialConnectionsScreen> {
  final List<Map<String, dynamic>> _connections = [
    {
      'name': 'Family',
      'contacts': [
        {'name': 'Mom', 'phone': '555-0101', 'relationship': 'Mother'},
        {'name': 'Dad', 'phone': '555-0102', 'relationship': 'Father'},
        {'name': 'Sister', 'phone': '555-0103', 'relationship': 'Sister'},
      ],
      'icon': Icons.family_restroom,
      'color': Colors.pink,
    },
    {
      'name': 'Friends',
      'contacts': [
        {'name': 'Best Friend', 'phone': '555-0201', 'relationship': 'Friend'},
        {'name': 'Neighbor', 'phone': '555-0202', 'relationship': 'Neighbor'},
      ],
      'icon': Icons.people,
      'color': Colors.blue,
    },
    {
      'name': 'Healthcare',
      'contacts': [
        {'name': 'Dr. Smith', 'phone': '555-0301', 'relationship': 'Doctor'},
        {'name': 'Pharmacy', 'phone': '555-0302', 'relationship': 'Pharmacy'},
      ],
      'icon': Icons.local_hospital,
      'color': Colors.green,
    },
    {
      'name': 'Emergency',
      'contacts': [
        {
          'name': 'Emergency Services',
          'phone': '911',
          'relationship': 'Emergency',
        },
        {
          'name': 'Poison Control',
          'phone': '1-800-222-1222',
          'relationship': 'Poison Control',
        },
      ],
      'icon': Icons.emergency,
      'color': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Connections'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Important Contacts',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _connections.length,
                itemBuilder: (context, index) {
                  final group = _connections[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ExpansionTile(
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: (group['color'] as Color).withValues(
                            alpha: 0.1,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          group['icon'] as IconData,
                          color: group['color'] as Color,
                          size: 24,
                        ),
                      ),
                      title: Text(
                        group['name'] as String,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${(group['contacts'] as List).length} contacts',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                      children: [
                        ...(group['contacts'] as List).map((contact) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: (group['color'] as Color)
                                  .withValues(alpha: 0.1),
                              child: Text(
                                (contact['name'] as String)[0],
                                style: TextStyle(
                                  color: group['color'] as Color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(contact['name'] as String),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(contact['phone'] as String),
                                Text(
                                  contact['relationship'] as String,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.call),
                                  onPressed:
                                      () =>
                                          _makeCall(contact['phone'] as String),
                                  color: Colors.green,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.message),
                                  onPressed:
                                      () => _sendMessage(
                                        contact['phone'] as String,
                                      ),
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
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
          _showAddContactDialog();
        },
        tooltip: 'Add Contact',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _makeCall(String phoneNumber) {
    // In a real app, you would use url_launcher to make a call
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calling $phoneNumber...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _sendMessage(String phoneNumber) {
    // In a real app, you would use url_launcher to send a message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sending message to $phoneNumber...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showAddContactDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add Contact'),
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
