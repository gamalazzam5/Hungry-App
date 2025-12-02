import 'package:flutter/material.dart';

class SplashAnimationController {
  final TickerProvider vsync;
  late final AnimationController controller;
  late final Animation<double> logoOpacity;
  late final Animation<double> logoScale;
  late final Animation<double> imageOpacity;
  late Future<void> completeFuture;

  SplashAnimationController({required this.vsync}) {

    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 2),
    );

    logoOpacity = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    );

    logoScale = Tween(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    imageOpacity = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );
  }

  void start() {
    completeFuture = controller.forward();
  }

  void dispose() => controller.dispose();
}
