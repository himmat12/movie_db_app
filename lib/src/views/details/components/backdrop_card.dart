import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';

class BackdropCard extends StatelessWidget {
  const BackdropCard({required this.imageUrl, Key? key}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: imageUrl.isEmpty
          ? null
          : () {
              Get.toNamed(
                '/backdrop_preview',
                arguments: {"filePath": imageUrl},
              );
            },
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        errorWidget: (context, url, error) => Container(
          alignment: Alignment.center,
          // width: 94,
          // height: 140,
          color: Colors.black12,
          child: const Icon(
            Icons.error_outline,
            color: primaryWhite,
            size: 34,
          ),
        ),
      ),
    );
  }
}
