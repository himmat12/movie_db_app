import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/models/details/movie_details_model.dart';
import 'package:movie_app/src/models/details/tv_details_model.dart';
import 'package:movie_app/src/views/deatils/components/header_text.dart';

Widget tvInfoBuilder({required TvDetailsModel tvDetails}) {
  final String? lastAirDate = tvDetails.lastAirDate == null
      ? "-"
      : DateFormat.yMMMMd().format(tvDetails.lastAirDate!);

  final String? firstAirDate = tvDetails.firstAirDate == null
      ? "-"
      : DateFormat.yMMMMd().format(tvDetails.firstAirDate!);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      headerBuilder(headerText: "TV Show Info"),
      const SizedBox(height: 12),
      rowBuilder(title: "English Title", text: tvDetails.name),
      rowBuilder(title: "Original Title", text: tvDetails.originalName),
      rowBuilder(title: "First Air Date", text: firstAirDate),
      rowBuilder(title: "Last Air Date", text: lastAirDate),
      rowBuilder(
          title: "Aired Episodes", text: '${tvDetails.numberOfEpisodes}'),
      rowBuilder(
          title: "Runtime",
          text:
              '${tvDetails.episodeRunTime!.isEmpty ? "-" : tvDetails.episodeRunTime![0]} mins'),
      rowBuilder(title: "Show Type", text: tvDetails.type),
      rowBuilder(title: "Original Language", text: tvDetails.originalLanguage),
      rowBuilder(
        title: "Production Countries",
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 4,
          runSpacing: 4,
          children: List.from(
            tvDetails.productionCountries!.map(
              (e) => e.name == null
                  ? const SizedBox.shrink()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: primaryDarkBlue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        e.name ?? "",
                        style: const TextStyle(
                          fontSize: n - 4,
                          color: primaryWhite,
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
            tvDetails.productionCompanies!.map(
              (e) => e.name == null
                  ? const SizedBox.shrink()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: primaryDarkBlue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        e.name ?? "",
                        style: const TextStyle(
                          fontSize: n - 4,
                          color: primaryWhite,
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
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
