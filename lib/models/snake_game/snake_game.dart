import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/snake_provider.dart';
import 'food_pixel.dart';
import 'snake_pixel.dart';
import 'map_pixel.dart';
import 'game_over_dialog.dart';

class SnakeGame extends StatelessWidget {
  const SnakeGame({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SnakeProvider>();
    if (model.isGameOver) {
      return const GameOverDialog();
    } else {
      return GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0 &&
              model.currentDirection != SnakeDirection.up) {
            model.currentDirection = SnakeDirection.down;
          } else if (details.delta.dy < 0 &&
              model.currentDirection != SnakeDirection.down) {
            model.currentDirection = SnakeDirection.up;
          }
        },
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0 &&
              model.currentDirection != SnakeDirection.left) {
            model.currentDirection = SnakeDirection.right;
          } else if (details.delta.dx < 0 &&
              model.currentDirection != SnakeDirection.right) {
            model.currentDirection = SnakeDirection.left;
          }
        },
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: model.itemCounts,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: model.rowSize),
          itemBuilder: (context, index) {
            if (model.snakePos.contains(index)) {
              return const SnakePixel();
            } else if (model.foodPos == index) {
              return const FoodPixel();
            } else {
              return const MapPixel();
            }
          },
        ),
      );
    }
  }
}

