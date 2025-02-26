import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? image; // Nullable image declaration
  late ImagePicker imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  chooseImage() async {
    XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        image = File(selectedImage.path);
      });
    }
  }

  captureImages() async {
    XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      setState(() {
        image = File(selectedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                // Show PhotoView directly when an image is selected
                image == null
                    ? const Icon(Icons.image_search, size: 125)
                    : Expanded(
                        child: PhotoView(
                          imageProvider: FileImage(image!),
                          minScale: PhotoViewComputedScale.contained * 0.8,
                          maxScale: PhotoViewComputedScale.covered * 2.0,
                          backgroundDecoration:
                              const BoxDecoration(color: Colors.white),
                          loadingBuilder: (context, event) =>
                              const CircularProgressIndicator(),
                        ),
                      ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: chooseImage,
                  onLongPress: captureImages,
                  child: const Text("Choose/Capture"),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ));
  }
}
