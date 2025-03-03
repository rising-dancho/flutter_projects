import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker_demo/logic/bounding_box_painter.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _selectedImage;
  String? _error;
  Map<String, dynamic>? _response;
  List<List<int>> _boxes = [];
  Size? _imageSize;
  Size? _displayedSize;

  Future<void> _selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      setState(() => _error = "You did not select any image.");
      return;
    }

    final file = File(pickedFile.path);
    final decodedImage = await decodeImageFromList(await file.readAsBytes());

    setState(() {
      _selectedImage = file;
      _imageSize =
          Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
      _error = null;
    });
  }

  Future<void> _handleSubmit() async {
    if (_selectedImage == null) {
      setState(() => _error = "No image selected");
      return;
    }

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
          "https://objectdetection-b2afgyctf0bsgrd4.southeastasia-01.azurewebsites.net/object-detection"),
    );

    request.files
        .add(await http.MultipartFile.fromPath("image", _selectedImage!.path));

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("Response: ${response.body}"); // Debugging line

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData["bounding_boxes"] is List) {
          List<List<int>> parsedBoxes = [];
          for (var box in jsonData["bounding_boxes"]) {
            if (box is List && box.length == 4) {
              parsedBoxes.add(box.map((e) => e as int).toList());
            }
          }

          print("Parsed Boxes: $parsedBoxes"); // Debugging line

          setState(() {
            _response = jsonData;
            _boxes = parsedBoxes;
            _error = null;
          });
        } else {
          setState(() => _error = "Invalid bounding box format received.");
        }
      } else {
        setState(
            () => _error = "Error uploading image: ${response.reasonPhrase}");
      }
    } catch (e) {
      setState(() => _error = "Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: _selectImage, child: const Text("Select Image")),
            ElevatedButton(
              onPressed: _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _selectedImage == null ? Colors.grey : Colors.blue,
              ),
              child: const Text("Upload and Process"),
            ),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            if (_selectedImage != null && _imageSize != null)
              LayoutBuilder(
                builder: (context, constraints) {
                  final double displayWidth = constraints.maxWidth;
                  final double displayHeight =
                      displayWidth / (_imageSize?.aspectRatio ?? 1);

                  _displayedSize = Size(displayWidth, displayHeight);

                  return Stack(
                    children: [
                      Image.file(
                        _selectedImage!,
                        width: displayWidth,
                        height: displayHeight,
                        fit: BoxFit.contain,
                      ),
                      if (_boxes.isNotEmpty && _displayedSize != null)
                        Positioned.fill(
                          child: CustomPaint(
                            painter: BoundingBoxPainter(
                                _boxes, _imageSize!, _displayedSize!),
                          ),
                        ),
                    ],
                  );
                },
              ),
            if (_response != null)
              Text("Object Count: ${_response!['object_count']}",
                  style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
