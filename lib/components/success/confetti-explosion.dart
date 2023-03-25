import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

import './star.dart';

class ConfettiExplosion extends StatefulWidget {
  const ConfettiExplosion({super.key});

  @override
  State<ConfettiExplosion> createState() => _ConfettiExplosionState();
}

class _ConfettiExplosionState extends State<ConfettiExplosion> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 60));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConfettiWidget(
        confettiController: _confettiController,
        canvas: Size.infinite,
        blastDirectionality: BlastDirectionality
            .explosive, // don't specify a direction, blast randomly
        shouldLoop: false, // start again as soon as the animation is finished
        emissionFrequency: 0,
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple
        ], // manually specify the colors to be used
        createParticlePath: Star.drawStar,
        numberOfParticles: 200, // define a custom shape/path.
      ),
    );
  }
}
