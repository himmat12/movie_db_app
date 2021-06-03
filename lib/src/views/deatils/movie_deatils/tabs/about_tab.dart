import 'package:flutter/material.dart';

class AboutTab extends StatelessWidget {
  final int index;
  const AboutTab({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Text('About $index'),
      ),
    );
  }
}
