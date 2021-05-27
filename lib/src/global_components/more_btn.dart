import 'package:flutter/material.dart';

Widget moreBtn({String? title, void Function()? onTap}) => GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        color: Colors.transparent,
        child: Text(title ?? 'More'),
      ),
    );
