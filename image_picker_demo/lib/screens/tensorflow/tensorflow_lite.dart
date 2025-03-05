import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_demo/logic/photo_viewer.dart';

class TensorflowLite extends StatefulWidget {
  const TensorflowLite({super.key});

  @override
  State<TensorflowLite> createState() => _TensorflowLiteState();
}

class _TensorflowLiteState extends State<TensorflowLite> {
  // Image galler and camera variables
  File? _selectedImage;
  late ImagePicker imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  imageGallery() async {
    XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      _selectedImage = File(selectedImage.path);
      setState(() {
        _selectedImage;
      });
    }
  }

  useCamera() async {
    XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera);

    if (selectedImage != null) {
      _selectedImage = File(selectedImage.path);
      setState(() {
        _selectedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tensorflow Lite")),
        body: Container(
          padding: EdgeInsets.all(16),
          color: Colors.blue[300],
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: double
                      .infinity, // Makes the container expand horizontally
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors
                        .white, // Adds a background to prevent weird scaling issues
                  ),
                  child: _selectedImage == null
                      ? Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 120,
                          color: Colors.grey[500],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: PhotoViewer(imageFile: _selectedImage!),
                        ),
                ),
              ),
              ElevatedButton(
                  onPressed: imageGallery,
                  onLongPress: useCamera,
                  child: const Text("Choose/Capture")),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Upload and Process"),
              ),
            ],
          ),
        ));
  }
}
