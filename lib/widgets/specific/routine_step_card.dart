import 'package:flutter/material.dart';
import '../../models/routine_step.dart';

class RoutineStepCard extends StatelessWidget {
  final RoutineStep step;
  final VoidCallback? onTap;
  final VoidCallback? onToggle;

  const RoutineStepCard({
    super.key,
    required this.step,
    this.onTap,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color:
                      step.isCompleted
                          ? Colors.green.withValues(alpha: 0.1)
                          : Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  step.isCompleted ? Icons.check_circle : step.icon,
                  color:
                      step.isCompleted
                          ? Colors.green
                          : Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration:
                            step.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                        color:
                            step.isCompleted
                                ? Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.6)
                                : null,
                      ),
                    ),
                    if (step.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        step.description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                    if (step.estimatedDuration > 0) ...[
                      const SizedBox(height: 2),
                      Text(
                        '${step.estimatedDuration} min',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (onToggle != null) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onToggle,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color:
                          step.isCompleted ? Colors.green : Colors.transparent,
                      border: Border.all(
                        color:
                            step.isCompleted
                                ? Colors.green
                                : Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child:
                        step.isCompleted
                            ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                            : null,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
