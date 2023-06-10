import 'package:flutter/material.dart';
import 'toyRobot.dart';

void main() {
  runApp(const MyApp());
}

int lightDark = 0;

themeChoice(themeState) {
  if (themeState > 0) {
    return ThemeData.dark();
  } else {
    return ThemeData.light();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ToyRobot(),
      debugShowCheckedModeBanner: true,
    );
  }
}
