import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_demo/screens/photo_editor_screen.dart';

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

  void openPhotoEditor() {
    if (image != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoEditorScreen(imageFile: image!),
        ),
      );
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
                image == null
                    ? const Icon(Icons.image_search, size: 125)
                    : Expanded(
                        child: GestureDetector(
                        onTap: openPhotoEditor, // Tap to open zoom mode
                        child: Image.file(image!, height: 200),
                      )),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: chooseImage,
                  onLongPress: captureImages,
                  child: const Text("Choose/Capture"),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ));
  }
}
