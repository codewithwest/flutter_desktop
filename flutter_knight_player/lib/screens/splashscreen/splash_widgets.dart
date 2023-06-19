import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashWigets {
  loadingText() {
    Future.delayed(const Duration(seconds: 3));
    return const Text(
      'Preparing Your Player for first use',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    );
  }

  loadingWidget() {
    Future.delayed(const Duration(seconds: 3));
    return Card(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: const Color.fromARGB(255, 26, 153, 68),
        size: 50,
      ),
    );
  }
}
