import 'package:flutter/material.dart';

class CoffeePrefs extends StatelessWidget {
  const CoffeePrefs({super.key});

  void increaseStrByOne() {
    print("increased strength by 1");
  }

  void decreaseStrByOne() {
    print("decrease strength by 1");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text("Strength: "),
            const Text("3"),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              "assets/img/coffee_bean.png",
              width: 25,
              color: Colors.brown[100],
              colorBlendMode: BlendMode.multiply,
            ),
            const Expanded(child: SizedBox()),
            FilledButton(
                style: FilledButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.brown[700]),
                onPressed: decreaseStrByOne,
                child: const Text('+')),
          ],
        ),
        Row(
          children: [
            const Text("Sugar: "),
            const Text("3"),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              "assets/img/sugar_cube.png",
              width: 25,
              color: Colors.brown[100],
              colorBlendMode: BlendMode.multiply,
            ),
            const Expanded(child: SizedBox()),
            FilledButton(
                style: FilledButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.brown[700]),
                onPressed: decreaseStrByOne,
                child: const Text('+')),
          ],
        ),
      ],
    );
  }
}
