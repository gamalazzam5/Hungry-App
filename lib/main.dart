import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/network/api_service.dart';
import 'package:hungry/core/network/dio_client.dart';
import 'package:hungry/core/routes/app_router.dart';
import 'package:hungry/core/utils/service_locator.dart';
import 'package:hungry/core/utils/simple_bloc_observer.dart';
import 'package:hungry/features/auth/data/data_source/auth_remote_data_source_impl.dart';
import 'package:hungry/features/auth/data/repos/auth_repo.dart';
import 'package:hungry/features/auth/data/repos/auth_repo_impl.dart';
import 'package:hungry/features/auth/presentation/manager/cubits/auth_cubit/auth_cubit.dart';

import 'core/utils/pref_helpers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setUpServiceLocator();
  Bloc.observer = SimpleBlocObserver();
  print(await PrefHelpers.getToken());

  runApp(
    BlocProvider(
      create: (context) => getIt<AuthCubit>(),
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
