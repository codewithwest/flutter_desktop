import 'package:flutter/material.dart';
import 'package:flutter_knight_player/main.dart';
import 'package:get/get.dart';
// import 'player.dart';

class Settings extends StatefulWidget {
  // const Settings({super.key});
  final Function notifyParentTheme;

  // ignore: prefer_typing_uninitialized_variables

  Settings({
    Key? key,
    required this.notifyParentTheme,
  });

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
    // print(Get.isDarkMode);
    return ListTile(
      leading: IconButton(
        icon: Icon(
            themeModeDark ? Icons.abc_outlined : Icons.baby_changing_station),
        onPressed: () => {widget.notifyParentTheme()},
      ),
    );
    //Get.to(Folders());
  }
}
