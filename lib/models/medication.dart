class Medication {
  final String id;
  final String name;
  final String dosage;
  final String time;
  final String instructions;
  final bool isTaken;
  final DateTime? takenAt;
  final String? notes;

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.time,
    this.instructions = '',
    this.isTaken = false,
    this.takenAt,
    this.notes,
  });

  Medication copyWith({
    String? id,
    String? name,
    String? dosage,
    String? time,
    String? instructions,
    bool? isTaken,
    DateTime? takenAt,
    String? notes,
  }) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      time: time ?? this.time,
      instructions: instructions ?? this.instructions,
      isTaken: isTaken ?? this.isTaken,
      takenAt: takenAt ?? this.takenAt,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'time': time,
      'instructions': instructions,
      'isTaken': isTaken,
      'takenAt': takenAt?.toIso8601String(),
      'notes': notes,
    };
  }

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'],
      name: json['name'],
      dosage: json['dosage'],
      time: json['time'],
      instructions: json['instructions'] ?? '',
      isTaken: json['isTaken'] ?? false,
      takenAt: json['takenAt'] != null ? DateTime.parse(json['takenAt']) : null,
      notes: json['notes'],
    );
  }

  @override
  String toString() {
    return 'Medication(id: $id, name: $name, dosage: $dosage, time: $time, isTaken: $isTaken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Medication && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
