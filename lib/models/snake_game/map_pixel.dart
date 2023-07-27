import 'package:flutter/material.dart';

class MapPixel extends StatelessWidget {
  const MapPixel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
