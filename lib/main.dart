import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_app/routes.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/configs/configs.dart';

import 'init_bindings.dart';
import 'src/views/dashboard/dashboard.dart';

void main() async {
  // get storage initialization
  await GetStorage.init('box');
  await GetStorage.init('prefs');

  // service locator initialization
  setUp();

  runApp(const MyApp(key: Key('muApp')));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: DashboardPage(),
      // home: const TestApiWidget(),
    );
  }
}
