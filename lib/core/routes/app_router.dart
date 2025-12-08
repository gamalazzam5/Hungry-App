import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/features/cart/data/repos/cart_repo.dart';
import 'package:hungry/features/cart/presentation/manager/cubits/get_cart_cubit/get_cart_cubit.dart';
import 'package:hungry/features/checkout/views/checkout_view.dart';
import 'package:hungry/features/home/data/models/product_model.dart';
import 'package:hungry/features/product/presentation/manager/add_to_cart_cubit.dart';
import 'package:hungry/root.dart';
import 'package:hungry/features/splash/views/splash_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/home/data/repos/product_repo.dart';
import '../../features/home/presentation/manager/cubits/options_cubit/options_cubit.dart';
import '../../features/home/presentation/manager/cubits/toppings_cubit/toppings_cubit.dart';
import '../../features/product/presentation/views/product_details_view.dart';
import '../utils/service_locator.dart';

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
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    ToppingsCubit(getIt<ProductRepo>())..getToppings(),
              ),
              BlocProvider(
                create: (_) => OptionsCubit(getIt<ProductRepo>())..getOptions(),
              ),
              BlocProvider(create: (_) => AddToCartCubit(getIt<CartRepo>())),
              BlocProvider(create: (_) => GetCartCubit(getIt<CartRepo>())),

            ],
            child: ProductDetailsView(productModel: product),
          );
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
