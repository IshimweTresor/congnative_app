import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;
  final bool isComingSoon;

  const FeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.onTap,
    this.color,
    this.isComingSoon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: isComingSoon ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: (color ?? Theme.of(context).colorScheme.primary)
                          .withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: color ?? Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  if (isComingSoon)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Coming Soon',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color:
                      isComingSoon
                          ? Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6)
                          : null,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color:
                        isComingSoon
                            ? Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.5)
                            : Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
