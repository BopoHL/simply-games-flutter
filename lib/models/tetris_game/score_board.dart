import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/tetris_provider.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TetrisProvider>();
    return Text('Current score: ${model.currentScore}');
  }
}