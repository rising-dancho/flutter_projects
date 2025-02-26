import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// Photo Editor Screen with Zoom/Pan and Buttons
class PhotoEditorScreen extends StatelessWidget {
  final File imageFile;
  const PhotoEditorScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Photo Editor")),
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: PhotoView(
                  imageProvider: FileImage(imageFile),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                  backgroundDecoration: BoxDecoration(color: Colors.white),
                  loadingBuilder: (context, event) =>
                      CircularProgressIndicator(),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Back"),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     // Add your save functionality here
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text("Image saved!")),
                    //     );
                    //   },
                    //   child: const Text("Save"),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
