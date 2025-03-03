import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_demo/screens/about/image_upload.dart';
import 'package:image_picker_demo/screens/home/home.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: [
              NavigationDestination(
                  icon: Icon(
                    Icons.format_list_numbered,
                    color: Colors.grey,
                  ),
                  label: "OpenCV"),
              NavigationDestination(
                  icon: Icon(
                    Icons.info,
                    color: Colors.grey,
                  ),
                  label: "Tensorflow Lite"),
            ]),
      ),
    );
  }
}

// dl getx package:  flutter pub add get
//manage navigation menu without using Stateful widget classes
class NavigationController extends GetxController {
  final Rx<int> selectedIndex =
      0.obs; // would only rerender whatever is inside obx

  final screens = [Home(), ImageUpload()];
}
