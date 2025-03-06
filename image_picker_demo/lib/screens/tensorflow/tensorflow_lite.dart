import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_demo/logic/photo_viewer.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:ui' as ui;

class TensorflowLite extends StatefulWidget {
  const TensorflowLite({super.key});

  @override
  State<TensorflowLite> createState() => _TensorflowLiteState();
}

class _TensorflowLiteState extends State<TensorflowLite> {
  // Image galler and camera variables
  File? _selectedImage;
  late ImagePicker imagePicker;
  // EXPLANATION about ui.Image:
  // In Flutter, ui.Image (from dart:ui) is an in-memory representation of an image that allows direct manipulation in a Canvas via CustomPainter. Unlike Image.file or Image.asset, which are widgets for displaying images in the UI, ui.Image is specifically used for low-level drawing operations.
  ui.Image? image_for_drawing;

  // initialize object detector
  late ObjectDetector objectDetector;
  // detected objects array
  List<DetectedObject> objects = [];

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    // USE DEFAULT PRETRAINED MODEL: load initial pretrained object detector
    // EXPLANATION: https://pub.dev/packages/google_mlkit_object_detection#create-an-instance-of-objectdetector
    final options = ObjectDetectorOptions(
        mode: DetectionMode.single,
        classifyObjects: true,
        multipleObjects: true);
    // initialize object detector inside initState (REQUIRED)
    objectDetector = ObjectDetector(options: options);
    // loadModel();
  }

  // OBJECT DETECTION
  // loadModel() async {
  //   final modelPath = await getModelPath('assets/ml/checkpoint_epoch_1.tflite');
  //   final options = LocalObjectDetectorOptions(
  //     mode: DetectionMode.single,
  //     modelPath: modelPath,
  //     classifyObjects: true,
  //     multipleObjects: true,
  //   );
  //   objectDetector = ObjectDetector(options: options);
  // }

  Future<String> getModelPath(String asset) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$asset';
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  doObjectDetection() async {
    if (_selectedImage == null) {
      print("No image selected!");
      return;
    }

    print("Starting object detection...");
    InputImage inputImage = InputImage.fromFile(_selectedImage!);

    // PASS THE IMAGE INTO THE OBJECT DETECTOR:
    objects = await objectDetector.processImage(inputImage);
    print("Objects detected: ${objects.length}");

    for (DetectedObject detectedObject in objects) {
      final rect = detectedObject.boundingBox;
      final trackingId = detectedObject.trackingId;

      for (Label label in detectedObject.labels) {
        print('RESPONSE: ${label.text} ${label.confidence} $rect $trackingId!');
      }
    }

    // Ensure setState updates UI
    setState(() {});

    drawRectanglesAroundObjects();
  }

  Future<void> drawRectanglesAroundObjects() async {
    if (_selectedImage == null) return;

    // Read image bytes
    Uint8List imageBytes = await _selectedImage!.readAsBytes();

    // Decode image
    ui.Image decodedImage = await decodeImageFromList(imageBytes);

    setState(() {
      image_for_drawing = decodedImage; // Now image is a ui.Image
    });
  }

  // END

  @override
  void dispose() {
    super.dispose();
  }

  imageGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      setState(() {
        _selectedImage;
      });
    }
  }

  useCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
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
                  child: image_for_drawing == null
                      ? Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 120,
                          color: Colors.grey[500],
                        )
                      : PhotoViewer(
                          imageFile: _selectedImage!,
                          imageForDrawing:
                              image_for_drawing, // Passes correctly
                          objects: objects,
                        ),
                ),
              ),
              ElevatedButton(
                  onPressed: imageGallery,
                  onLongPress: useCamera,
                  child: const Text("Choose/Capture")),
              ElevatedButton(
                onPressed: doObjectDetection,
                child: const Text("Upload and Process"),
              ),
            ],
          ),
        ));
  }
}

// class ObjectPainter extends CustomPainter {
//   List<DetectedObject> objectList;
//   dynamic imageFile;
//   ObjectPainter({required this.objectList, @required this.imageFile});

//   @override
//   void paint(Canvas canvas, Size size) {
//     if (imageFile != null) {
//       canvas.drawImage(imageFile, Offset.zero, Paint());
//     }
//     Paint paint = Paint();
//     paint.color = Colors.green;
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 6;

//     for (DetectedObject rectangle in objectList) {
//       canvas.drawRect(rectangle.boundingBox, paint);
//       var list = rectangle.labels;
//       for (Label label in list) {
//         print("${label.text}   ${label.confidence.toStringAsFixed(2)}");
//         TextSpan span = TextSpan(
//             text: "${label.text} ${label.confidence.toStringAsFixed(2)}",
//             style: const TextStyle(fontSize: 25, color: Colors.blue));
//         TextPainter tp = TextPainter(
//             text: span,
//             textAlign: TextAlign.left,
//             textDirection: TextDirection.ltr);
//         tp.layout();
//         tp.paint(canvas,
//             Offset(rectangle.boundingBox.left, rectangle.boundingBox.top));
//         break;
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
