import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/medication.dart';
import 'widgets/specific/medication_card.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key});

  @override
  MedicationScreenState createState() => MedicationScreenState();
}

class MedicationScreenState extends State<MedicationScreen> {
  final List<Medication> _medications = [
    Medication(
      id: '1',
      name: 'Vitamin D',
      dosage: '1000 IU',
      time: '8:00 AM',
      instructions: 'Take with breakfast',
      isTaken: false,
    ),
    Medication(
      id: '2',
      name: 'Blood Pressure',
      dosage: '10mg',
      time: '9:00 AM',
      instructions: 'Take with water',
      isTaken: false,
    ),
    Medication(
      id: '3',
      name: 'Multivitamin',
      dosage: '1 tablet',
      time: '8:00 AM',
      instructions: 'Take with breakfast',
      isTaken: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final upcomingMeds = _medications.where((med) => !med.isTaken).toList();
    final takenMeds = _medications.where((med) => med.isTaken).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Medications'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _addMedication),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMedicationSummary(),
            const SizedBox(height: 24),
            if (upcomingMeds.isNotEmpty) ...[
              _buildSectionHeader('Due Soon', Icons.schedule, Colors.orange),
              ...upcomingMeds.map(
                (med) => MedicationCard(
                  medication: med,
                  onTaken: () => _markAsTaken(med.id),
                  onTap: () => _showMedicationInfo(med),
                ),
              ),
              const SizedBox(height: 24),
            ],
            if (takenMeds.isNotEmpty) ...[
              _buildSectionHeader(
                'Completed Today',
                Icons.check_circle,
                Colors.green,
              ),
              ...takenMeds.map(
                (med) => MedicationCard(
                  medication: med,
                  onTaken: () => _markAsNotTaken(med.id),
                  onTap: () => _showMedicationInfo(med),
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _setMedicationReminder,
        icon: const Icon(Icons.alarm),
        label: const Text('Set Reminder'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildMedicationSummary() {
    final totalMeds = _medications.length;
    final takenToday = _medications.where((med) => med.isTaken).length;
    final upcomingCount = _medications.where((med) => !med.isTaken).length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.medication,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today\'s Medications',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$takenToday of $totalMeds taken',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (upcomingCount > 0) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.schedule, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '$upcomingCount medication${upcomingCount > 1 ? 's' : ''} due soon',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _markAsTaken(String medicationId) {
    HapticFeedback.lightImpact();
    setState(() {
      final index = _medications.indexWhere((med) => med.id == medicationId);
      if (index != -1) {
        _medications[index] = _medications[index].copyWith(
          isTaken: true,
          takenAt: DateTime.now(),
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Medication marked as taken!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _markAsNotTaken(String medicationId) {
    setState(() {
      final index = _medications.indexWhere((med) => med.id == medicationId);
      if (index != -1) {
        _medications[index] = _medications[index].copyWith(
          isTaken: false,
          takenAt: null,
        );
      }
    });
  }

  void _showMedicationInfo(Medication medication) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(medication.name),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Dosage', medication.dosage),
                _buildInfoRow('Time', medication.time),
                if (medication.instructions.isNotEmpty)
                  _buildInfoRow('Instructions', medication.instructions),
                const SizedBox(height: 16),
                const Text(
                  'Important: Always take medications as prescribed by your doctor.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Got it'),
              ),
            ],
          ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _addMedication() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add Medication'),
            content: const Text(
              'This feature would allow you to add a new medication with details like name, dosage, and schedule.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  void _setMedicationReminder() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Set Reminder'),
            content: const Text(
              'This would set up notifications to remind you when it\'s time to take your medications.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Set'),
              ),
            ],
          ),
    );
  }
}
