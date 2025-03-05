import 'package:flutter/material.dart';
import 'package:image_picker_demo/logic/photo_viewer.dart';
import 'dart:io';
import 'package:screenshot/screenshot.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:uuid/uuid.dart';

class OpenCV extends StatefulWidget {
  const OpenCV({super.key});

  @override
  State<OpenCV> createState() => _OpenCVState();
}

class _OpenCVState extends State<OpenCV> {
  File? _selectedImage;
  List<Map<String, dynamic>> boxes = [];
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("OpenCV")),
        body: Container(
          padding: EdgeInsets.all(16),
          color: Colors.green[300],
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                children: [
                  _selectedImage == null
                      ? Expanded(
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
                                    child:
                                        PhotoViewer(imageFile: _selectedImage!),
                                  ),
                          ),
                        )
                      : GestureDetector(
                          // onTapUp: addBoundingBox,
                          child: Screenshot(
                            controller: screenshotController,
                            child: Stack(
                              children: [
                                if (_selectedImage != null)
                                  Center(
                                    child: Image.file(
                                      _selectedImage!,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ...boxes.map((box) => Positioned(
                                      left: box["x"].toDouble(),
                                      top: box["y"].toDouble(),
                                      child: Container(
                                        width: box["width"].toDouble(),
                                        height: box["height"].toDouble(),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.red, width: 2),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                ],
              )),
              ElevatedButton(
                onPressed: () {},
                onLongPress: () {},
                child: const Text("Choose/Capture"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Upload and Process"),
              ),
              if (_selectedImage != null) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter file name",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(icon: Icon(Icons.refresh), onPressed: () {}),
                    IconButton(icon: Icon(Icons.add), onPressed: () {}),
                    IconButton(icon: Icon(Icons.close), onPressed: () {}),
                    IconButton(icon: Icon(Icons.save), onPressed: () {}),
                  ],
                ),
              ],
            ],
          ),
        ));
  }
}

// File? _selectedImage;
//   final ImagePicker _picker = ImagePicker();
//   List<Map<String, dynamic>> boxes = [];
//   bool isAddingBox = false;

//   final ScreenshotController screenshotController = ScreenshotController();
//   final uuid = Uuid();

//   Future<void> pickImage() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//         boxes.clear(); // Reset boxes when a new image is selected
//       });
//     }
//   }

//   void addBoundingBox(TapUpDetails details) {
//     if (isAddingBox && _selectedImage != null) {
//       setState(() {
//         boxes.add({
//           "id": uuid.v4(),
//           "x": details.localPosition.dx,
//           "y": details.localPosition.dy,
//           "width": 100,
//           "height": 100,
//         });
//         isAddingBox = false; // Turn off adding mode after adding a box
//       });
//     }
//   }

//   void reset() {
//     setState(() {
//       _selectedImage = null;
//       boxes.clear();
//       isAddingBox = false;
//     });
//   }
