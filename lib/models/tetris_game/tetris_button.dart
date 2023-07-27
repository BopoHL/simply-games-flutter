import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/tetris_provider.dart';

class TetrisButton extends StatelessWidget {
  const TetrisButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TetrisProvider>();
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          backgroundColor: model.isGameStart ? Colors.grey : Colors.green),
      onPressed: model.isGameStart ? null : model.startGame,
      icon: const Icon(Icons.play_arrow),
      label: const Text('Play'),
    );
  }
}
