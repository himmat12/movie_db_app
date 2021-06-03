import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/models/details/movie_details_model.dart';
import 'package:movie_app/src/views/deatils/components/header_text.dart';

Widget movieInfoBuilder({required MovieDetailsModel movieDetails}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      headerBuilder(headerText: "Movie Info"),
      const SizedBox(height: 12),
      rowBuilder(title: "English Title", text: movieDetails.title),
      rowBuilder(title: "Original Title", text: movieDetails.originalTitle),
      rowBuilder(title: "Status", text: movieDetails.status),
      rowBuilder(title: "Runtime", text: '${movieDetails.runtime} mins'),
      rowBuilder(
          title: "Original Language", text: movieDetails.originalLanguage),
      rowBuilder(
        title: "Production Countries",
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 4,
          runSpacing: 4,
          children: List.from(
            movieDetails.productionCountries!.map(
              (e) => e.name == null
                  ? const SizedBox.shrink()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 0),
                      decoration: BoxDecoration(
                        color: primaryblue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        e.name ?? "-",
                        style: TextStyle(
                          fontSize: n - 2,
                          color: primaryDarkBlue.withOpacity(0.7),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
      rowBuilder(
        title: "Companies",
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 4,
          runSpacing: 4,
          children: List.from(
            movieDetails.productionCompanies!.map(
              (e) => e.name == null
                  ? const SizedBox.shrink()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 0),
                      decoration: BoxDecoration(
                        color: primaryblue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        e.name ?? "-",
                        style: TextStyle(
                          fontSize: n - 2,
                          color: primaryDarkBlue.withOpacity(0.7),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
      rowBuilder(title: "Budget", text: '${movieDetails.budget}'),
      rowBuilder(title: "Revenue", text: '${movieDetails.revenue}'),
    ],
  );
}

// helper row
Widget rowBuilder({required String title, String? text, Widget? child}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: TextStyle(
                fontSize: n - 2,
                color: primaryDarkBlue.withOpacity(0.5),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            flex: 5,
            child: child ??
                Text(
                  text ?? "-",
                  style: TextStyle(
                    fontSize: n - 2,
                    color: primaryDarkBlue.withOpacity(0.7),
                  ),
                ),
          ),
        ],
      ),
    );
