import 'package:flutter/material.dart';

class SnakeHead extends StatelessWidget {
  const SnakeHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomPaint(
        painter: Painter(),
      ),
    );
  }
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellowAccent
      ..strokeWidth = 1;
    canvas.drawLine(const Offset(0.7, 0.35), const Offset(0.7, 0.7), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
