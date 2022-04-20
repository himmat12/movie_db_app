import 'package:flutter/material.dart';

import '../../../configs/configs.dart';
import '../../../models/details/common_details_models.dart';
import 'header_text.dart';

class GenreBuilder extends StatelessWidget {
  const GenreBuilder({required this.genres, Key? key}) : super(key: key);
  final List<Genre> genres;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderBuilder(headerText: "Genre"),
        const SizedBox(height: 8),
        Wrap(
          spacing: 4,
          runSpacing: 6,
          runAlignment: WrapAlignment.start,
          children: List.from(
            genres.map(
              (e) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: primaryDarkBlue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  e.name ?? "",
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
