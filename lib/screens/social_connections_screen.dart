import 'package:flutter/material.dart';

class SocialConnectionsScreen extends StatefulWidget {
  const SocialConnectionsScreen({super.key});

  @override
  SocialConnectionsScreenState createState() => SocialConnectionsScreenState();
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
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final relationshipController = TextEditingController();
    int selectedGroupIndex = 0;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text('Add New Contact'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: relationshipController,
                          decoration: const InputDecoration(
                            labelText: 'Relationship',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.people),
                            hintText: 'e.g., Son, Daughter, Friend, Doctor',
                          ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<int>(
                          value: selectedGroupIndex,
                          decoration: const InputDecoration(
                            labelText: 'Group',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.group),
                          ),
                          items:
                              _connections.asMap().entries.map((entry) {
                                return DropdownMenuItem<int>(
                                  value: entry.key,
                                  child: Row(
                                    children: [
                                      Icon(
                                        entry.value['icon'] as IconData,
                                        color: entry.value['color'] as Color,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(entry.value['name'] as String),
                                    ],
                                  ),
                                );
                              }).toList(),
                          onChanged: (value) {
                            setDialogState(() {
                              selectedGroupIndex = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            phoneController.text.isNotEmpty &&
                            relationshipController.text.isNotEmpty) {
                          setState(() {
                            final newContact = {
                              'name': nameController.text,
                              'phone': phoneController.text,
                              'relationship': relationshipController.text,
                            };
                            (_connections[selectedGroupIndex]['contacts']
                                    as List)
                                .add(newContact);
                          });
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Contact added successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
          ),
    );
  }
}
