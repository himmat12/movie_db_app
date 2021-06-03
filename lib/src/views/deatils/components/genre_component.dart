import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';

import 'header_text.dart';

Widget genreBuilder({required List<Genre> genres}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerBuilder(headerText: "Genre"),
        const SizedBox(height: 8),
        Row(
          children: List.from(
            genres.map(
              (e) => Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: primaryblue.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  e.name ?? "",
                  style: const TextStyle(color: primaryWhite),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
