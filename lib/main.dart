import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_app/routes.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/splash_screen.dart';
import 'package:movie_app/src/configs/configs.dart';

import 'init_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // get storage initialization
  await GetStorage.init('auth');
  await GetStorage.init('prefs');

  // service locator initialization
  setUp();

  runApp(const MyApp(key: Key('muApp')));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: Routes.getRoutes(),
      initialBinding: InitBindings(),
      title: "Movie DB",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        canvasColor: primaryWhite,
        primaryColor: primaryWhite,
      ),
      // home: DashboardPage(),
      // home: const AuthPage(),
      home: const SplashScreen(),
    );
  }
}
