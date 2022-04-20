import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../configs/configs.dart';
import '../../../../../../controllers/configuration_controller.dart';
import '../../../../../../models/details/movie_details_model.dart';
import '../../../../components/header_text.dart';

class MovieInfoBuilder extends GetView<ConfigurationController> {
  const MovieInfoBuilder({required this.movieDetails, Key? key})
      : super(key: key);
  final MovieDetailsModel movieDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderBuilder(headerText: "Movie Info"),
        const SizedBox(height: 12),
        RowBuilder(title: "English Title", text: movieDetails.title ?? "-"),
        RowBuilder(
            title: "Original Title", text: movieDetails.originalTitle ?? "-"),
        RowBuilder(title: "Status", text: movieDetails.status ?? "-"),
        RowBuilder(title: "Runtime", text: '${movieDetails.runtime} mins'),
        RowBuilder(
            title: "Original Language",
            text: movieDetails.originalLanguage ?? "-"),
        RowBuilder(
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
        RowBuilder(
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
                            imageUrl: '${controller.posterUrl}${e.logoPath}'),
                      ),
              ),
            ),
          ),
        ),
        RowBuilder(title: "Budget", text: '\$${movieDetails.budget}'),
        RowBuilder(title: "Revenue", text: '\$${movieDetails.revenue}'),
      ],
    );
  }
}

// row builder helper widget
class RowBuilder extends StatelessWidget {
  const RowBuilder({required this.title, this.text, this.child, Key? key})
      : super(key: key);

  final String title;
  final String? text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
  }
}
