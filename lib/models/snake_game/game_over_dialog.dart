import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/snake_provider.dart';


class GameOverDialog extends StatelessWidget {

  const GameOverDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SnakeProvider>();
    return AlertDialog(
      title: const Text('Game Over!'),
      content: FilledButton(onPressed: (){model.newGame();}, child: const Text('Try again')),
    );
  }
}
