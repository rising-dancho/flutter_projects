import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class ObjectPainter extends CustomPainter {
  final List<DetectedObject> objectList;
  final ui.Image imageFile;

  ObjectPainter({required this.objectList, required this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    // Scale image to fit container
    final paint = Paint();
    canvas.drawImage(imageFile, Offset.zero, paint);

    // Draw bounding boxes
    final boxPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    for (DetectedObject detectedObject in objectList) {
      final rect = detectedObject.boundingBox;
      canvas.drawRect(rect, boxPaint);

      for (Label label in detectedObject.labels) {
        final textSpan = TextSpan(
          text: "${label.text} (${label.confidence.toStringAsFixed(2)})",
          style: const TextStyle(fontSize: 16, color: Colors.blue),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(rect.left, rect.top - 20));
        break; // Only show the first label
      }
    }
  }

  @override
  bool shouldRepaint(covariant ObjectPainter oldDelegate) {
    return oldDelegate.objectList != objectList ||
        oldDelegate.imageFile != imageFile;
  }
}
