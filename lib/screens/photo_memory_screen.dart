import 'package:flutter/material.dart';

class PhotoMemoryScreen extends StatefulWidget {
  const PhotoMemoryScreen({super.key});

  @override
  PhotoMemoryScreenState createState() => PhotoMemoryScreenState();
}

class PhotoMemoryScreenState extends State<PhotoMemoryScreen> {
  final List<Map<String, dynamic>> _memories = [
    {
      'id': '1',
      'title': 'Family Dinner',
      'description': 'Sunday dinner with Mom, Dad, and Sister at home',
      'category': 'Family',
      'date': '2024-01-15',
      'image': Icons.family_restroom,
      'color': Colors.pink,
      'people': ['Mom', 'Dad', 'Sister'],
      'location': 'Home',
      'notes': 'We had roast chicken and talked about vacation plans',
    },
    {
      'id': '2',
      'title': 'Doctor Visit',
      'description': 'Checkup with Dr. Smith at the medical center',
      'category': 'Health',
      'date': '2024-01-10',
      'image': Icons.local_hospital,
      'color': Colors.green,
      'people': ['Dr. Smith'],
      'location': 'Medical Center, Room 205',
      'notes': 'Blood pressure is good, continue current medication',
    },
    {
      'id': '3',
      'title': 'Coffee with Friend',
      'description': 'Met Sarah at the corner café',
      'category': 'Social',
      'date': '2024-01-08',
      'image': Icons.local_cafe,
      'color': Colors.brown,
      'people': ['Sarah'],
      'location': 'Corner Café on Main Street',
      'notes': 'Sarah is planning a trip to Florida next month',
    },
    {
      'id': '4',
      'title': 'Grocery Shopping',
      'description': 'Weekly shopping at the supermarket',
      'category': 'Daily Life',
      'date': '2024-01-07',
      'image': Icons.shopping_cart,
      'color': Colors.blue,
      'people': [],
      'location': 'City Supermarket',
      'notes': 'Bought fruits, vegetables, and bread. Forgot milk again!',
    },
  ];

  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Family',
    'Health',
    'Social',
    'Daily Life',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Memory Book'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: _addMemory,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(child: _buildMemoriesList()),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;

          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              selectedColor: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.2),
              checkmarkColor: Theme.of(context).colorScheme.primary,
            ),
          );
        },
      ),
    );
  }

  Widget _buildMemoriesList() {
    final filteredMemories =
        _selectedCategory == 'All'
            ? _memories
            : _memories
                .where((m) => m['category'] == _selectedCategory)
                .toList();

    if (filteredMemories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No memories in this category yet',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the camera button to add one!',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredMemories.length,
      itemBuilder: (context, index) {
        final memory = filteredMemories[index];
        return _buildMemoryCard(memory);
      },
    );
  }

  Widget _buildMemoryCard(Map<String, dynamic> memory) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _viewMemoryDetails(memory),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: memory['color'].withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      memory['image'],
                      color: memory['color'],
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          memory['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          memory['date'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: memory['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      memory['category'],
                      style: TextStyle(
                        fontSize: 12,
                        color: memory['color'],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(memory['description'], style: const TextStyle(fontSize: 16)),
              if (memory['people'].isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children:
                      (memory['people'] as List<String>).map((person) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            person,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _viewMemoryDetails(Map<String, dynamic> memory) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(memory['title']),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: memory['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(memory['image'], color: memory['color'], size: 48),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                memory['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                memory['date'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow('Description', memory['description']),
                  if (memory['location'].isNotEmpty)
                    _buildDetailRow('Location', memory['location']),
                  if (memory['people'].isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Text(
                      'People:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children:
                          (memory['people'] as List<String>).map((person) {
                            return Chip(
                              label: Text(person),
                              backgroundColor: Colors.blue.withValues(
                                alpha: 0.1,
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                  if (memory['notes'].isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _buildDetailRow('Notes', memory['notes']),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _editMemory(memory);
                },
                child: const Text('Edit'),
              ),
            ],
          ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value),
        const SizedBox(height: 12),
      ],
    );
  }

  void _addMemory() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final notesController = TextEditingController();
    final peopleController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text('Add Memory'),
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
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.description),
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: notesController,
                          decoration: const InputDecoration(
                            labelText: 'Notes',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.note),
                            hintText: 'What happened? How did you feel?',
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: peopleController,
                          decoration: const InputDecoration(
                            labelText: 'People (comma separated)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.people),
                            hintText: 'John, Mary, Dr. Smith',
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          title: Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                          ),
                          subtitle: const Text('Date'),
                          leading: const Icon(Icons.calendar_today),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime.now().subtract(
                                const Duration(days: 365),
                              ),
                              lastDate: DateTime.now(),
                            );
                            if (date != null) {
                              setDialogState(() {
                                selectedDate = date;
                              });
                            }
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
                        if (titleController.text.isNotEmpty) {
                          final newMemory = {
                            'id':
                                DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                            'title': titleController.text,
                            'description': descriptionController.text,
                            'date': selectedDate,
                            'notes': notesController.text,
                            'people':
                                peopleController.text
                                    .split(',')
                                    .map((e) => e.trim())
                                    .where((e) => e.isNotEmpty)
                                    .toList(),
                            'category': _selectedCategory,
                          };
                          setState(() {
                            _memories.add(newMemory);
                          });
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Memory added successfully!'),
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

  void _editMemory(Map<String, dynamic> memory) {
    final titleController = TextEditingController(text: memory['title']);
    final descriptionController = TextEditingController(
      text: memory['description'],
    );
    final notesController = TextEditingController(text: memory['notes']);
    final peopleController = TextEditingController(
      text: (memory['people'] as List).join(', '),
    );
    DateTime selectedDate = memory['date'];

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text('Edit Memory'),
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
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.description),
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: notesController,
                          decoration: const InputDecoration(
                            labelText: 'Notes',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.note),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: peopleController,
                          decoration: const InputDecoration(
                            labelText: 'People (comma separated)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.people),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          title: Text(
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                          ),
                          subtitle: const Text('Date'),
                          leading: const Icon(Icons.calendar_today),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime.now().subtract(
                                const Duration(days: 365),
                              ),
                              lastDate: DateTime.now(),
                            );
                            if (date != null) {
                              setDialogState(() {
                                selectedDate = date;
                              });
                            }
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
                        if (titleController.text.isNotEmpty) {
                          setState(() {
                            final index = _memories.indexWhere(
                              (m) => m['id'] == memory['id'],
                            );
                            if (index != -1) {
                              _memories[index] = {
                                ...memory,
                                'title': titleController.text,
                                'description': descriptionController.text,
                                'notes': notesController.text,
                                'people':
                                    peopleController.text
                                        .split(',')
                                        .map((e) => e.trim())
                                        .where((e) => e.isNotEmpty)
                                        .toList(),
                                'date': selectedDate,
                              };
                            }
                          });
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Memory updated successfully!'),
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
}
