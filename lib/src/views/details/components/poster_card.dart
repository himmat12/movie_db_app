import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../controllers/configuration_controller.dart';

class PosterCard extends GetView<ConfigurationController> {
  const PosterCard({required this.imageUrl, Key? key}) : super(key: key);
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
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
                  imageUrl: '${controller.posterUrl}$imageUrl',
                  placeholder: (context, url) => Container(
                    color: Colors.black12,
                  ),
                ),
        ),
      ),
    );
  }
}
