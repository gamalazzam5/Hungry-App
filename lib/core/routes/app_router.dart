import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/features/auth/view/signup_view.dart';
import 'package:hungry/splash.dart';
import 'package:go_router/go_router.dart';
class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) =>  const SignupView()),
    ],
  );
}

class AppRoutePaths {
  static String get homeViw => "/home_view";
  static String get loginView => "/login_view";
  static String get signupView => "/signup_view";

}
