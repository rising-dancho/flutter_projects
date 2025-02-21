import 'package:coffee_card/shared/styled_body_text.dart';
import 'package:coffee_card/shared/styled_button.dart';
import 'package:flutter/material.dart';

class CoffeePrefs extends StatefulWidget {
  const CoffeePrefs({super.key});

  @override
  State<CoffeePrefs> createState() => _CoffeePrefsState();
}

class _CoffeePrefsState extends State<CoffeePrefs> {
  int coffee = 1;
  int sugar = 1;

  void increaseCaffeineShotByOne() {
    setState(() {
      coffee = coffee < 5 ? coffee + 1 : 1;
    });
  }

  void increaseSugarByOne() {
    setState(() {
      sugar = sugar < 5 ? sugar + 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const StyledBodyText("Coffee: "),
            Text("($coffee)"),
            const SizedBox(
              width: 10,
            ),
            // KEEP ADDING image assets equal to coffee shots variable's current count
            for (int i = 0; i < coffee; i++)
              Image.asset(
                "assets/img/coffee_bean.png",
                width: 25,
                color: Colors.brown[100],
                colorBlendMode: BlendMode.multiply,
              ),
            const Expanded(child: SizedBox()),
            StyledButton(
                onPressed: increaseCaffeineShotByOne, child: const Text('+')),
          ],
        ),
        Row(
          children: [
            const StyledBodyText("Sugar: "),
            Text("($sugar)"),
            const SizedBox(
              width: 10,
            ),
            // IF sugar count equals zero (0) than displa text
            if (sugar == 0) const StyledBodyText("( No Sugar . . . )"),

            // KEEP ADDING image assets equal to sugars variable's current count
            for (int i = 0; i < sugar; i++)
              Image.asset(
                "assets/img/sugar_cube.png",
                width: 25,
                color: Colors.brown[100],
                colorBlendMode: BlendMode.multiply,
              ),
            const Expanded(child: SizedBox()),
            StyledButton(onPressed: increaseSugarByOne, child: const Text('+')),
          ],
        ),
      ],
    );
  }
}
