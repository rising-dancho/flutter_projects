import 'package:flutter/material.dart';
import 'package:image_picker_demo/logic/opencv_photo_viewer.dart';
import 'dart:io';
import 'package:screenshot/screenshot.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class OpenCV extends StatefulWidget {
  const OpenCV({super.key});

  @override
  State<OpenCV> createState() => _OpenCVState();
}

class _OpenCVState extends State<OpenCV> {
  List<Map<String, dynamic>> boxes = [];
  final ScreenshotController screenshotController = ScreenshotController();
  File? _selectedImage;
  late ImagePicker imagePicker;

  bool isAddingBox = false;
  var uuid = Uuid();
  // Add this key to track the image size
  final GlobalKey _imageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  void reset() {
    setState(() {
      _selectedImage = null;
      // boxes.clear();
      isAddingBox = false;
    });
  }

  void addBoundingBox(TapUpDetails details) {
    if (isAddingBox && _selectedImage != null) {
      setState(() {
        double boxWidth = 75;
        double boxHeight = 75;

        boxes.add({
          "id": uuid.v4(),
          "x": details.localPosition.dx - (boxWidth / 2), // Center horizontally
          "y": details.localPosition.dy - (boxHeight / 2), // Center vertically
          "width": boxWidth,
          "height": boxHeight,
        });

        isAddingBox = false; // Disable adding mode after placing the box
      });
    }
  }

  imageGallery() async {
    XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      setState(() {
        _selectedImage = File(selectedImage.path);
      });
    }
  }

  useCamera() async {
    XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera);

    if (selectedImage != null) {
      setState(() {
        _selectedImage = File(selectedImage.path);
      });
    }
  }

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
                  if (_selectedImage == null)
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 120,
                          color: Colors.grey[500],
                        ),
                      ),
                    )
                  else
                    GestureDetector(
                      onTapUp: addBoundingBox,
                      child: Screenshot(
                        controller: screenshotController,
                        child: Stack(
                          children: [
                            // Image and bounding boxes
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  child:
                                      PhotoViewer(imageFile: _selectedImage!),
                                ),
                              ),
                            ),

                            // Bounding boxes overlay
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

                            // **Total Bounding Boxes Counter (Upper Right)**
                            Positioned(
                              top: 10, // Adjust for positioning
                              right: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Total Count: ${boxes.length}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (_selectedImage == null) ...[
              ElevatedButton(
                onPressed: imageGallery,
                onLongPress: useCamera,
                child: const Text("Choose/Capture"),
              ),
            ],
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
                  IconButton(icon: Icon(Icons.refresh), onPressed: reset),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          isAddingBox =
                              true; // Enable adding mode, then let user tap to add
                        });
                      }),
                  IconButton(icon: Icon(Icons.close), onPressed: () {}),
                  IconButton(icon: Icon(Icons.save), onPressed: () {}),
                ],
              ),
            ],
          ],
        ),
      ),
    );
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



