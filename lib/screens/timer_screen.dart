import 'package:flutter/material.dart';
import 'dart:async';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  TimerScreenState createState() => TimerScreenState();
}

class TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  int _seconds = 0;
  int _minutes = 5;
  bool _isRunning = false;
  bool _isPaused = false;
  String _currentTimerType = 'medication';

  // Preset timers for common activities
  final Map<String, Map<String, dynamic>> _presets = {
    'medication': {
      'name': 'Medication Reminder',
      'minutes': 5,
      'icon': Icons.medication,
      'color': Colors.green,
      'description': 'Reminder to take medicine',
    },
    'cooking': {
      'name': 'Cooking Timer',
      'minutes': 15,
      'icon': Icons.restaurant,
      'color': Colors.orange,
      'description': 'Timer for cooking activities',
    },
    'exercise': {
      'name': 'Exercise Break',
      'minutes': 10,
      'icon': Icons.fitness_center,
      'color': Colors.blue,
      'description': 'Time for light exercise',
    },
    'water': {
      'name': 'Drink Water',
      'minutes': 30,
      'icon': Icons.water_drop,
      'color': Colors.cyan,
      'description': 'Remember to drink water',
    },
    'rest': {
      'name': 'Rest Time',
      'minutes': 20,
      'icon': Icons.chair,
      'color': Colors.purple,
      'description': 'Time to rest and relax',
    },
    'call': {
      'name': 'Call Family',
      'minutes': 60,
      'icon': Icons.phone,
      'color': Colors.pink,
      'description': 'Reminder to call family',
    },
  };

  int get _totalSeconds => (_minutes * 60) + _seconds;
  String get _displayTime {
    final int minutes = _totalSeconds ~/ 60;
    final int seconds = _totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer & Reminders'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCurrentTimer(),
            const SizedBox(height: 24),
            _buildTimerControls(),
            const SizedBox(height: 24),
            _buildPresetTimers(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentTimer() {
    final preset = _presets[_currentTimerType]!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [preset['color'], preset['color'].withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: preset['color'].withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(preset['icon'], size: 48, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            preset['name'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            preset['description'],
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              _displayTime,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ),
          if (_isRunning) ...[
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value:
                  _totalSeconds > 0
                      ? 1.0 - (_totalSeconds / ((_minutes * 60) + _seconds))
                      : 0.0,
              backgroundColor: Colors.white.withValues(alpha: 0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimerControls() {
    return Column(
      children: [
        if (!_isRunning) _buildTimeSetters(),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (!_isRunning) ...[
              _buildControlButton(
                'Start',
                Icons.play_arrow,
                Colors.green,
                _startTimer,
              ),
            ] else ...[
              _buildControlButton(
                _isPaused ? 'Resume' : 'Pause',
                _isPaused ? Icons.play_arrow : Icons.pause,
                Colors.blue,
                _togglePause,
              ),
              _buildControlButton('Stop', Icons.stop, Colors.red, _stopTimer),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildTimeSetters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTimeSetter('Minutes', _minutes, (value) {
          setState(() {
            _minutes = value;
          });
        }),
        _buildTimeSetter('Seconds', _seconds, (value) {
          setState(() {
            _seconds = value;
          });
        }),
      ],
    );
  }

  Widget _buildTimeSetter(String label, int value, Function(int) onChanged) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  if (value > 0) {
                    onChanged(value - (label == 'Minutes' ? 1 : 15));
                  }
                },
                icon: const Icon(Icons.remove),
              ),
              Container(
                width: 60,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  value.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (label == 'Minutes' && value < 60) {
                    onChanged(value + 1);
                  } else if (label == 'Seconds' && value < 59) {
                    onChanged(value + 15);
                  }
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          elevation: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetTimers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Timers',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: _presets.length,
          itemBuilder: (context, index) {
            final key = _presets.keys.elementAt(index);
            final preset = _presets[key]!;
            final isSelected = _currentTimerType == key;

            return Container(
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? preset['color'].withValues(alpha: 0.1)
                        : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? preset['color'] : Colors.grey[200]!,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () => _selectPreset(key),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(preset['icon'], size: 32, color: preset['color']),
                      const SizedBox(height: 8),
                      Text(
                        preset['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${preset['minutes']} min',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _selectPreset(String presetKey) {
    if (_isRunning) return;

    setState(() {
      _currentTimerType = presetKey;
      _minutes = _presets[presetKey]!['minutes'];
      _seconds = 0;
    });
  }

  void _startTimer() {
    if (_totalSeconds <= 0) return;

    setState(() {
      _isRunning = true;
      _isPaused = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_totalSeconds > 0) {
          if (_seconds > 0) {
            _seconds--;
          } else if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          }
        } else {
          _timerComplete();
        }
      });
    });
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });

    if (_isPaused) {
      _timer?.cancel();
    } else {
      _startTimer();
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _minutes = _presets[_currentTimerType]!['minutes'];
      _seconds = 0;
    });
  }

  void _timerComplete() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isPaused = false;
    });

    // Show completion dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                Icon(
                  _presets[_currentTimerType]!['icon'],
                  color: _presets[_currentTimerType]!['color'],
                ),
                const SizedBox(width: 8),
                const Text('Timer Complete!'),
              ],
            ),
            content: Text(
              '${_presets[_currentTimerType]!['name']} timer has finished.\n\n'
              '${_presets[_currentTimerType]!['description']}',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _resetTimer();
                },
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _resetTimer();
                  _startTimer();
                },
                child: const Text('Start Again'),
              ),
            ],
          ),
    );
  }

  void _resetTimer() {
    setState(() {
      _minutes = _presets[_currentTimerType]!['minutes'];
      _seconds = 0;
    });
  }
}
