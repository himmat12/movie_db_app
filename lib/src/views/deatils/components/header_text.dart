import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/configs.dart';

Widget headerBuilder({String? headerText}) => Text(
      headerText ?? 'headerText',
      style: TextStyle(
        color: primaryDarkBlue.withOpacity(0.8),
        fontSize: m - 4,
        fontWeight: FontWeight.w700,
      ),
    );
