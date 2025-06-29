import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/specific/routine_step_card.dart';
import 'models/routine_step.dart';

class DailyRoutineScreen extends StatefulWidget {
  const DailyRoutineScreen({super.key});

  @override
  DailyRoutineScreenState createState() => DailyRoutineScreenState();
}

class DailyRoutineScreenState extends State<DailyRoutineScreen> {
  final List<RoutineStep> _morningRoutine = [
    RoutineStep(
      id: '1',
      title: 'Wake Up & Stretch',
      description: 'Take 5 deep breaths and stretch your arms',
      icon: Icons.self_improvement,
      isCompleted: false,
      estimatedDuration: 5,
    ),
    RoutineStep(
      id: '2',
      title: 'Brush Teeth',
      description: 'Brush for 2 minutes with fluoride toothpaste',
      icon: Icons.cleaning_services,
      isCompleted: false,
      estimatedDuration: 3,
    ),
    RoutineStep(
      id: '3',
      title: 'Take Morning Medicine',
      description: 'Take your prescribed morning medications',
      icon: Icons.medication,
      isCompleted: false,
      estimatedDuration: 2,
    ),
    RoutineStep(
      id: '4',
      title: 'Eat Breakfast',
      description: 'Have a healthy breakfast with protein',
      icon: Icons.restaurant,
      isCompleted: false,
      estimatedDuration: 20,
    ),
    RoutineStep(
      id: '5',
      title: 'Check Weather',
      description: 'Look at today\'s weather and dress appropriately',
      icon: Icons.wb_sunny,
      isCompleted: false,
      estimatedDuration: 2,
    ),
  ];

  int get _completedSteps =>
      _morningRoutine.where((step) => step.isCompleted).length;
  int get _totalSteps => _morningRoutine.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Routine'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildProgressHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _morningRoutine.length,
              itemBuilder: (context, index) {
                final step = _morningRoutine[index];
                return RoutineStepCard(
                  step: step,
                  onToggle: () => _toggleStep(index),
                  onTap: () => _showStepHelp(step),
                );
              },
            ),
          ),
          if (_completedSteps == _totalSteps) _buildCelebrationCard(),
        ],
      ),
    );
  }

  Widget _buildProgressHeader() {
    final progress = _completedSteps / _totalSteps;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.today,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Morning Routine',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$_completedSteps of $_totalSteps steps completed',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.withValues(alpha: 0.3),
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          Text(
            '${(progress * 100).round()}% Complete',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildCelebrationCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green, Colors.green.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.celebration, color: Colors.white, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Great Job!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'You completed your morning routine!',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleStep(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      _morningRoutine[index] = _morningRoutine[index].copyWith(
        isCompleted: !_morningRoutine[index].isCompleted,
        completedAt:
            !_morningRoutine[index].isCompleted ? DateTime.now() : null,
      );
    });

    if (_morningRoutine[index].isCompleted) {
      _showEncouragement();
    }
  }

  void _showStepHelp(RoutineStep step) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(step.title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step.description),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.timer, size: 20, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      'About ${step.estimatedDuration} minutes',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Got it!'),
              ),
            ],
          ),
    );
  }

  void _showEncouragement() {
    final encouragements = [
      'Well done!',
      'Great job!',
      'You\'re doing amazing!',
      'Keep it up!',
      'Excellent work!',
    ];

    final message =
        encouragements[DateTime.now().millisecond % encouragements.length];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
