import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungry/core/routes/app_router.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
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
