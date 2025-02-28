import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/create/vocation_card.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

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

  // handling vocation selection
  Vocation selectedVocation = Vocation.junkie;

  // change the selectedVocation to whichever was passed and trigger a rerender using setState
  void updateVocation(Vocation vocation) {
    setState(() {
      selectedVocation = vocation;
    });
  }

  // submit handler
  void handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      // TODO: show an error dialog
      return;
    }

    if (_sloganController.text.trim().isEmpty) {
      // TODO: show an error dialog
      return;
    }

    characters.add(Character(
        name: _nameController.text.trim(),
        slogan: _sloganController.text.trim(),
        vocation: selectedVocation,
        id: uuid.v4()));
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
                VocationCard(
                    selected: selectedVocation == Vocation.junkie,
                    onTap: updateVocation,
                    vocation: Vocation.junkie),
                VocationCard(
                    selected: selectedVocation == Vocation.ninja,
                    onTap: updateVocation,
                    vocation: Vocation.ninja),
                VocationCard(
                    selected: selectedVocation == Vocation.raider,
                    onTap: updateVocation,
                    vocation: Vocation.raider),
                VocationCard(
                    selected: selectedVocation == Vocation.wizard,
                    onTap: updateVocation,
                    vocation: Vocation.wizard),

                // good luck message
                Center(
                  child: Icon(
                    Icons.code,
                    color: AppColors.primaryColor,
                  ),
                ),
                const Center(
                  child: StyledHeading("Good Luck."),
                ),
                const Center(
                  child:
                      StyledText("And enjoy the journey...."),
                ),
                SizedBox(
                  height: 20,
                ),

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
