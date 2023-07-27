import 'package:flutter/material.dart';

class SnakePixel extends StatelessWidget {
  const SnakePixel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
