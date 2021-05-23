import 'package:flutter/material.dart';
import 'package:movie_app/src/views/dashboard/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movie DB",
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
    );
  }
}
