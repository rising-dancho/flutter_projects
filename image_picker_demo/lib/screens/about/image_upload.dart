import 'package:flutter/material.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tensorflow Lite")),
        body: Container(
          padding: EdgeInsets.all(16),
          color: Colors.grey,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {}, child: const Text("Select Image")),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Upload and Process"),
              ),
            ],
          ),
        ));
  }
}
