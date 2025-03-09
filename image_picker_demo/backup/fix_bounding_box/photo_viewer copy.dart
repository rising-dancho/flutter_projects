import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker_demo/logic/tensorflow/object_painter.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:ui' as ui; // Import ui for image handling
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class PhotoViewer extends StatefulWidget {
  final File imageFile;
  final ui.Image? imageForDrawing;
  final List objects;
  final List<Rect> editableBoundingBoxes;
  final Function(Rect) onNewBox;
  final bool isAddingBox; // ✅ Add this line

  const PhotoViewer({
    super.key,
    required this.imageFile,
    required this.imageForDrawing,
    required this.objects,
    required this.editableBoundingBoxes,
    required this.onNewBox,
    required this.isAddingBox, // ✅ Require this parameter
  });
  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  Offset? boxStart;
  Offset? boxEnd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        if (widget.isAddingBox) {
          setState(() {
            double boxWidth = 75;
            double boxHeight = 75;

            widget.editableBoundingBoxes.add(
              Rect.fromLTWH(
                details.localPosition.dx - (boxWidth / 2),
                details.localPosition.dy - (boxHeight / 2),
                boxWidth,
                boxHeight,
              ),
            );
          });
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: PhotoView.customChild(
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2.0,
          backgroundDecoration: BoxDecoration(color: Colors.white),
          child: widget.imageForDrawing == null
              ? Center(child: CircularProgressIndicator())
              : CustomPaint(
                  painter: ObjectPainter(
                    objectList: widget.objects.cast<DetectedObject>(),
                    imageFile: widget.imageForDrawing!,
                    editableBoundingBoxes: widget.editableBoundingBoxes,
                  ),
                ),
        ),
      ),
    );
  }
}
