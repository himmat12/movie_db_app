import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';
import 'package:movie_app/src/models/details/tv_details_model.dart';
import 'package:movie_app/src/views/deatils/components/header_text.dart';

Widget networkBuilder({required List<Network> networks}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      headerBuilder(headerText: "Networks"),
      const SizedBox(height: 8),
      Wrap(
        runSpacing: 6,
        runAlignment: WrapAlignment.start,
        children: List.from(
          networks.map(
            (e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: primaryDarkBlue.withOpacity(0.6),
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
    ],
  );
}
