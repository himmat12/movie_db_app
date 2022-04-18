import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../controllers/configuration_controller.dart';

Widget posterCard({required String? imageUrl}) {
  final _configurationController = Get.find<ConfigurationController>();

  return GestureDetector(
    onTap: imageUrl == null
        ? null
        : () {
            Get.toNamed(
              '/poster_preview',
              arguments: {"filePath": imageUrl},
            );
          },
    child: Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: imageUrl == null
            ? Container(
                alignment: Alignment.center,
                width: 94,
                height: 140,
                color: Colors.black12,
                child: const Icon(
                  Icons.error_outline,
                  color: primaryWhite,
                  size: 34,
                ),
              )
            : CachedNetworkImage(
                width: 94,
                height: 140,
                fit: BoxFit.fill,
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
                imageUrl: '${_configurationController.posterUrl}$imageUrl',
                placeholder: (context, url) => Container(
                  color: Colors.black12,
                ),
              ),
      ),
    ),
  );
}
