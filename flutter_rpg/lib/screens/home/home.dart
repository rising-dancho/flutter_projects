import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Characters"),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Text("some texts"),
      ),
    );
  }
}
