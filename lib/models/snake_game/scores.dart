import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/snake_provider.dart';

class Scores extends StatelessWidget {
  const Scores({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SnakeProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Current score',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              model.currentScore.toString(),
              style: const TextStyle(fontSize: 30),
            )
          ],
        ),
        const Text('Highscores...')
      ],
    );
  }
}
