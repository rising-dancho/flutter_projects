import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
    appBar: AppBar(
      title: const Text("Coffee App"),
      backgroundColor: Colors.brown[700],
      centerTitle: true,
    ),
    body: const Home(),
  )));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[700],
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: const Text("hello, ninjas",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 4,
              decoration: TextDecoration.underline,
              fontStyle: FontStyle.italic)),
    );
  }
}
