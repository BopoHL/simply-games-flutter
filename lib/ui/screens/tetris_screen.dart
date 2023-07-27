import 'package:flutter/material.dart';
import '../../models/tetris_game/score_board.dart';
import '../../models/tetris_game/rotate_button.dart';
import '../../models/tetris_game/tetris_button.dart';
import '../../models/tetris_game/tetris_game.dart';

class TetrisScreen extends StatelessWidget {
  const TetrisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          ScoreBoard(),
          Expanded(flex: 4,child: TetrisGame()),
          RotateButton(),
          TetrisButton(),
        ],
      ),
    );
  }
}