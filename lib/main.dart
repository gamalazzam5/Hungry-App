import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/routes/app_router.dart';
import 'package:hungry/core/utils/service_locator.dart';
import 'package:hungry/core/utils/simple_bloc_observer.dart';
import 'package:hungry/features/auth/presentation/manager/cubits/auth_cubit/auth_cubit.dart';
import 'package:hungry/features/home/presentation/manager/cubits/product_cubit/product_cubit.dart';

import 'core/utils/pref_helpers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setUpServiceLocator();
  Bloc.observer = SimpleBlocObserver();
  print(await PrefHelpers.getToken());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<ProductCubit>()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      title: 'Hungry',
      theme: ThemeData(
        splashColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
