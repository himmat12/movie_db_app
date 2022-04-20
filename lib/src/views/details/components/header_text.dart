import 'package:flutter/material.dart';

import '../../../configs/configs.dart';

class HeaderBuilder extends StatelessWidget {
  const HeaderBuilder({Key? key, this.headerText}) : super(key: key);
  final String? headerText;

  @override
  Widget build(BuildContext context) {
    return Text(
      headerText ?? 'headerText',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: primaryDarkBlue.withOpacity(0.8),
        fontSize: m - 4,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
