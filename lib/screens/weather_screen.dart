import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  // Mock weather data - in real app, fetch from weather API
  final Map<String, dynamic> _weather = {
    'temperature': 72,
    'condition': 'Sunny',
    'icon': Icons.wb_sunny,
    'humidity': 45,
    'windSpeed': 8,
    'uvIndex': 6,
    'feelsLike': 75,
  };

  final List<Map<String, dynamic>> _forecast = [
    {
      'day': 'Today',
      'high': 75,
      'low': 62,
      'condition': 'Sunny',
      'icon': Icons.wb_sunny,
    },
    {
      'day': 'Tomorrow',
      'high': 68,
      'low': 55,
      'condition': 'Cloudy',
      'icon': Icons.cloud,
    },
    {
      'day': 'Thursday',
      'high': 71,
      'low': 58,
      'condition': 'Partly Cloudy',
      'icon': Icons.wb_sunny_outlined,
    },
    {
      'day': 'Friday',
      'high': 66,
      'low': 52,
      'condition': 'Rain',
      'icon': Icons.grain,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather & Clothing'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshWeather,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentWeather(),
            const SizedBox(height: 24),
            _buildClothingAdvice(),
            const SizedBox(height: 24),
            _buildForecast(),
            const SizedBox(height: 24),
            _buildWeatherTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWeather() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_weather['temperature']}°F',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _weather['condition'],
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    'Feels like ${_weather['feelsLike']}°F',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
              Icon(_weather['icon'], size: 80, color: Colors.white),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildWeatherDetail(
                'Humidity',
                '${_weather['humidity']}%',
                Icons.water_drop,
              ),
              _buildWeatherDetail(
                'Wind',
                '${_weather['windSpeed']} mph',
                Icons.air,
              ),
              _buildWeatherDetail(
                'UV Index',
                '${_weather['uvIndex']}',
                Icons.wb_sunny,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildClothingAdvice() {
    final temp = _weather['temperature'] as int;
    String advice;
    IconData clothingIcon;
    Color adviceColor;

    if (temp >= 80) {
      advice =
          'Hot day! Wear light, breathable clothing. Don\'t forget sunscreen!';
      clothingIcon = Icons.wb_sunny;
      adviceColor = Colors.orange;
    } else if (temp >= 70) {
      advice = 'Perfect weather! T-shirt and light pants or shorts.';
      clothingIcon = Icons.checkroom;
      adviceColor = Colors.green;
    } else if (temp >= 60) {
      advice = 'Mild day. Light jacket or sweater recommended.';
      clothingIcon = Icons.checkroom;
      adviceColor = Colors.blue;
    } else if (temp >= 50) {
      advice = 'Cool weather. Wear a warm jacket or coat.';
      clothingIcon = Icons.checkroom;
      adviceColor = Colors.indigo;
    } else {
      advice = 'Cold day! Bundle up with warm clothes, hat, and gloves.';
      clothingIcon = Icons.ac_unit;
      adviceColor = Colors.purple;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: adviceColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: adviceColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: adviceColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(clothingIcon, color: adviceColor, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What to Wear',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: adviceColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(advice, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecast() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '4-Day Forecast',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...(_forecast.map((day) => _buildForecastDay(day)).toList()),
      ],
    );
  }

  Widget _buildForecastDay(Map<String, dynamic> day) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              day['day'],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Icon(day['icon'], color: Colors.blue, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Text(day['condition'], style: const TextStyle(fontSize: 16)),
          ),
          Text(
            '${day['high']}°/${day['low']}°',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherTips() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber[700], size: 24),
              const SizedBox(width: 8),
              Text(
                'Weather Tips',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '• Check the weather every morning before going out\n'
            '• Keep a light jacket or umbrella handy\n'
            '• Drink plenty of water on hot days\n'
            '• Wear sunscreen when UV index is above 3',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  void _refreshWeather() {
    // In real app, fetch fresh weather data
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Weather updated!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
