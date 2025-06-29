import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String? description;
  final IconData icon;
  final bool isCompleted;
  final VoidCallback? onTap;
  final VoidCallback? onComplete;
  final Color? iconColor;

  const TaskCard({
    super.key,
    required this.title,
    this.description,
    required this.icon,
    this.isCompleted = false,
    this.onTap,
    this.onComplete,
    this.iconColor,
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
                  color: (iconColor ?? Theme.of(context).colorScheme.primary)
                      .withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration:
                            isCompleted ? TextDecoration.lineThrough : null,
                        color:
                            isCompleted
                                ? Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.6)
                                : null,
                      ),
                    ),
                    if (description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        description!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (onComplete != null) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onComplete,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color:
                          isCompleted
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child:
                        isCompleted
                            ? Icon(
                              Icons.check,
                              color: Theme.of(context).colorScheme.onPrimary,
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
