import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/models/details/tv_details_model.dart';
import 'package:movie_app/src/views/details/components/header_text.dart';

Widget networkBuilder({required List<Network> networks}) {
  final _configurationController = Get.find<ConfigurationController>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      headerBuilder(headerText: "Networks"),
      const SizedBox(height: 8),
      Wrap(
        spacing: 4,
        runSpacing: 6,
        runAlignment: WrapAlignment.start,
        children: List.from(
          networks.map(
            (e) => Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              decoration: BoxDecoration(
                color: primaryDarkBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: e.logoPath == null || e.logoPath == ""
                  ? const SizedBox(
                      height: 40,
                      width: 40,
                    )
                  : CachedNetworkImage(
                      height: 40,
                      width: 40,
                      fit: BoxFit.scaleDown,
                      imageUrl:
                          '${_configurationController.logoUrl}${e.logoPath}'),
            ),
          ),
        ),
      ),
    ],
  );
}
