
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';






class ClueBell extends StatefulWidget {
  const ClueBell(this.imagePath, this.soundPath, {super.key});

  final String imagePath;
  final String soundPath;

  @override
  State<ClueBell> createState() => _ClueBellState();
}

class _ClueBellState extends State<ClueBell> with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(duration: const Duration(seconds: 5), vsync: this);

    // Configure audio player for web
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    
    // Set up completion listener once
    _audioPlayer.onPlayerComplete.listen((_) {
      if (mounted) {
        setState(() => _isPlaying = false);
        _rotationController.reset();
      }
    });

    // Play sound after widget is fully built and rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playSoundDelayed();
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.stop();
        _rotationController.stop();
      }

      await _audioPlayer.play(AssetSource(widget.soundPath));
      setState(() => _isPlaying = true);
      _rotationController.forward(from: 0);
    } catch (e) {
      debugPrint('Error playing audio: $e');
      // Continue with animation even if audio fails
      if (mounted) {
        setState(() => _isPlaying = false);
        _rotationController.forward(from: 0);
      }
    }
  }

  Future<void> _playSoundDelayed() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!_isPlaying) {
      await _playSound();
    }
  }

  @override
  Widget build(BuildContext context) {
    String imagePathLocal = "assets/${widget.imagePath}";
    return GestureDetector(
      onTap: _playSound,
      child: AnimatedBuilder(
        animation: _rotationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _getAngle(_rotationController.value),
            alignment: Alignment(0, -0.65),
            child: child,
          );
        },
        child: SizedBox(width: 400, height: 400, child: Image.asset(imagePathLocal)),
      ),
    );
  }

  double _getAngle(double t) {
    const round = 2 * math.pi;
    final anim = math.pow(t, 0.75);
    final sineComponent = math.sin(anim * round * 5); // ±0.1 radians swing

    var amplitudeMultiplier = (math.cos((anim) * round / 2) + 1) / 2;
    amplitudeMultiplier = math.pow(amplitudeMultiplier, 1.5).toDouble();
    return sineComponent * 0.25 * amplitudeMultiplier; // ±0.1 radians swing
  }
}


