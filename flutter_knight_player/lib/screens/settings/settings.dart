import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'player.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  themeState() {
    setState(() {
      if (Get.isDarkMode) {
        //Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
        Get.changeTheme(ThemeData.light());
      } else {
        Get.changeTheme(ThemeData.dark());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(Get.isDarkMode);
    return Container(
      child: IconButton(
        icon: Icon(Icons.abc),
        onPressed: () => {themeState()},
      ),
    );
    //Get.to(Folders());
  }
}
