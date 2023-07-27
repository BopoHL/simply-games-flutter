import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/tetris_provider.dart';

class RotateButton extends StatelessWidget {
  const RotateButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<TetrisProvider>();
    return FloatingActionButton(
      onPressed: () {
        model.rotatePiece();
      },
      child: const Icon(Icons.rotate_right),
    );
  }
}
