import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:image_picker_demo/logic/object_painter.dart';
import 'package:photo_view/photo_view.dart';


class PhotoViewer extends StatelessWidget {
  final File imageFile;
  final List<DetectedObject> objects;
  final ui.Image? image;

  const PhotoViewer({
    Key? key,
    required this.imageFile,
    required this.objects,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          // PhotoView for zooming & panning
          PhotoView(
            imageProvider: FileImage(imageFile),
            minScale: PhotoViewComputedScale.contained * 1.0,
            maxScale: PhotoViewComputedScale.covered * 2.0,
            backgroundDecoration: const BoxDecoration(color: Colors.white),
            loadingBuilder: (context, event) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),

          // CustomPaint overlay to draw bounding boxes
          if (image != null) 
            Positioned.fill(
              child: IgnorePointer( // Allows interaction with PhotoView
                child: CustomPaint(
                  painter: ObjectPainter(objectList: objects, imageFile: image),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
