import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
    appBar: AppBar(
      title: const Text("Coffee App"),
      backgroundColor: Colors.brown[700],
      centerTitle: true,
    ),
    body: const Text("Hello, ninjas!!")
  )));
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}