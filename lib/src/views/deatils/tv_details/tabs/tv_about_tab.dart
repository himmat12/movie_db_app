import 'package:flutter/material.dart';

class TvAboutTab extends StatelessWidget {
  final int index;
  const TvAboutTab({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Text('TV About $index'),
      ),
    );
  }
}
