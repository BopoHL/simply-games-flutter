import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tetromino_colors.dart';
import '../../providers/tetris_provider.dart';
import 'pixel.dart';

class TetrisGame extends StatelessWidget {
  const TetrisGame({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TetrisProvider>();
    if (model.isGameOver) {
      return AlertDialog(title: const Text('Game Over!'),
      content: FilledButton(onPressed: (){model.newGame();}, child: const Text('Try again')),);
    }
    else {return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          if (!model.checkCollision(Direction.right)) {
            model.movePiece(Direction.right);
          }
        } else if (details.primaryVelocity! < 0) {
          if (!model.checkCollision(Direction.left)) {
            model.movePiece(Direction.left);
          }
        }
      },
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: model.rowLength),
        itemCount: model.rowLength * model.colLength,
        itemBuilder: (context, index) {
          int row = (index / model.rowLength).floor();
          int col = (index % model.rowLength);
          if (model.position.contains(index)) {
            return Pixel(color: tetrominoColors[model.currentType] ?? Colors.white);
          } else if (model.gameBoard[row][col] != null) {
            return Pixel(color: tetrominoColors[model.gameBoard[row][col]] ?? Colors.white);
          } else {
            return Pixel(color: Colors.grey.shade900);
          }
        },
      ),
    );}
  }
}
