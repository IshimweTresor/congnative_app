import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  final List<Appointment> _appointments = [
    Appointment(
      id: '1',
      title: 'Doctor Appointment',
      description: 'Regular checkup with Dr. Smith',
      dateTime: DateTime.now().add(const Duration(days: 2, hours: 10)),
      location: 'Medical Center, Room 205',
      type: 'medical',
      reminderBefore: const Duration(hours: 1),
    ),
    Appointment(
      id: '2',
      title: 'Physical Therapy',
      description: 'Weekly physical therapy session',
      dateTime: DateTime.now().add(const Duration(days: 5, hours: 14)),
      location: 'Therapy Center',
      type: 'therapy',
      reminderBefore: const Duration(hours: 2),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Calendar'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime.now();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCalendarHeader(),
          _buildQuickDateSelector(),
          const Divider(),
          Expanded(child: _buildAppointmentsList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAppointmentDialog,
        tooltip: 'Add Appointment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime(
                  _selectedDate.year,
                  _selectedDate.month - 1,
                );
              });
            },
          ),
          Text(
            '${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime(
                  _selectedDate.year,
                  _selectedDate.month + 1,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickDateSelector() {
    final today = DateTime.now();
    final dates = List.generate(7, (index) => today.add(Duration(days: index)));

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected =
              date.day == _selectedDate.day &&
              date.month == _selectedDate.month &&
              date.year == _selectedDate.year;
          final hasAppointments = _getAppointmentsForDate(date).isNotEmpty;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                            context,
                          ).colorScheme.outline.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getDayName(date.weekday),
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          isSelected
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          isSelected
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  if (hasAppointments) ...[
                    const SizedBox(height: 2),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppointmentsList() {
    final appointmentsForDate = _getAppointmentsForDate(_selectedDate);

    if (appointmentsForDate.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_available,
              size: 64,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No appointments for this day',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap + to add a new appointment',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: appointmentsForDate.length,
      itemBuilder: (context, index) {
        final appointment = appointmentsForDate[index];
        return _buildAppointmentCard(appointment);
      },
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    final timeString =
        '${appointment.dateTime.hour.toString().padLeft(2, '0')}:${appointment.dateTime.minute.toString().padLeft(2, '0')}';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getAppointmentColor(
                  appointment.type,
                ).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getAppointmentIcon(appointment.type),
                color: _getAppointmentColor(appointment.type),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeString,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (appointment.location.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            appointment.location,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (appointment.description.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      appointment.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  _showEditAppointmentDialog(appointment);
                } else if (value == 'delete') {
                  _deleteAppointment(appointment.id);
                }
              },
              itemBuilder:
                  (context) => [
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
      ),
    );
  }

  List<Appointment> _getAppointmentsForDate(DateTime date) {
    return _appointments.where((appointment) {
        return appointment.dateTime.year == date.year &&
            appointment.dateTime.month == date.month &&
            appointment.dateTime.day == date.day;
      }).toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  Color _getAppointmentColor(String type) {
    switch (type) {
      case 'medical':
        return Colors.red;
      case 'therapy':
        return Colors.blue;
      case 'social':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  IconData _getAppointmentIcon(String type) {
    switch (type) {
      case 'medical':
        return Icons.local_hospital;
      case 'therapy':
        return Icons.fitness_center;
      case 'social':
        return Icons.people;
      default:
        return Icons.event;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  void _showAddAppointmentDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final locationController = TextEditingController();
    DateTime selectedDate = _selectedDate;
    TimeOfDay selectedTime = TimeOfDay.now();
    String selectedType = 'medical';
    Duration reminderBefore = const Duration(hours: 1);

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text('Add Appointment'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.title),
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
                        TextField(
                          controller: locationController,
                          decoration: const InputDecoration(
                            labelText: 'Location',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.location_on),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                ),
                                subtitle: const Text('Date'),
                                leading: const Icon(Icons.calendar_today),
                                onTap: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 365),
                                    ),
                                  );
                                  if (date != null) {
                                    setDialogState(() {
                                      selectedDate = date;
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
                                  '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
                                ),
                                subtitle: const Text('Time'),
                                leading: const Icon(Icons.access_time),
                                onTap: () async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: selectedTime,
                                  );
                                  if (time != null) {
                                    setDialogState(() {
                                      selectedTime = time;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: selectedType,
                          decoration: const InputDecoration(
                            labelText: 'Type',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.category),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'medical',
                              child: Text('Medical'),
                            ),
                            DropdownMenuItem(
                              value: 'therapy',
                              child: Text('Therapy'),
                            ),
                            DropdownMenuItem(
                              value: 'social',
                              child: Text('Social'),
                            ),
                            DropdownMenuItem(
                              value: 'other',
                              child: Text('Other'),
                            ),
                          ],
                          onChanged: (value) {
                            setDialogState(() {
                              selectedType = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<Duration>(
                          value: reminderBefore,
                          decoration: const InputDecoration(
                            labelText: 'Reminder',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.notification_important),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: Duration(minutes: 15),
                              child: Text('15 minutes before'),
                            ),
                            DropdownMenuItem(
                              value: Duration(minutes: 30),
                              child: Text('30 minutes before'),
                            ),
                            DropdownMenuItem(
                              value: Duration(hours: 1),
                              child: Text('1 hour before'),
                            ),
                            DropdownMenuItem(
                              value: Duration(hours: 2),
                              child: Text('2 hours before'),
                            ),
                            DropdownMenuItem(
                              value: Duration(days: 1),
                              child: Text('1 day before'),
                            ),
                          ],
                          onChanged: (value) {
                            setDialogState(() {
                              reminderBefore = value!;
                            });
                          },
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
                          final newAppointment = Appointment(
                            id:
                                DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                            title: titleController.text,
                            description: descriptionController.text,
                            dateTime: DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              selectedTime.hour,
                              selectedTime.minute,
                            ),
                            location: locationController.text,
                            type: selectedType,
                            reminderBefore: reminderBefore,
                          );
                          setState(() {
                            _appointments.add(newAppointment);
                          });
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Appointment added successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
          ),
    );
  }

  void _showEditAppointmentDialog(Appointment appointment) {
    final titleController = TextEditingController(text: appointment.title);
    final descriptionController = TextEditingController(
      text: appointment.description,
    );
    final locationController = TextEditingController(
      text: appointment.location,
    );
    DateTime selectedDate = DateTime(
      appointment.dateTime.year,
      appointment.dateTime.month,
      appointment.dateTime.day,
    );
    TimeOfDay selectedTime = TimeOfDay(
      hour: appointment.dateTime.hour,
      minute: appointment.dateTime.minute,
    );
    String selectedType = appointment.type;
    Duration reminderBefore = appointment.reminderBefore;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text('Edit Appointment'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.title),
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
                        TextField(
                          controller: locationController,
                          decoration: const InputDecoration(
                            labelText: 'Location',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.location_on),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                ),
                                subtitle: const Text('Date'),
                                leading: const Icon(Icons.calendar_today),
                                onTap: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: selectedDate,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 365),
                                    ),
                                  );
                                  if (date != null) {
                                    setDialogState(() {
                                      selectedDate = date;
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
                                  '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
                                ),
                                subtitle: const Text('Time'),
                                leading: const Icon(Icons.access_time),
                                onTap: () async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: selectedTime,
                                  );
                                  if (time != null) {
                                    setDialogState(() {
                                      selectedTime = time;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: selectedType,
                          decoration: const InputDecoration(
                            labelText: 'Type',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.category),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'medical',
                              child: Text('Medical'),
                            ),
                            DropdownMenuItem(
                              value: 'therapy',
                              child: Text('Therapy'),
                            ),
                            DropdownMenuItem(
                              value: 'social',
                              child: Text('Social'),
                            ),
                            DropdownMenuItem(
                              value: 'other',
                              child: Text('Other'),
                            ),
                          ],
                          onChanged: (value) {
                            setDialogState(() {
                              selectedType = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<Duration>(
                          value: reminderBefore,
                          decoration: const InputDecoration(
                            labelText: 'Reminder',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.notification_important),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: Duration(minutes: 15),
                              child: Text('15 minutes before'),
                            ),
                            DropdownMenuItem(
                              value: Duration(minutes: 30),
                              child: Text('30 minutes before'),
                            ),
                            DropdownMenuItem(
                              value: Duration(hours: 1),
                              child: Text('1 hour before'),
                            ),
                            DropdownMenuItem(
                              value: Duration(hours: 2),
                              child: Text('2 hours before'),
                            ),
                            DropdownMenuItem(
                              value: Duration(days: 1),
                              child: Text('1 day before'),
                            ),
                          ],
                          onChanged: (value) {
                            setDialogState(() {
                              reminderBefore = value!;
                            });
                          },
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
                          final updatedAppointment = appointment.copyWith(
                            title: titleController.text,
                            description: descriptionController.text,
                            dateTime: DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              selectedTime.hour,
                              selectedTime.minute,
                            ),
                            location: locationController.text,
                            type: selectedType,
                            reminderBefore: reminderBefore,
                          );
                          setState(() {
                            final index = _appointments.indexWhere(
                              (apt) => apt.id == appointment.id,
                            );
                            if (index != -1) {
                              _appointments[index] = updatedAppointment;
                            }
                          });
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Appointment updated successfully!',
                              ),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        }
                      },
                      child: const Text('Update'),
                    ),
                  ],
                ),
          ),
    );
  }

  void _deleteAppointment(String id) {
    setState(() {
      _appointments.removeWhere((appointment) => appointment.id == id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Appointment deleted'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class Appointment {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String location;
  final String type;
  final Duration reminderBefore;

  Appointment({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    required this.type,
    required this.reminderBefore,
  });

  Appointment copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dateTime,
    String? location,
    String? type,
    Duration? reminderBefore,
  }) {
    return Appointment(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      type: type ?? this.type,
      reminderBefore: reminderBefore ?? this.reminderBefore,
    );
  }
}
