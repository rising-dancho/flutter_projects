import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker_demo/logic/object_painter.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:ui' as ui; // Import ui for image handling
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class PhotoViewer extends StatelessWidget {
  final File imageFile;
  final ui.Image? imageForDrawing; // Nullable because it might not be ready
  final List objects;

  const PhotoViewer({
    super.key,
    required this.imageFile,
    required this.imageForDrawing,
    required this.objects,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: PhotoView.customChild(
        minScale: PhotoViewComputedScale.contained * 1.0,
        maxScale: PhotoViewComputedScale.covered * 2.0,
        backgroundDecoration: const BoxDecoration(color: Colors.white),
        child: imageForDrawing == null
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show a loading indicator if image isn't ready
            : Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: imageForDrawing!.width.toDouble(),
                    height: imageForDrawing!.height.toDouble(),
                    child: CustomPaint(
                      painter: ObjectPainter(
                        objectList:
                            objects.cast<DetectedObject>(), // ✅ Explicit cast
                        imageFile: imageForDrawing!,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}