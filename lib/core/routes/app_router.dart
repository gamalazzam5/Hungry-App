import 'package:hungry/features/auth/views/login_view.dart';
import 'package:hungry/features/auth/views/signup_view.dart';
import 'package:hungry/features/checkout/views/checkout_view.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/product/views/product_details_view.dart';
import 'package:hungry/root.dart';
import 'package:hungry/features/splash/views/splash_view.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: AppRoutePaths.root,
        builder: (context, state) => const Root(),
      ),
      GoRoute(
        path: AppRoutePaths.loginView,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutePaths.signupView,
        builder: (context, state) => const SignupView(),
      ),

      GoRoute(
        path: AppRoutePaths.productDetailsView,
        builder: (context, state) {
          final product = state.extra as ProductModel;
          return ProductDetailsView(productModel: product);
        },
      ),
      GoRoute(
        path: AppRoutePaths.checkout,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return CheckoutView(
            totalPrice: data['totalPrice'],
            items: data['items'],
            quantities: data['quantities'],
          );
        },
      ),
    ],
  );
}

class AppRoutePaths {
  static String get homeViw => "/home_view";

  static String get loginView => "/login_view";

  static String get signupView => "/signup_view";

  static String get root => "/root";

  static String get productDetailsView => "/product_details_view";

  static String get checkout => "/checkout";
}
