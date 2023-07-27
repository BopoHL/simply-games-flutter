import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

enum SnakeDirection { left, right, up, down }

class SnakeProvider extends ChangeNotifier {
  // grid parameters
  int rowSize = 10;
  int itemCounts = 100;

  // snake position
  List<int> snakePos = [0, 1, 2];

  // snake direction
  var currentDirection = SnakeDirection.right;

  // food
  int foodPos = 55;

  // checking for game over
  bool isGameOver = false;

  // checking for game start
  bool isGameStart = false;

  // score
  int currentScore = 0;

  // game loop
  void startGame() {
    isGameStart = true;
    Timer.periodic(const Duration(milliseconds: 150), (timer) {
      moveSnake();
      gameOver();
      if (isGameOver) {
        timer.cancel();
      }
      notifyListeners();
    });
  }

  // set default values for new game
  void newGame() {
    snakePos = [0, 1, 2];
    currentDirection = SnakeDirection.right;
    foodPos = 55;
    isGameOver = false;
    isGameStart = false;
    currentScore = 0;
    notifyListeners();
  }

  void moveSnake() {
    switch (currentDirection) {
      case SnakeDirection.right:
        {
          if (snakePos.last % rowSize == 9) {
            snakePos.add(snakePos.last - (rowSize - 1));
          } else {
            snakePos.add(snakePos.last + 1);
          }
        }

        break;
      case SnakeDirection.left:
        {
          if (snakePos.last % rowSize == 0) {
            snakePos.add(snakePos.last + (rowSize - 1));
          } else {
            snakePos.add(snakePos.last - 1);
          }
        }

        break;
      case SnakeDirection.up:
        {
          if (snakePos.last < rowSize) {
            snakePos.add(snakePos.last - rowSize + itemCounts);
          } else {
            snakePos.add(snakePos.last - rowSize);
          }
        }

        break;
      case SnakeDirection.down:
        {
          if (snakePos.last + rowSize >= itemCounts) {
            snakePos.add(snakePos.last + rowSize - itemCounts);
          } else {
            snakePos.add(snakePos.last + rowSize);
          }
        }

        break;
      default:
    }

    if (snakePos.last == foodPos) {
      eatFood();
    } else {
      // remove tail
      snakePos.removeAt(0);
    }
  }

  void eatFood() {
    currentScore++;
    // set random location for food out of snake body
    while (snakePos.contains(foodPos)) {
      foodPos = Random().nextInt(itemCounts);
    }
  }

  void gameOver() {
    List<int> snakeBody = snakePos.sublist(0, snakePos.length - 1);
    if (snakeBody.contains(snakePos.last)) {
      isGameOver = true;
    }
  }
}
