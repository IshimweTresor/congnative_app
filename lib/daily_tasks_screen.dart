import 'package:flutter/material.dart';

class DailyTasksScreen extends StatefulWidget {
  const DailyTasksScreen({super.key});

  @override
  DailyTasksScreenState createState() => DailyTasksScreenState();
}

class DailyTasksScreenState extends State<DailyTasksScreen> {
  List<Task> tasks = [
    Task('Brush teeth', false, Icons.cleaning_services),
    Task('Take medicine', false, Icons.medication),
    Task('Eat breakfast', false, Icons.restaurant),
    Task('Check weather', false, Icons.wb_sunny),
    Task('Call family', false, Icons.phone),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Tasks'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.today, color: Colors.blue, size: 32),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today\'s Tasks',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        '${tasks.where((t) => t.isCompleted).length} of ${tasks.length} completed',
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
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              task.isCompleted
                                  ? Colors.green.withValues(alpha: 0.1)
                                  : Colors.grey.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          task.icon,
                          color: task.isCompleted ? Colors.green : Colors.grey,
                          size: 32,
                        ),
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration:
                              task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                        ),
                      ),
                      trailing: Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          setState(() {
                            task.isCompleted = value ?? false;
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          task.isCompleted = !task.isCompleted;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  String title;
  bool isCompleted;
  IconData icon;

  Task(this.title, this.isCompleted, this.icon);
}
