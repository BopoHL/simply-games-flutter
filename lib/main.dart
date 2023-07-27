import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/ui/app_navigator/app_navigator.dart';
import 'providers/snake_provider.dart';
import 'providers/tetris_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SnakeProvider()),
        ChangeNotifierProvider(create: (context) => TetrisProvider()),
      ],
      child: MaterialApp(
        initialRoute: AppNavigator.initRoute,
        routes: AppNavigator.routes,
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
