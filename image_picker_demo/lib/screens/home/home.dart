import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:screenshot/screenshot.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageProcessingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ImageProcessingScreen extends StatefulWidget {
  const ImageProcessingScreen({super.key});

  @override
  State<ImageProcessingScreen> createState() => _ImageProcessingScreenState();
}

class _ImageProcessingScreenState extends State<ImageProcessingScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> boxes = [];

  bool isAddingBox = false;

  final ScreenshotController screenshotController = ScreenshotController();
  final uuid = Uuid();

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void addBoundingBox(TapUpDetails details) {
    if (isAddingBox) {
      setState(() {
        boxes.add({
          "id": uuid.v4(),
          "x": details.localPosition.dx,
          "y": details.localPosition.dy,
          "width": 100,
          "height": 100,
        });
        isAddingBox = false;
      });
    }
  }

  void reset() {
    setState(() {
      _selectedImage = null;
      boxes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("OpenCV"),
        ),
        body: Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTapUp: addBoundingBox,
                  child: Screenshot(
                    controller: screenshotController,
                    child: Stack(
                      children: [
                        if (_selectedImage != null)
                          Image.file(_selectedImage!,
                              width: double.infinity, fit: BoxFit.cover),
                        ...boxes.map((box) => Positioned(
                              left: box["x"].toDouble(),
                              top: box["y"].toDouble(),
                              child: Container(
                                width: box["width"].toDouble(),
                                height: box["height"].toDouble(),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.red, width: 2),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                if (_selectedImage == null)
                  ElevatedButton(
                      onPressed: pickImage, child: Text("Choose a photo")),
                if (_selectedImage != null) ...[
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter file name",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(icon: Icon(Icons.refresh), onPressed: reset),
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => setState(() => isAddingBox = true)),
                      IconButton(icon: Icon(Icons.check), onPressed: () {}),
                      IconButton(icon: Icon(Icons.save), onPressed: () {}),
                    ],
                  ),
                ],
              ],
            )));
  }
}
