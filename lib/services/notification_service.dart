class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  // In a real app, you would use flutter_local_notifications
  final List<AppNotification> _notifications = [];

  // Add notification
  void scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? type,
    Map<String, dynamic>? data,
  }) {
    final notification = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      body: body,
      scheduledTime: scheduledTime,
      type: type ?? 'general',
      data: data,
    );

    _notifications.add(notification);
    // In real app: Schedule actual notification here
  }

  // Schedule medication reminder
  void scheduleMedicationReminder({
    required String medicationName,
    required DateTime time,
    required String dosage,
  }) {
    scheduleNotification(
      title: 'Time for your medication',
      body: '$medicationName - $dosage',
      scheduledTime: time,
      type: 'medication',
      data: {'medicationName': medicationName, 'dosage': dosage},
    );
  }

  // Schedule routine reminder
  void scheduleRoutineReminder({
    required String routineStep,
    required DateTime time,
  }) {
    scheduleNotification(
      title: 'Routine Reminder',
      body: routineStep,
      scheduledTime: time,
      type: 'routine',
      data: {'routineStep': routineStep},
    );
  }

  // Schedule appointment reminder
  void scheduleAppointmentReminder({
    required String appointmentTitle,
    required DateTime time,
    required String location,
  }) {
    // Remind 1 hour before
    scheduleNotification(
      title: 'Upcoming Appointment',
      body: '$appointmentTitle at $location in 1 hour',
      scheduledTime: time.subtract(const Duration(hours: 1)),
      type: 'appointment',
      data: {
        'appointmentTitle': appointmentTitle,
        'location': location,
        'appointmentTime': time.toIso8601String(),
      },
    );
  }

  // Get pending notifications
  List<AppNotification> getPendingNotifications() {
    final now = DateTime.now();
    return _notifications.where((n) => n.scheduledTime.isAfter(now)).toList();
  }

  // Cancel notification
  void cancelNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
  }

  // Clear all notifications
  void clearAllNotifications() {
    _notifications.clear();
  }
}

class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime scheduledTime;
  final String type;
  final Map<String, dynamic>? data;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledTime,
    required this.type,
    this.data,
    this.isRead = false,
  });

  AppNotification copyWith({
    String? id,
    String? title,
    String? body,
    DateTime? scheduledTime,
    String? type,
    Map<String, dynamic>? data,
    bool? isRead,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      type: type ?? this.type,
      data: data ?? this.data,
      isRead: isRead ?? this.isRead,
    );
  }
}
