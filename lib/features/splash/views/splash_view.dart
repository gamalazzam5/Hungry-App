import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/routes/app_router.dart';
import 'package:hungry/core/utils/service_locator.dart';
import 'package:hungry/features/auth/data/repos/auth_repo_impl.dart';
import 'package:hungry/features/auth/presentation/manager/cubits/auth_cubit/auth_cubit.dart';
import '../../auth/data/repos/auth_repo.dart';
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
    getIt<AuthCubit>().autoLogin();
    animation = SplashAnimationController(vsync: this);
    animation.start();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (BuildContext context, state) async {
        await Future.delayed(const Duration(seconds: 3));
        if (!mounted) return;

        if (state is AuthAuthenticated || state is AuthGuest) {
          GoRouter.of(context).go(AppRoutePaths.root);
        } else if (state is AuthFailure) {
          GoRouter.of(context).go(AppRoutePaths.loginView);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: animation.controller,
                    builder: (_, __) {
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
                builder: (_, __) {
                  return Opacity(
                    opacity: animation.imageOpacity.value,
                    child: Image.asset('assets/splash/splash.png'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
