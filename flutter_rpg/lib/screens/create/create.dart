import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/create/vocation_card.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  // dispose controller when its not needed anymore
  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  // submit handler
  void handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      print("name must not be empty");
      return;
    }

    if (_sloganController.text.trim().isEmpty) {
      print("slogan must not be empty");
      return;
    }

    print(_nameController.text);
    print(_sloganController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledTitle("Character Creation"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: SingleChildScrollView(
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
                  child:
                      StyledText("Create a name & slogan for your character."),
                ),
                SizedBox(
                  height: 20,
                ),

                // inputs
                TextField(
                  controller: _nameController,
                  style: GoogleFonts.kanit(
                      textStyle: Theme.of(context).textTheme.bodyMedium),
                  cursorColor: AppColors.textColor,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      label: StyledText("Character name")),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _sloganController,
                  style: GoogleFonts.kanit(
                      textStyle: Theme.of(context).textTheme.bodyMedium),
                  cursorColor: AppColors.textColor,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.chat),
                      label: StyledText("Character slogan")),
                ),
                const SizedBox(height: 30),

                // select vocation title
                Center(
                  child: Icon(
                    Icons.code,
                    color: AppColors.primaryColor,
                  ),
                ),
                const Center(
                  child: StyledHeading("Choose a vocation."),
                ),
                const Center(
                  child: StyledText("This determines your available skills."),
                ),
                SizedBox(
                  height: 20,
                ),

                // vocations
                const VocationCard(vocation: Vocation.junkie),
                const VocationCard(vocation: Vocation.ninja),
                const VocationCard(vocation: Vocation.raider),
                const VocationCard(vocation: Vocation.wizard),

                Center(
                  child: StyledButton(
                      onPressed: handleSubmit,
                      child: StyledHeading("Create Character")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
