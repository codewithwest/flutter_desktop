//import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_knight_player/screens/dashboard/dashboard.dart';
import 'package:flutter_knight_player/screens/splashscreen/splashscreen.dart';
import 'package:get/get.dart';
// import 'package:bitsdojo_window/bitsdojo_window.dart';

Future<void> main() async {
  //DartVLC.initialize();
  runApp(const MyApp());
  /*
  doWhenWindowReady(() {
    const initialSize = Size(600, 450);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
  */
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

bool themeModeDark = true;

class _MyAppState extends State<MyApp> {
  changeTheme() {
    setState(() {
      print(themeModeDark);
      themeModeDark = !themeModeDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: themeModeDark ? ThemeData.dark() : ThemeData.light(),
      home: SplashScreen(notifyParentTheme: changeTheme),
    );
  }
}
