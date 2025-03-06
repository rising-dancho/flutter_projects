import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class ObjectPainter extends CustomPainter {
  final List<DetectedObject> objectList;
  final ui.Image? imageFile;

  ObjectPainter({required this.objectList, required this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    if (imageFile != null) {
      // Scale the image to fit the canvas properly
      Paint imagePaint = Paint();
      canvas.drawImage(imageFile!, Offset.zero, imagePaint);
    }

    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    Paint textBackground = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    for (DetectedObject rectangle in objectList) {
      Rect bbox = rectangle.boundingBox;
      canvas.drawRect(bbox, paint);

      for (Label label in rectangle.labels) {
        // Text Painter for labeling
        TextSpan span = TextSpan(
          text: "${label.text} (${(label.confidence * 100).toStringAsFixed(1)}%)",
          style: const TextStyle(fontSize: 20, color: Colors.white),
        );

        TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        );

        tp.layout();

        // Draw background for text
        canvas.drawRect(
          Rect.fromLTWH(bbox.left, bbox.top - 30, tp.width + 10, tp.height + 10),
          textBackground,
        );

        // Draw text
        tp.paint(canvas, Offset(bbox.left + 5, bbox.top - 25));
        break; // Only show the most confident label
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
