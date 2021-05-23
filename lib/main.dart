import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/bindings/init_bindings.dart';
import 'package:movie_app/src/views/dashboard/dashboard.dart';

void main() {
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
        canvasColor: Colors.white,
        primaryColor: Colors.white,
      ),
      home: DashboardPage(),
    );
  }
}
