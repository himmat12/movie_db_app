import 'package:flutter/material.dart';

class MoreBtn extends StatelessWidget {
  const MoreBtn({
    Key? key,
    this.onTap,
    this.title,
  }) : super(key: key);

  final String? title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        color: Colors.transparent,
        child: Text(title ?? 'More'),
      ),
    );
  }
}
