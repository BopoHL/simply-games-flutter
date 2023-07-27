import 'package:flutter/material.dart';
import '../screens/main_screen.dart';
import '../screens/snake_screen.dart';
import '../screens/tetris_screen.dart';
import 'app_routes.dart';

class AppNavigator {
  static String initRoute = AppRoutes.mainMenu;

  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.snake: (_) => const SnakeScreen(),
      AppRoutes.tetris: (_) => const TetrisScreen(),
      AppRoutes.mainMenu: (_) => const MainScreen(),
    };
  }
}
