import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  // Mock location data - in real app, use GPS
  final Map<String, dynamic> _currentLocation = {
    'address': '123 Main Street, Downtown',
    'neighborhood': 'Downtown Area',
    'landmarks': ['City Library', 'Coffee Shop', 'Bus Stop'],
    'isHomeLocation': false,
  };

  final Map<String, dynamic> _homeLocation = {
    'address': '456 Oak Avenue, Residential',
    'neighborhood': 'Oak Valley',
    'phone': '555-0123',
    'emergencyContact': 'Mom - 555-0101',
  };

  final List<Map<String, dynamic>> _savedPlaces = [
    {
      'name': 'Home',
      'address': '456 Oak Avenue',
      'type': 'home',
      'icon': Icons.home,
      'color': Colors.green,
      'phone': '555-0123',
    },
    {
      'name': 'Doctor\'s Office',
      'address': '789 Medical Plaza',
      'type': 'medical',
      'icon': Icons.local_hospital,
      'color': Colors.red,
      'phone': '555-0301',
    },
    {
      'name': 'Grocery Store',
      'address': '321 Commerce Street',
      'type': 'shopping',
      'icon': Icons.store,
      'color': Colors.blue,
      'phone': '555-0401',
    },
    {
      'name': 'Library',
      'address': '654 Knowledge Lane',
      'type': 'community',
      'icon': Icons.local_library,
      'color': Colors.purple,
      'phone': '555-0501',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Where Am I?'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _refreshLocation,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentLocationCard(),
            const SizedBox(height: 24),
            _buildQuickActions(),
            const SizedBox(height: 24),
            _buildSavedPlaces(),
            const SizedBox(height: 24),
            _buildLocationTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentLocationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
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
                  Icons.location_on,
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
                      'You are here:',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _currentLocation['address'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Neighborhood: ${_currentLocation['neighborhood']}',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Nearby: ${(_currentLocation['landmarks'] as List).join(', ')}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.9),
            ),
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
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'Get Home',
                Icons.home,
                Colors.green,
                _getDirectionsHome,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                'Call Help',
                Icons.phone,
                Colors.orange,
                _callForHelp,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'Share Location',
                Icons.share_location,
                Colors.blue,
                _shareLocation,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                'Emergency',
                Icons.emergency,
                Colors.red,
                _emergency,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      height: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withValues(alpha: 0.1),
          foregroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: color.withValues(alpha: 0.3)),
          ),
          elevation: 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedPlaces() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Important Places',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ..._savedPlaces.map((place) => _buildPlaceCard(place)),
      ],
    );
  }

  Widget _buildPlaceCard(Map<String, dynamic> place) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: place['color'].withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(place['icon'], color: place['color'], size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  place['address'],
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                if (place['phone'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    place['phone'],
                    style: TextStyle(fontSize: 14, color: Colors.blue[600]),
                  ),
                ],
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.directions),
                onPressed: () => _getDirections(place),
                color: Colors.blue,
              ),
              if (place['phone'] != null)
                IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: () => _callPlace(place),
                  color: Colors.green,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationTips() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber[700]),
              const SizedBox(width: 8),
              Text(
                'Location Safety Tips',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '• Always carry your home address and phone number\n'
            '• Stay in familiar areas when possible\n'
            '• Ask for help if you feel confused or lost\n'
            '• Use this app to share your location with family',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _refreshLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Location updated!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _getDirectionsHome() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Directions Home'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('From: ${_currentLocation['address']}'),
                const SizedBox(height: 8),
                Text('To: ${_homeLocation['address']}'),
                const SizedBox(height: 16),
                const Text(
                  'Simple directions:\n'
                  '1. Walk to the bus stop on Main Street\n'
                  '2. Take Bus #12 towards Oak Valley\n'
                  '3. Get off at Oak Avenue stop\n'
                  '4. Walk 2 blocks to your home',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Got it'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _callForHelp();
                },
                child: const Text('Need Help'),
              ),
            ],
          ),
    );
  }

  void _shareLocation() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Share Location'),
            content: Text(
              'Your location has been shared with your emergency contact:\n\n'
              '${_homeLocation['emergencyContact']}\n\n'
              'Current location: ${_currentLocation['address']}',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _callForHelp() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Call for Help?'),
            content: Text(
              'Would you like to call your emergency contact?\n\n'
              '${_homeLocation['emergencyContact']}',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Calling emergency contact...'),
                    ),
                  );
                },
                child: const Text('Call'),
              ),
            ],
          ),
    );
  }

  void _emergency() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Emergency'),
            content: const Text(
              'This will call 911 emergency services.\n\n'
              'Only use in real emergencies.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Calling 911...')),
                  );
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Call 911'),
              ),
            ],
          ),
    );
  }

  void _getDirections(Map<String, dynamic> place) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Getting directions to ${place['name']}...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _callPlace(Map<String, dynamic> place) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calling ${place['name']}...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
