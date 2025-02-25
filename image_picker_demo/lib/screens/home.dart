import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? image; //nullable image declaration

  // Declaring image picker: load after everything else has loaded
  late ImagePicker imagePicker;

  @override
  void initState() {
    super.initState();
    // initialize image picker inside initState
    imagePicker = ImagePicker();
  }

  chooseImage() {
    print("button clicked!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image == null
                ? Icon(Icons.image_search, size: 125)
                : Image.file(image!),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: chooseImage, child: const Text("Choose/Capture")),
          ],
        ),
      ),
    );
  }
}
