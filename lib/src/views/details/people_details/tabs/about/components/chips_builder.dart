import 'package:flutter/material.dart';

import '../../../../../../configs/configs.dart';
import '../../../../components/header_text.dart';

class ChipsBuilder extends StatelessWidget {
  const ChipsBuilder({required this.chips, Key? key}) : super(key: key);
  final List<String?> chips;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderBuilder(headerText: "Also known as"),
        const SizedBox(height: 8),
        chips.isEmpty
            ? Text(
                'No data to show at the moment',
                style: TextStyle(
                  color: primaryDarkBlue.withOpacity(0.6),
                  fontSize: n - 2,
                ),
              )
            : Wrap(
                spacing: 4,
                runSpacing: 6,
                runAlignment: WrapAlignment.start,
                children: List.from(
                  chips.map(
                    (e) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: primaryDarkBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        e ?? "",
                        style: TextStyle(
                          fontSize: n - 2,
                          color: primaryDarkBlue.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
