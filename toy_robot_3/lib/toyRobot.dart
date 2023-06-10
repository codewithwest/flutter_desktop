import 'package:flutter/material.dart';
import 'functions.dart';
import 'gameInit.dart';
import 'main.dart';

int _counter = 0;
int popit = 0;

class ToyRobot extends StatefulWidget {
  const ToyRobot({super.key});

  @override
  State<ToyRobot> createState() => _ToyRobotState();
}

class _ToyRobotState extends State<ToyRobot> {
  ifPressed() {
    setState(() {
      if (popit < 1) {
        popit++;
        theIcon(_counter);
        themeChoice(_counter);
      } else {
        popit--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Toy Robot",
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ifPressed,
            icon: theIcon(popit),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: const gameInit(),
      ),
    );
  }
}
