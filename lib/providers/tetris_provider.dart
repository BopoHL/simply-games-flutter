import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/tetris_game/tetromino.dart';

enum Direction {
  left,
  right,
  down,
}

class TetrisProvider extends ChangeNotifier {
  bool isGameStart = false;

  // grid size
  int colLength = 15;
  int rowLength = 10;

  // tetromino is a list of indexes
  List<int> position = [];

// Data structure for tracking landed elements
  List<List<Tetromino?>> gameBoard =
      List.generate(15, (i) => List.generate(10, (j) => null));

  int rotationState = 0;

  Tetromino currentType =
      Tetromino.values[Random().nextInt(Tetromino.values.length)];

  int currentScore = 0;

  void initPiece(Tetromino type) {
    switch (type) {
      case Tetromino.L:
        position = [-30, -20, -10, -9];

        break;
      case Tetromino.J:
        position = [-29, -19, -9, -10];

        break;
      case Tetromino.I:
        position = [-30, -20, -10, 0];

        break;
      case Tetromino.T:
        position = [-29, -19, -9, -20];

        break;
      case Tetromino.S:
        position = [-29, -28, -20, -19];

        break;
      case Tetromino.Z:
        position = [-30, -29, -19, -18];

        break;
      case Tetromino.O:
        position = [-30, -20, -29, -19];

        break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }

        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }

        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }

        break;
      default:
    }
  }

  // speed
  Duration duration = const Duration(milliseconds: 300);

  // game loop
  void startGame() {
    isGameStart = true;
    initPiece(currentType);
    Timer.periodic(duration, (timer) {
      checkLanding();
      movePiece(Direction.down);
      clearLines();
      notifyListeners();
    });
  }

  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        gameBoard[0] = List.generate(rowLength, (index) => null);

        currentScore++;
      }
    }
  }

  bool checkCollision(Direction direction) {
    for (var i = 0; i < position.length; i++) {
      int row = (position[i] / rowLength).floor();
      int col = (position[i] % rowLength);

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= colLength || col >= rowLength || col < 0) {
        return true;
      }

      if (position[i] >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (var i = 0; i < position.length; i++) {
        int row = (position[i] / rowLength).floor();
        int col = (position[i] % rowLength);

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentType;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    rotationState = 0;
    currentType = Tetromino.values[Random().nextInt(Tetromino.values.length)];
    initPiece(currentType);
  }

  void rotatePiece() {
    List<int> newPosition = [];

    bool validRotate(int pos) {
      int row = (pos / rowLength).floor();
      int col = (pos % rowLength);

      if (row < 0 || col < 0 || gameBoard[row][col] != null) {
        return false;
      }
      return true;
    }

    bool validNewPosition(List<int> newPosition) {
      bool firstColumnOccupied = false;
      bool lastColumnOccupied = false;

      for (var pos in newPosition) {
        if (!validRotate(pos)) {
          return false;
        }

        int col = pos % rowLength;

        if (col == 0) {
          firstColumnOccupied = true;
        }
        if (col == rowLength - 1) {
          lastColumnOccupied = true;
        }
      }

      return !(firstColumnOccupied && lastColumnOccupied);
    }

    void rotate(List<int> newPosition) {
      if (validNewPosition(newPosition)) {
        position = newPosition;
        rotationState = (rotationState + 1) % 4;
      }
    }

    switch (currentType) {
      case Tetromino.L:
        {
          switch (rotationState) {
            case 0:
              {
                newPosition = [
                  position[1] + 1,
                  position[1],
                  position[1] - 1,
                  position[1] + rowLength - 1,
                ];

                rotate(newPosition);
              }

              break;
            case 1:
              {
                newPosition = [
                  position[1] + rowLength,
                  position[1],
                  position[1] - rowLength,
                  position[1] - rowLength - 1,
                ];
                rotate(newPosition);
              }

              break;
            case 2:
              {
                newPosition = [
                  position[1] - 1,
                  position[1],
                  position[1] + 1,
                  position[1] - rowLength + 1,
                ];
                rotate(newPosition);
              }

              break;
            case 3:
              {
                newPosition = [
                  position[1] - rowLength,
                  position[1],
                  position[1] + rowLength,
                  position[1] + rowLength + 1,
                ];
                rotate(newPosition);
              }

              break;
            default:
          }
        }

        break;
      case Tetromino.J:
        {
          switch (rotationState) {
            case 0:
              {
                newPosition = [
                  position[1] + 1,
                  position[1],
                  position[1] - 1,
                  position[1] - rowLength - 1,
                ];

                rotate(newPosition);
              }
              break;
            case 1:
              {
                newPosition = [
                  position[1] + rowLength,
                  position[1],
                  position[1] - rowLength,
                  position[1] - rowLength + 1,
                ];

                rotate(newPosition);
              }
              break;
            case 2:
              {
                newPosition = [
                  position[1] - 1,
                  position[1],
                  position[1] + 1,
                  position[1] + rowLength + 1,
                ];

                rotate(newPosition);
              }
              break;
            case 3:
              {
                newPosition = [
                  position[1] - rowLength,
                  position[1],
                  position[1] + rowLength,
                  position[1] + rowLength - 1,
                ];

                rotate(newPosition);
              }
              break;
            default:
          }
        }
        break;
      case Tetromino.I:
        {
          switch (rotationState) {
            case 0:
              {
                newPosition = [
                  position[1] + 1,
                  position[1],
                  position[1] - 1,
                  position[1] - 1 - 1,
                ];

                rotate(newPosition);
              }
              break;
            case 1:
              {
                newPosition = [
                  position[1] + rowLength,
                  position[1],
                  position[1] - rowLength,
                  position[1] - rowLength - rowLength,
                ];

                rotate(newPosition);
              }
              break;
            case 2:
              {
                newPosition = [
                  position[1] - 1,
                  position[1],
                  position[1] + 1,
                  position[1] + 1 + 1,
                ];

                rotate(newPosition);
              }
              break;
            case 3:
              {
                newPosition = [
                  position[1] - rowLength,
                  position[1],
                  position[1] + rowLength,
                  position[1] + rowLength + rowLength,
                ];

                rotate(newPosition);
              }
              break;
            default:
          }
        }
        break;
      case Tetromino.S:
        {
          switch (rotationState) {
            case 0:
              {
                newPosition = [
                  position[0],
                  position[0] + rowLength,
                  position[0] - 1,
                  position[0] - rowLength - 1,
                ];
                rotate(newPosition);
              }
              break;
            case 1:
              {
                newPosition = [
                  position[0],
                  position[0] - 1,
                  position[0] - rowLength,
                  position[0] - rowLength + 1,
                ];
                rotate(newPosition);
              }
              break;
            case 2:
              {
                newPosition = [
                  position[0],
                  position[0] - rowLength,
                  position[0] + 1,
                  position[0] + rowLength + 1,
                ];
                rotate(newPosition);
              }
              break;
            case 3:
              {
                newPosition = [
                  position[0],
                  position[0] + 1,
                  position[0] + rowLength - 1,
                  position[0] + rowLength,
                ];
                rotate(newPosition);
              }
              break;
            default:
          }
        }
        break;
      case Tetromino.Z:
        {
          switch (rotationState) {
            case 0:
              {
                newPosition = [
                  position[1] - rowLength,
                  position[1],
                  position[1] - 1,
                  position[1] + rowLength - 1,
                ];
                rotate(newPosition);
              }
              break;
            case 1:
              {
                newPosition = [
                  position[1] + 1,
                  position[1],
                  position[1] - rowLength,
                  position[1] - rowLength - 1,
                ];
                rotate(newPosition);
              }
              break;
            case 2:
              {
                newPosition = [
                  position[1] + rowLength,
                  position[1],
                  position[1] + 1,
                  position[1] - rowLength + 1,
                ];
                rotate(newPosition);
              }
              break;
            case 3:
              {
                newPosition = [
                  position[1] - 1,
                  position[1],
                  position[1] + rowLength,
                  position[1] + rowLength + 1,
                ];
                rotate(newPosition);
              }
              break;
            default:
          }
        }
        break;
      case Tetromino.T:
        {
          switch (rotationState) {
            case 0:
              {
                newPosition = [
                  position[1] + 1,
                  position[1],
                  position[1] - 1,
                  position[1] - rowLength,
                ];
                rotate(newPosition);
              }
              break;
            case 1:
              {
                newPosition = [
                  position[1] + rowLength,
                  position[1],
                  position[1] - rowLength,
                  position[1] + 1,
                ];
                rotate(newPosition);
              }
              break;
            case 2:
              {
                newPosition = [
                  position[1] - 1,
                  position[1],
                  position[1] + 1,
                  position[1] + rowLength,
                ];
                rotate(newPosition);
              }
              break;
            case 3:
              {
                newPosition = [
                  position[1] - rowLength,
                  position[1],
                  position[1] + rowLength,
                  position[1] - 1,
                ];
                rotate(newPosition);
              }
              break;
            default:
          }
        }
        break;
      default:
    }
  }
}
