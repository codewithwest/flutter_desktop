//import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard.dart';
// import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const DashBoard(),
    );
  }
}
