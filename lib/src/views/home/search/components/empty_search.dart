import 'package:flutter/material.dart';

import '../../../../configs/configs.dart';

class EmptySearch extends StatelessWidget {
  const EmptySearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 48,
            color: primaryDarkBlue.withOpacity(0.6),
          ),
          Text(
            'No search history yet',
            style: TextStyle(
              color: primaryDarkBlue.withOpacity(0.8),
              fontSize: n,
            ),
          ),
        ],
      ),
    );
  }
}
