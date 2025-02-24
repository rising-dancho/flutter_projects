import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/home/home.dart';
import 'package:flutter_rpg/theme.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the "Demo" banner
      theme: primaryTheme,
      home: const Home()));
}

class SandBox extends StatelessWidget {
  const SandBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sandbox"),
          backgroundColor: Colors.grey,
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Text("sandbox"),
        ));
  }
}
