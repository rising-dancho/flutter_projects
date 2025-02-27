import 'package:flutter/material.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledTitle("Sandbox"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              // welcome message
              Center(
                child: Icon(
                  Icons.code,
                  color: AppColors.primaryColor,
                ),
              ),
              const Center(
                child: StyledHeading("Welcome, new player."),
              ),
              const Center(
                child: StyledText("Create a name & slogan for your character."),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
