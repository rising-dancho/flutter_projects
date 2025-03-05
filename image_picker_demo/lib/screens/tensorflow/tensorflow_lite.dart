import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TensorflowLite extends StatefulWidget {
  const TensorflowLite({super.key});

  @override
  State<TensorflowLite> createState() => _TensorflowLiteState();
}

class _TensorflowLiteState extends State<TensorflowLite> {
  File? image;
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
      image = File(selectedImage.path);
      setState(() {
        image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tensorflow Lite")),
        body: Container(
          padding: EdgeInsets.all(16),
          color: Colors.grey[300],
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child:  image == null
                  ? Icon(Icons.add_photo_alternate_sharp, size: 120)
                  : Image.file(image!),
              ),
              ElevatedButton(
                  onPressed: imageGallery,
                  onLongPress: () {},
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
