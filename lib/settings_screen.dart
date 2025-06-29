import 'package:flutter/material.dart';
import 'widgets/common/simple_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool _largeText = true;
  bool _highContrast = false;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  double _textSize = 18.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.accessibility, color: Colors.grey[700], size: 32),
                  const SizedBox(width: 12),
                  Text(
                    'Accessibility Settings',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: ListView(
                children: [
                  _buildSettingCard(
                    'Large Text',
                    'Make text bigger and easier to read',
                    Icons.text_fields,
                    Switch(
                      value: _largeText,
                      onChanged: (value) {
                        setState(() {
                          _largeText = value;
                        });
                      },
                    ),
                  ),

                  _buildSettingCard(
                    'High Contrast',
                    'Use high contrast colors',
                    Icons.contrast,
                    Switch(
                      value: _highContrast,
                      onChanged: (value) {
                        setState(() {
                          _highContrast = value;
                        });
                      },
                    ),
                  ),

                  _buildSettingCard(
                    'Sound',
                    'Play sounds for notifications',
                    Icons.volume_up,
                    Switch(
                      value: _soundEnabled,
                      onChanged: (value) {
                        setState(() {
                          _soundEnabled = value;
                        });
                      },
                    ),
                  ),

                  _buildSettingCard(
                    'Vibration',
                    'Vibrate for alerts and touches',
                    Icons.vibration,
                    Switch(
                      value: _vibrationEnabled,
                      onChanged: (value) {
                        setState(() {
                          _vibrationEnabled = value;
                        });
                      },
                    ),
                  ),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.format_size, size: 32),
                              const SizedBox(width: 12),
                              const Text(
                                'Text Size',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Sample text at current size',
                            style: TextStyle(fontSize: _textSize),
                          ),
                          const SizedBox(height: 16),
                          Slider(
                            value: _textSize,
                            min: 14.0,
                            max: 24.0,
                            divisions: 5,
                            label: _textSize.round().toString(),
                            onChanged: (value) {
                              setState(() {
                                _textSize = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SimpleButton(
              text: 'Save Settings',
              icon: Icons.save,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Settings saved successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard(
    String title,
    String subtitle,
    IconData icon,
    Widget trailing,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue, size: 32),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 14)),
        trailing: trailing,
      ),
    );
  }
}
