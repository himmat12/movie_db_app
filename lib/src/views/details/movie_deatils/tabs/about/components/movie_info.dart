import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../configs/configs.dart';
import '../../../../../../controllers/configuration_controller.dart';
import '../../../../../../models/details/movie_details_model.dart';
import '../../../../components/header_text.dart';

Widget movieInfoBuilder({required MovieDetailsModel movieDetails}) {
  final _configurationController = Get.find<ConfigurationController>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      headerBuilder(headerText: "Movie Info"),
      const SizedBox(height: 12),
      rowBuilder(title: "English Title", text: movieDetails.title ?? "-"),
      rowBuilder(
          title: "Original Title", text: movieDetails.originalTitle ?? "-"),
      rowBuilder(title: "Status", text: movieDetails.status ?? "-"),
      rowBuilder(title: "Runtime", text: '${movieDetails.runtime} mins'),
      rowBuilder(
          title: "Original Language",
          text: movieDetails.originalLanguage ?? "-"),
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
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        // color: primaryDarkBlue.withOpacity(0.5),
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
      ),
      rowBuilder(
        title: "Companies",
        child: Wrap(
          alignment: WrapAlignment.start,
          // spacing: 4,
          runSpacing: 4,
          children: List.from(
            movieDetails.productionCompanies!.map(
              (e) => e.logoPath == null || e.logoPath!.isEmpty
                  ? const SizedBox.shrink()
                  : Container(
                      margin: const EdgeInsets.only(right: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        color: primaryDarkBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CachedNetworkImage(
                          height: 40,
                          width: 40,
                          fit: BoxFit.scaleDown,
                          errorWidget: (context, url, error) => Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Colors.black12,
                                ),
                                child: const Icon(
                                  Icons.error,
                                  color: primaryWhite,
                                ),
                              ),
                          imageUrl:
                              '${_configurationController.posterUrl}${e.logoPath}'),
                    ),
            ),
          ),
        ),
      ),
      rowBuilder(title: "Budget", text: '\$${movieDetails.budget}'),
      rowBuilder(title: "Revenue", text: '\$${movieDetails.revenue}'),
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
