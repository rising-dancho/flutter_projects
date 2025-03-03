import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
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
  String? timestamp;
  final ScreenshotController screenshotController = ScreenshotController();
  final Dio dio = Dio();
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

  Future<void> processImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select an image first.")));
      return;
    }

    try {
      timestamp = DateTime.now().toIso8601String();
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(_selectedImage!.path,
            filename: "uploaded-image.jpg"),
      });

      Response response = await dio.post(
        "https://objectdetection-b2afgyctf0bsgrd4.southeastasia-01.azurewebsites.net/image-processing",
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
      );

      var responseData = response.data;
      List<dynamic> boundingBoxes = responseData["bounding_boxes"];
      setState(() {
        boxes = boundingBoxes
            .map((box) => {
                  "id": uuid.v4(),
                  "x": box[0],
                  "y": box[1],
                  "width": box[2],
                  "height": box[3],
                })
            .toList();
      });

      print("Object count: ${responseData["object_count"]}");
    } catch (error) {
      print("Error processing image: $error");
    }
  }

  Future<void> saveImage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = "${directory.path}/processed-image.png";

      final image = await screenshotController.capture();
      if (image != null) {
        File(imagePath).writeAsBytesSync(image);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Image saved!")));
      }
    } catch (e) {
      print("Error saving image: $e");
    }
  }

  void reset() {
    setState(() {
      _selectedImage = null;
      boxes.clear();
      timestamp = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Image Processor")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
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
                                border: Border.all(color: Colors.red, width: 2),
                              ),
                            ),
                          )),
                    ],
                  ),
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
                  IconButton(icon: Icon(Icons.check), onPressed: processImage),
                  IconButton(icon: Icon(Icons.save), onPressed: saveImage),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
