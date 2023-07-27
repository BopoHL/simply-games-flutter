import 'package:flutter/material.dart';

class FoodPixel extends StatelessWidget {
  const FoodPixel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
