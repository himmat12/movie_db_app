import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';

Widget posterCard({required String? imageUrl}) {
  final _configurationController = Get.find<ConfigurationController>();

  return Container(
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
              imageUrl: '${_configurationController.posterUrl}$imageUrl',
              placeholder: (context, url) => Container(
                color: Colors.black12,
              ),
            ),
    ),
  );
}