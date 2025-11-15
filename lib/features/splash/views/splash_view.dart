import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/routes/app_router.dart';
import '../widgets/splash_animation_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {

  late final SplashAnimationController animation;

  @override
  void initState() {
    super.initState();

    animation = SplashAnimationController(vsync: this);
    animation.start();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      context.go(AppRoutePaths.signupView);
    });
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: AnimatedBuilder(
                  animation: animation.controller,
                  builder: (_, _) {
                    return Opacity(
                      opacity: animation.logoOpacity.value,
                      child: Transform.scale(
                        scale: animation.logoScale.value,
                        child: SvgPicture.asset('assets/logo/logo.svg'),
                      ),
                    );
                  },
                ),
              ),
            ),

            AnimatedBuilder(
              animation: animation.controller,
              builder: (_, _) {
                return Opacity(
                  opacity: animation.imageOpacity.value,
                  child: Image.asset('assets/splash/splash.png'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
