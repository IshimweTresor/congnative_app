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
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showEditMemoryAidDialog(index, aid);
                                  } else if (value == 'delete') {
                                    _deleteMemoryAid(index);
                                  }
                                },
                                itemBuilder:
                                    (context) => [
                                      const PopupMenuItem(
                                        value: 'edit',
                                        child: Row(
                                          children: [
                                            Icon(Icons.edit),
                                            SizedBox(width: 8),
                                            Text('Edit'),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: 'delete',
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            SizedBox(width: 8),
                                            Text('Delete'),
                                          ],
                                        ),
                                      ),
                                    ],
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
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    IconData selectedIcon = Icons.lightbulb;
    Color selectedColor = Colors.blue;

    final availableIcons = [
      Icons.lightbulb,
      Icons.important_devices,
      Icons.phone,
      Icons.medical_services,
      Icons.home,
      Icons.car_repair,
      Icons.shopping_cart,
      Icons.event,
      Icons.person,
      Icons.pets,
    ];

    final availableColors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.amber,
    ];

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text('Add Memory Aid'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.title),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: contentController,
                          decoration: const InputDecoration(
                            labelText: 'Content',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.description),
                          ),
                          maxLines: 4,
                        ),
                        const SizedBox(height: 16),
                        const Text('Choose Icon:'),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children:
                              availableIcons.map((icon) {
                                final isSelected = icon == selectedIcon;
                                return GestureDetector(
                                  onTap: () {
                                    setDialogState(() {
                                      selectedIcon = icon;
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color:
                                          isSelected
                                              ? selectedColor
                                              : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? selectedColor
                                                : Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      icon,
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.grey[600],
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 16),
                        const Text('Choose Color:'),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children:
                              availableColors.map((color) {
                                final isSelected = color == selectedColor;
                                return GestureDetector(
                                  onTap: () {
                                    setDialogState(() {
                                      selectedColor = color;
                                    });
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? Colors.black
                                                : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
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
                        if (titleController.text.isNotEmpty &&
                            contentController.text.isNotEmpty) {
                          setState(() {
                            _memoryAids.add({
                              'title': titleController.text,
                              'content': contentController.text,
                              'icon': selectedIcon,
                              'color': selectedColor,
                            });
                          });
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Memory aid added successfully!'),
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

  void _showEditMemoryAidDialog(int index, Map<String, dynamic> aid) {
    final titleController = TextEditingController(text: aid['title'] as String);
    final contentController = TextEditingController(
      text: aid['content'] as String,
    );
    IconData selectedIcon = aid['icon'] as IconData;
    Color selectedColor = aid['color'] as Color;

    final availableIcons = [
      Icons.lightbulb,
      Icons.important_devices,
      Icons.phone,
      Icons.medical_services,
      Icons.home,
      Icons.car_repair,
      Icons.shopping_cart,
      Icons.event,
      Icons.person,
      Icons.pets,
    ];

    final availableColors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.amber,
    ];

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text('Edit Memory Aid'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.title),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: contentController,
                          decoration: const InputDecoration(
                            labelText: 'Content',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.description),
                          ),
                          maxLines: 4,
                        ),
                        const SizedBox(height: 16),
                        const Text('Choose Icon:'),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children:
                              availableIcons.map((icon) {
                                final isSelected = icon == selectedIcon;
                                return GestureDetector(
                                  onTap: () {
                                    setDialogState(() {
                                      selectedIcon = icon;
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color:
                                          isSelected
                                              ? selectedColor
                                              : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? selectedColor
                                                : Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      icon,
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.grey[600],
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                        const SizedBox(height: 16),
                        const Text('Choose Color:'),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children:
                              availableColors.map((color) {
                                final isSelected = color == selectedColor;
                                return GestureDetector(
                                  onTap: () {
                                    setDialogState(() {
                                      selectedColor = color;
                                    });
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? Colors.black
                                                : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
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
                        if (titleController.text.isNotEmpty &&
                            contentController.text.isNotEmpty) {
                          setState(() {
                            _memoryAids[index] = {
                              'title': titleController.text,
                              'content': contentController.text,
                              'icon': selectedIcon,
                              'color': selectedColor,
                            };
                          });
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Memory aid updated successfully!'),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        }
                      },
                      child: const Text('Update'),
                    ),
                  ],
                ),
          ),
    );
  }

  void _deleteMemoryAid(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Memory Aid'),
            content: const Text(
              'Are you sure you want to delete this memory aid?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _memoryAids.removeAt(index);
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Memory aid deleted successfully!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }
}
