import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/home/home.dart';
import 'package:flutter_rpg/theme.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the "Demo" banner
      theme: primaryTheme,
      home: const Home()));
}