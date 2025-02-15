// import 'package:coffee_card/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Sandbox(),
  ));
}

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        title: Text(
          "Coffee App",
          style: TextStyle(
            fontSize: 24,
            wordSpacing: 8,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.orange[700],
            padding: EdgeInsets.all(20),
            child: Text("Wassap"),
          ),
          Container(
            color: Colors.orange[500],
            padding: EdgeInsets.all(20),
            child: Text("Wassap"),
          )
        ],
      ),
    );
  }
}
