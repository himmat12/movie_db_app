import 'package:flutter/material.dart';

import '../../../configs/configs.dart';

Widget headerBuilder({String? headerText}) => Text(
      headerText ?? 'headerText',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: primaryDarkBlue.withOpacity(0.8),
        fontSize: m - 4,
        fontWeight: FontWeight.w700,
      ),
    );
