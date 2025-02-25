import 'package:flutter/material.dart';
import 'package:image_picker/screens/home.dart';

void main() {
  runApp(MaterialApp(
      title: 'Image Picker Demo',
      debugShowCheckedModeBanner: false, // Removes the "Demo" banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: Home(title: "Image Picker")));
}
