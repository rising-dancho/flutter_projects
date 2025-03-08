import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class ObjectPainter extends CustomPainter {
  final List<DetectedObject> objectList;
  final ui.Image imageFile;

  ObjectPainter({required this.objectList, required this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    // Scale factors for bounding boxes
    double scaleX = size.width / imageFile.width;
    double scaleY = size.height / imageFile.height;

    // Draw the image resized to fit canvas
    final paint = Paint();
    canvas.drawImageRect(
      imageFile,
      Rect.fromLTWH(0, 0, imageFile.width.toDouble(), imageFile.height.toDouble()),
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );

    // Dynamic stroke width calculation based on image size
    final double minStroke = 2.0; // Ensures visibility on small images
    final double maxStroke = 10.0; // Prevents excessive thickness
    final double strokeWidth = ((size.width + size.height) / 200).clamp(minStroke, maxStroke); // the lower the divisor the thicker the bounding box

    final boxPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth; // Dynamically adjusted stroke width

    for (DetectedObject detectedObject in objectList) {
      final rect = detectedObject.boundingBox;

      // Scale bounding box to match displayed image size
      final scaledRect = Rect.fromLTRB(
        rect.left * scaleX,
        rect.top * scaleY,
        rect.right * scaleX,
        rect.bottom * scaleY,
      );

      // Draw bounding box
      canvas.drawRect(scaledRect, boxPaint);

      // Draw label text
      for (Label label in detectedObject.labels) {
        final textSpan = TextSpan(
          text: "${label.text} (${(label.confidence * 100).toStringAsFixed(1)}%)",
          style: TextStyle(
            fontSize: strokeWidth * 5.5, // Scale text size with stroke width: higher the more visible
            color: Colors.white,
            backgroundColor: Colors.blue,
          ),
        );

        final textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout();
        textPainter.paint(canvas, Offset(scaledRect.left, scaledRect.top - textPainter.height - 2));
        break; // Only show the first label
      }
    }
  }

  @override
  bool shouldRepaint(covariant ObjectPainter oldDelegate) {
    return oldDelegate.objectList != objectList || oldDelegate.imageFile != imageFile;
  }
}
