import 'package:flutter/material.dart';
import '../../services/voice_service.dart';

class VoiceCommandButton extends StatefulWidget {
  final Function(String)? onCommand;

  const VoiceCommandButton({super.key, this.onCommand});

  @override
  VoiceCommandButtonState createState() => VoiceCommandButtonState();
}

class VoiceCommandButtonState extends State<VoiceCommandButton>
    with SingleTickerProviderStateMixin {
  final VoiceService _voiceService = VoiceService();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _voiceService.initialize();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FloatingActionButton(
            onPressed: _voiceService.isListening ? null : _startListening,
            backgroundColor:
                _voiceService.isListening
                    ? Colors.red
                    : Theme.of(context).colorScheme.secondary,
            foregroundColor: Colors.white,
            child: Icon(
              _voiceService.isListening ? Icons.mic : Icons.mic_none,
              size: 28,
            ),
          ),
        );
      },
    );
  }

  void _startListening() async {
    if (!_voiceService.speechEnabled) {
      _showVoiceCommandHelp();
      return;
    }

    if (_voiceService.isListening) return;

    // Start animation
    _animationController.repeat(reverse: true);

    // Start listening
    await _voiceService.startListening(
      onResult: (result) {
        _animationController.stop();
        _animationController.reset();

        if (result.isNotEmpty) {
          final command = _voiceService.processCommand(result);
          widget.onCommand?.call(command);
          _showCommandResult(result, command);
        }
      },
    );
  }

  void _showCommandResult(String spokenText, String command) {
    String message;
    if (command != 'unknown') {
      message = 'Heard: "$spokenText"\nOpening $command feature...';
    } else {
      message =
          'Heard: "$spokenText"\nSorry, I didn\'t understand that command.';
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Voice Command'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                if (command == 'unknown') ...[
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showVoiceCommandHelp();
                    },
                    child: const Text('Show Available Commands'),
                  ),
                ],
              ],
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

  void _showVoiceCommandHelp() {
    final commands = _voiceService.getAvailableCommands();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Voice Commands'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'You can say any of these commands:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...commands.map(
                  (command) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.mic, size: 16, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(child: Text('"$command"')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Note: Voice commands are simulated in this demo. In a real app, you would speak these commands.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
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
}
