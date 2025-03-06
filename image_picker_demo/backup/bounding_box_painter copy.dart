import 'package:flutter/material.dart';

class BoundingBoxPainter extends CustomPainter {
  final List<List<int>> boxes;
  final Size originalSize;
  final Size displayedSize;

  BoundingBoxPainter(this.boxes, this.originalSize, this.displayedSize);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    double scaleX = displayedSize.width / originalSize.width;
    double scaleY = displayedSize.height / originalSize.height;

    for (var box in boxes) {
      double x = box[0] * scaleX;
      double y = box[1] * scaleY;
      double width = (box[2] - box[0]) * scaleX;
      double height = (box[3] - box[1]) * scaleY;

      // Debugging
      print("Drawing box at: ($x, $y) - Width: $width, Height: $height");

      canvas.drawRect(Rect.fromLTWH(x, y, width, height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Ensures boxes are redrawn when state updates
  }
}
