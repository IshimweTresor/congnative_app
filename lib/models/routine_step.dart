import 'package:flutter/material.dart';

class RoutineStep {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final int estimatedDuration; // in minutes
  final bool isCompleted;
  final DateTime? completedAt;
  final List<String> tips;
  final String? audioGuide;

  RoutineStep({
    required this.id,
    required this.title,
    this.description = '',
    required this.icon,
    this.estimatedDuration = 0,
    this.isCompleted = false,
    this.completedAt,
    this.tips = const [],
    this.audioGuide,
  });

  RoutineStep copyWith({
    String? id,
    String? title,
    String? description,
    IconData? icon,
    int? estimatedDuration,
    bool? isCompleted,
    DateTime? completedAt,
    List<String>? tips,
    String? audioGuide,
  }) {
    return RoutineStep(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      tips: tips ?? this.tips,
      audioGuide: audioGuide ?? this.audioGuide,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon.codePoint,
      'estimatedDuration': estimatedDuration,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
      'tips': tips,
      'audioGuide': audioGuide,
    };
  }

  factory RoutineStep.fromJson(Map<String, dynamic> json) {
    return RoutineStep(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      estimatedDuration: json['estimatedDuration'] ?? 0,
      isCompleted: json['isCompleted'] ?? false,
      completedAt:
          json['completedAt'] != null
              ? DateTime.parse(json['completedAt'])
              : null,
      tips: List<String>.from(json['tips'] ?? []),
      audioGuide: json['audioGuide'],
    );
  }

  @override
  String toString() {
    return 'RoutineStep(id: $id, title: $title, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RoutineStep && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
