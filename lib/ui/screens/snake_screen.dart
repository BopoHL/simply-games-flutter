import 'package:flutter/material.dart';
import '../../models/snake_game/scores.dart';
import '../../models/snake_game/snake_button.dart';
import '../../models/snake_game/snake_game.dart';

class SnakeScreen extends StatelessWidget {
  const SnakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // high scores
          Expanded(child: Scores()),

          // game grid
          Expanded(flex: 3, child: SnakeGame()),

          // play button
          Expanded(child: Center(child: SnakeButton())),
        ],
      ),
    );
  }
}
