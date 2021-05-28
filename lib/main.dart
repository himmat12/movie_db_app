import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/bindings/init_bindings.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/views/dashboard/dashboard.dart';

void main() async {
  // get storage initialization
  await GetStorage.init('box');
  await GetStorage.init('prefs');

  // service locator initialization
  setUp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitBindings(),
      title: "Movie DB",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        canvasColor: primaryWhite,
        primaryColor: primaryWhite,
      ),
      home: DashboardPage(),
    );
  }
}
