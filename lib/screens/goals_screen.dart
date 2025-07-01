import 'package:flutter/material.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  GoalsScreenState createState() => GoalsScreenState();
}

class GoalsScreenState extends State<GoalsScreen> {
  final List<Goal> _goals = [
    Goal(
      id: '1',
      title: 'Take medication daily',
      description: 'Remember to take morning and evening medications',
      targetCount: 14, // 2 weeks
      currentCount: 8,
      category: 'health',
      startDate: DateTime.now().subtract(const Duration(days: 4)),
      endDate: DateTime.now().add(const Duration(days: 10)),
      isActive: true,
    ),
    Goal(
      id: '2',
      title: 'Complete morning routine',
      description: 'Finish all 5 steps of morning routine',
      targetCount: 7, // 1 week
      currentCount: 5,
      category: 'routine',
      startDate: DateTime.now().subtract(const Duration(days: 5)),
      endDate: DateTime.now().add(const Duration(days: 2)),
      isActive: true,
    ),
    Goal(
      id: '3',
      title: 'Exercise 3 times per week',
      description: 'Light exercise or physical therapy',
      targetCount: 12, // 4 weeks
      currentCount: 7,
      category: 'fitness',
      startDate: DateTime.now().subtract(const Duration(days: 14)),
      endDate: DateTime.now().add(const Duration(days: 14)),
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Goals'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.insights),
            onPressed: _showProgressOverview,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverallProgress(),
            const SizedBox(height: 24),
            Text(
              'Active Goals',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ..._goals
                .where((goal) => goal.isActive)
                .map((goal) => _buildGoalCard(goal)),
            const SizedBox(height: 24),
            if (_goals.where((goal) => !goal.isActive).isNotEmpty) ...[
              Text(
                'Completed Goals',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 16),
              ..._goals
                  .where((goal) => !goal.isActive)
                  .map((goal) => _buildGoalCard(goal)),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddGoalDialog,
        tooltip: 'Add New Goal',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildOverallProgress() {
    final activeGoals = _goals.where((goal) => goal.isActive).toList();
    final totalProgress =
        activeGoals.isEmpty
            ? 0.0
            : activeGoals.map((goal) => goal.progress).reduce((a, b) => a + b) /
                activeGoals.length;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.trending_up,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overall Progress',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${activeGoals.length} active goals',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        value: totalProgress,
                        strokeWidth: 8,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getProgressColor(totalProgress),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(totalProgress * 100).toInt()}%',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _getProgressColor(totalProgress),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildProgressStat(
                        'Completed',
                        _goals.where((g) => !g.isActive).length.toString(),
                        Icons.check_circle,
                        Colors.green,
                      ),
                      const SizedBox(height: 8),
                      _buildProgressStat(
                        'In Progress',
                        activeGoals.length.toString(),
                        Icons.play_circle,
                        Colors.blue,
                      ),
                      const SizedBox(height: 8),
                      _buildProgressStat(
                        'This Week',
                        _getThisWeekProgress().toString(),
                        Icons.calendar_today,
                        Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStat(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildGoalCard(Goal goal) {
    final daysRemaining = goal.endDate.difference(DateTime.now()).inDays;
    final isOverdue = daysRemaining < 0;
    final progressColor = _getProgressColor(goal.progress);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getCategoryColor(
                      goal.category,
                    ).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getCategoryIcon(goal.category),
                    color: _getCategoryColor(goal.category),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration:
                              goal.isActive ? null : TextDecoration.lineThrough,
                          color:
                              goal.isActive
                                  ? null
                                  : Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                        ),
                      ),
                      if (goal.description.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          goal.description,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (goal.isActive)
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'increment') {
                        _incrementGoal(goal.id);
                      } else if (value == 'edit') {
                        _showEditGoalDialog(goal);
                      } else if (value == 'complete') {
                        _completeGoal(goal.id);
                      } else if (value == 'delete') {
                        _deleteGoal(goal.id);
                      }
                    },
                    itemBuilder:
                        (context) => [
                          const PopupMenuItem(
                            value: 'increment',
                            child: Row(
                              children: [
                                Icon(Icons.add_circle),
                                SizedBox(width: 8),
                                Text('Add Progress'),
                              ],
                            ),
                          ),
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
                            value: 'complete',
                            child: Row(
                              children: [
                                Icon(Icons.check, color: Colors.green),
                                SizedBox(width: 8),
                                Text('Mark Complete'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red),
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

            // Progress bar
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: goal.progress,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${goal.currentCount}/${goal.targetCount}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: progressColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Status row
            Row(
              children: [
                Icon(
                  isOverdue ? Icons.warning : Icons.schedule,
                  size: 16,
                  color:
                      isOverdue
                          ? Colors.red
                          : Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 4),
                Text(
                  isOverdue
                      ? 'Overdue by ${-daysRemaining} days'
                      : daysRemaining == 0
                      ? 'Due today'
                      : '$daysRemaining days remaining',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color:
                        isOverdue
                            ? Colors.red
                            : Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(
                      goal.category,
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    goal.category.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _getCategoryColor(goal.category),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getProgressColor(double progress) {
    if (progress >= 0.8) return Colors.green;
    if (progress >= 0.5) return Colors.orange;
    return Colors.red;
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'health':
        return Colors.red;
      case 'routine':
        return Colors.blue;
      case 'fitness':
        return Colors.green;
      case 'social':
        return Colors.purple;
      case 'learning':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'health':
        return Icons.local_hospital;
      case 'routine':
        return Icons.schedule;
      case 'fitness':
        return Icons.fitness_center;
      case 'social':
        return Icons.people;
      case 'learning':
        return Icons.school;
      default:
        return Icons.flag;
    }
  }

  int _getThisWeekProgress() {
    // final now = DateTime.now();
    // final weekStart = now.subtract(Duration(days: now.weekday - 1));
    // final weekEnd = weekStart.add(const Duration(days: 7));

    // This would be calculated based on actual progress tracking
    return 12; // Placeholder
  }

  void _incrementGoal(String goalId) {
    setState(() {
      final goalIndex = _goals.indexWhere((goal) => goal.id == goalId);
      if (goalIndex != -1) {
        final goal = _goals[goalIndex];
        if (goal.currentCount < goal.targetCount) {
          _goals[goalIndex] = goal.copyWith(
            currentCount: goal.currentCount + 1,
          );

          // Check if goal is completed
          if (_goals[goalIndex].currentCount >= _goals[goalIndex].targetCount) {
            _completeGoal(goalId);
          }
        }
      }
    });
  }

  void _completeGoal(String goalId) {
    setState(() {
      final goalIndex = _goals.indexWhere((goal) => goal.id == goalId);
      if (goalIndex != -1) {
        _goals[goalIndex] = _goals[goalIndex].copyWith(isActive: false);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎉 Goal completed! Great job!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _deleteGoal(String goalId) {
    setState(() {
      _goals.removeWhere((goal) => goal.id == goalId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Goal deleted'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showAddGoalDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    int targetCount = 1;
    String selectedCategory = 'health';
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now().add(const Duration(days: 30));

    final categories = [
      'health',
      'fitness',
      'social',
      'learning',
      'daily',
      'personal',
    ];

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text('Add New Goal'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: 'Goal Title',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.emoji_events),
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
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Target Count',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.track_changes),
                                ),
                                onChanged: (value) {
                                  targetCount = int.tryParse(value) ?? 1;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: selectedCategory,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.category),
                          ),
                          items:
                              categories.map((category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Text(category.toUpperCase()),
                                );
                              }).toList(),
                          onChanged: (value) {
                            setDialogState(() {
                              selectedCategory = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  '${startDate.day}/${startDate.month}/${startDate.year}',
                                ),
                                subtitle: const Text('Start Date'),
                                leading: const Icon(Icons.calendar_today),
                                onTap: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: startDate,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 365),
                                    ),
                                  );
                                  if (date != null) {
                                    setDialogState(() {
                                      startDate = date;
                                      if (endDate.isBefore(date)) {
                                        endDate = date.add(
                                          const Duration(days: 30),
                                        );
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  '${endDate.day}/${endDate.month}/${endDate.year}',
                                ),
                                subtitle: const Text('End Date'),
                                leading: const Icon(Icons.event),
                                onTap: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: endDate,
                                    firstDate: startDate,
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 365),
                                    ),
                                  );
                                  if (date != null) {
                                    setDialogState(() {
                                      endDate = date;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
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
                          final newGoal = Goal(
                            id:
                                DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                            title: titleController.text,
                            description: descriptionController.text,
                            targetCount: targetCount,
                            currentCount: 0,
                            category: selectedCategory,
                            startDate: startDate,
                            endDate: endDate,
                            isActive: true,
                          );
                          setState(() {
                            _goals.add(newGoal);
                          });
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Goal added successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      child: const Text('Add Goal'),
                    ),
                  ],
                ),
          ),
    );
  }

  void _showEditGoalDialog(Goal goal) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Goal'),
            content: const Text('Goal editing feature coming soon!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showProgressOverview() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Progress Overview'),
            content: const Text('Detailed analytics coming soon!'),
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

class Goal {
  final String id;
  final String title;
  final String description;
  final int targetCount;
  final int currentCount;
  final String category;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.targetCount,
    required this.currentCount,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  double get progress => targetCount == 0 ? 0.0 : currentCount / targetCount;

  Goal copyWith({
    String? id,
    String? title,
    String? description,
    int? targetCount,
    int? currentCount,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
  }) {
    return Goal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      targetCount: targetCount ?? this.targetCount,
      currentCount: currentCount ?? this.currentCount,
      category: category ?? this.category,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
    );
  }
}
