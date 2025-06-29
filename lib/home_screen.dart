import 'package:flutter/material.dart';
import 'widgets/common/feature_card.dart';
import 'widgets/common/quick_action_button.dart';
import 'daily_routine_screen.dart';
import 'medication_screen.dart';
import 'emergency_screen.dart';
import 'screens/memory_aids_screen.dart';
import 'screens/social_connections_screen.dart';
import 'screens/weather_screen.dart';
import 'screens/photo_memory_screen.dart';
import 'screens/location_screen.dart';
import 'screens/timer_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/goals_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String _greeting = '';
  String _userName = 'Friend';

  @override
  void initState() {
    super.initState();
    _setGreeting();
    _loadUserName();
  }

  void _setGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      _greeting = 'Good Morning';
    } else if (hour < 17) {
      _greeting = 'Good Afternoon';
    } else {
      _greeting = 'Good Evening';
    }
  }

  void _loadUserName() {
    // In a real app, load from storage
    setState(() {
      _userName = 'Tresor';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cognitive Assistant'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreetingCard(),
              const SizedBox(height: 24),
              _buildDailyStatus(),
              _buildQuickActions(),
              const SizedBox(height: 24),
              _buildMainFeatures(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmergencyScreen()),
            ),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.emergency),
        label: const Text('Emergency'),
        tooltip: 'Quick Emergency Access',
      ),
    );
  }

  Widget _buildGreetingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  Icons.wb_sunny,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$_greeting, $_userName!',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'How are you feeling today?',
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
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: QuickActionButton(
                icon: Icons.emergency,
                title: 'Emergency',
                color: Colors.red,
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmergencyScreen(),
                      ),
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionButton(
                icon: Icons.medication,
                title: 'Medicine',
                color: Colors.green,
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicationScreen(),
                      ),
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: QuickActionButton(
                icon: Icons.timer,
                title: 'Timer',
                color: Colors.blue,
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TimerScreen()),
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionButton(
                icon: Icons.location_on,
                title: 'Where Am I?',
                color: Colors.purple,
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LocationScreen()),
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Support',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        FeatureCard(
          icon: Icons.checklist,
          title: 'Daily Routine',
          description: 'Follow your daily tasks step by step',
          color: Colors.blue,
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DailyRoutineScreen()),
              ),
        ),
        FeatureCard(
          icon: Icons.psychology,
          title: 'Memory Aids',
          description: 'Tools to help remember important things',
          color: Colors.purple,
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MemoryAidsScreen()),
              ),
        ),
        FeatureCard(
          icon: Icons.people,
          title: 'Stay Connected',
          description: 'Keep in touch with family and friends',
          color: Colors.orange,
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SocialConnectionsScreen(),
                ),
              ),
        ),
        FeatureCard(
          icon: Icons.wb_sunny,
          title: 'Weather & Clothing',
          description: 'Check weather and get clothing advice',
          color: Colors.lightBlue,
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeatherScreen()),
              ),
        ),
        FeatureCard(
          icon: Icons.photo_library,
          title: 'Photo Memories',
          description: 'Remember people, places, and events',
          color: Colors.teal,
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PhotoMemoryScreen()),
              ),
        ),
        FeatureCard(
          icon: Icons.calendar_month,
          title: 'My Calendar',
          description: 'Track appointments and important dates',
          color: Colors.indigo,
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarScreen()),
              ),
        ),
        FeatureCard(
          icon: Icons.emoji_events,
          title: 'My Goals',
          description: 'Track progress and celebrate achievements',
          color: Colors.amber,
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GoalsScreen()),
              ),
        ),
      ],
    );
  }

  Widget _buildDailyStatus() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.today,
                  color: Colors.green.shade700,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Progress',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    Text(
                      'Keep up the great work!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '3/5 Done',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatusItem(
                  Icons.medication,
                  'Medicine',
                  'Taken',
                  Colors.green,
                  true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatusItem(
                  Icons.checklist,
                  'Routine',
                  '4/5 Steps',
                  Colors.blue,
                  false,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatusItem(
                  Icons.phone,
                  'Family Call',
                  'Pending',
                  Colors.orange,
                  false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(
    IconData icon,
    String title,
    String status,
    Color color,
    bool isComplete,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isComplete ? Colors.green.shade200 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: isComplete ? Colors.green : color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 10,
              color: isComplete ? Colors.green : Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
