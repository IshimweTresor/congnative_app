import 'package:flutter/material.dart';
import '../../models/medication.dart';

class MedicationCard extends StatelessWidget {
  final Medication medication;
  final VoidCallback? onTaken;
  final VoidCallback? onTap;

  const MedicationCard({
    super.key,
    required this.medication,
    this.onTaken,
    this.onTap,
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
                      medication.isTaken
                          ? Colors.green.withValues(alpha: 0.1)
                          : Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  medication.isTaken ? Icons.check : Icons.medication,
                  color:
                      medication.isTaken
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
                      medication.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration:
                            medication.isTaken
                                ? TextDecoration.lineThrough
                                : null,
                        color:
                            medication.isTaken
                                ? Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.6)
                                : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${medication.dosage} - ${medication.time}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    if (medication.instructions.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        medication.instructions,
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
              if (onTaken != null) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onTaken,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color:
                          medication.isTaken
                              ? Colors.green
                              : Colors.transparent,
                      border: Border.all(
                        color:
                            medication.isTaken
                                ? Colors.green
                                : Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child:
                        medication.isTaken
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
