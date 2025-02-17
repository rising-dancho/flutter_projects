import 'package:coffee_card/widgets/coffee_prefs.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Coffee Id",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.brown[700],
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.brown[200],
            padding: EdgeInsets.all(20),
            child: Text("How I like my coffee..."),
          ),
          Container(
            color: Colors.brown[100],
            padding: EdgeInsets.all(20),
            child: const CoffeePrefs(),
          ),
          Expanded(
              child: Image.asset(
            "assets/img/coffee_bg.jpg",
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomRight,
          )),
        ],
      ),
    );
  }
}
