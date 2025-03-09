import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class ObjectPainter extends CustomPainter {
  final List<DetectedObject> objectList;
  final List<Rect> editableBoundingBoxes; // 👈 Manually controlled boxes
  final ui.Image imageFile;

  ObjectPainter({
    required this.objectList,
    required this.imageFile,
    required this.editableBoundingBoxes, // 👈 Pass the new list
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Scale factors for bounding boxes
    double scaleX = size.width / imageFile.width;
    double scaleY = size.height / imageFile.height;

    // Get the aspect ratio of the image and the canvas
    double imageAspect = imageFile.width / imageFile.height;
    double canvasAspect = size.width / size.height;

    double drawWidth, drawHeight, offsetX, offsetY;

    if (imageAspect > canvasAspect) {
      // Image is wider than canvas -> fit width
      drawWidth = size.width;
      drawHeight = size.width / imageAspect;
      offsetX = 0;
      offsetY = (size.height - drawHeight) / 2;
    } else {
      // Image is taller than canvas -> fit height
      drawHeight = size.height;
      drawWidth = size.height * imageAspect;
      offsetY = 0;
      offsetX = (size.width - drawWidth) / 2;
    }

    canvas.drawImageRect(
      imageFile,
      Rect.fromLTWH(
          0, 0, imageFile.width.toDouble(), imageFile.height.toDouble()),
      Rect.fromLTWH(offsetX, offsetY, drawWidth, drawHeight),
      Paint()
        ..filterQuality = FilterQuality.high, // Ensure high-quality scaling
    );

    // Dynamic stroke width calculation
    final double minStroke = 2.0;
    final double maxStroke = 10.0;
    final double strokeWidth =
        ((size.width + size.height) / 200).clamp(minStroke, maxStroke);

    final boxPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // 🎯 **Draw detected bounding boxes**
    for (DetectedObject detectedObject in objectList) {
      final rect = detectedObject.boundingBox;
      final scaledRect = Rect.fromLTRB(
        rect.left * scaleX,
        rect.top * scaleY,
        rect.right * scaleX,
        rect.bottom * scaleY,
      );

      canvas.drawRect(scaledRect, boxPaint);

      // Draw label text
      for (Label label in detectedObject.labels) {
        final textSpan = TextSpan(
          text:
              "${label.text} (${(label.confidence * 100).toStringAsFixed(1)}%)",
          style: TextStyle(
            fontSize: strokeWidth * 5.5,
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
        textPainter.paint(canvas,
            Offset(scaledRect.left, scaledRect.top - textPainter.height - 2));
        break;
      }
    }

    // 🎯 **Draw manually added bounding boxes**
    final manualBoxPaint = Paint()
      ..color = Colors.red // Manually added boxes in red
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    for (Rect box in editableBoundingBoxes) {
      final scaledBox = Rect.fromLTRB(
        box.left * scaleX,
        box.top * scaleY,
        box.right * scaleX,
        box.bottom * scaleY,
      );
      canvas.drawRect(scaledBox, manualBoxPaint);
    }
  }

  @override
  bool shouldRepaint(covariant ObjectPainter oldDelegate) {
    return oldDelegate.objectList != objectList ||
        oldDelegate.imageFile != imageFile ||
        oldDelegate.editableBoundingBoxes !=
            editableBoundingBoxes; // 👈 Check for changes
  }
}
