import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_knight_player/screens/dashboard/dashboard.dart';
import 'package:flutter_knight_player/decorations/decoration.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  final Function notifyParentTheme;

  // ignore: prefer_typing_uninitialized_variables

  const SplashScreen({
    super.key,
    // Key? key,
    required this.notifyParentTheme,
  });
  // const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _counter = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  loadingText() {
    Future.delayed(const Duration(seconds: 10));
    return Text(
      'Preparing Your Player for first use',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 20,
          decoration: TextDecoration.none,
          color: AllMusicDecorations().secondaryColor()),
    );
  }

  loadingWidget() {
    Future.delayed(const Duration(seconds: 15));
    return Container(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: const Color.fromARGB(255, 149, 221, 4),
        size: 120,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DashBoard(
                      notifyParentTheme: widget.notifyParentTheme,
                    )))
      },
    );
    return SafeArea(
        child: Container(
      // Add box decoration
      decoration: const BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          transform: GradientRotation(50),
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.05, .3, .35, .45, 0.6, .75, .80, 0.95],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color.fromARGB(142, 72, 2, 38),
            Color.fromARGB(207, 54, 228, 244),
            Color.fromARGB(207, 19, 26, 27),
            Color.fromARGB(172, 15, 16, 12),
            Color.fromARGB(172, 15, 16, 12),
            Color.fromARGB(250, 107, 9, 182),
            Color.fromARGB(140, 49, 1, 56),
            Color.fromARGB(144, 196, 3, 170),
          ],
        ),
      ),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Welcome To Velocity Knight Player',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.italic,
                    fontSize: 25,
                    decoration: TextDecoration.none,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              loadingText(),
              const SizedBox(
                height: 20,
              ),
              loadingWidget(),
            ]),
      ),
    ));
  }
}
