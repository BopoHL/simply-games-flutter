import 'package:flutter/material.dart';

List<String> games = ['tetris', 'snake'];

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: ListView.separated(
        itemBuilder: (context, index) => ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/${games[index]}');
          },
          child: Text(games[index]),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: games.length,
      ),
    ));
  }
}
