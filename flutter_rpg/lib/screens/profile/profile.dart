import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledTitle(character.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // basic info - image, vocation, description
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.secondaryColor.withAlpha((0.3 * 255).toInt()),
              child: Row(
                children: [
                  Image.asset(
                    "assets/img/vocations/${character.vocation.image}",
                    width: 140,
                    height: 140,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StyledHeading(character.vocation.title),
                      StyledText(character.vocation.description),
                    ],
                  ))
                ],
              ),
            ),
            // weapon and ability
            const SizedBox(
              height: 20,
            ),

            Center(
              child: Icon(
                Icons.code,
                color: AppColors.primaryColor,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: AppColors.secondaryColor.withAlpha((0.3 * 255).toInt()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StyledHeading("Slogan"),
                    StyledText(character.slogan),
                    const StyledHeading("Weapon of choice"),
                    StyledText(character.vocation.weapon),
                    const StyledHeading("Unique Ability"),
                    StyledText(character.vocation.ability),
                  ],
                ),
              ),
            ),

            // stats & skills

            // save button
          ],
        ),
      ),
    );
  }
}
