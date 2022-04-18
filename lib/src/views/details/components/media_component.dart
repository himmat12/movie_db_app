import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import 'header_text.dart';

class MediaComponent extends StatelessWidget {
  const MediaComponent({
    required this.posterUrl,
    required this.backdropUrl,
    this.posterTitle,
    this.backdropTitle,
    Key? key,
  }) : super(key: key);

  final String posterUrl;
  final String backdropUrl;
  final String? posterTitle;
  final String? backdropTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerBuilder(headerText: "Media"),
        const SizedBox(height: 12),
        Row(
          children: [
            /// poster
            Expanded(
              flex: 3,
              child: posterUrl.isEmpty || posterUrl == ""
                  ? Container(
                      alignment: Alignment.center,
                      height: 136,
                      color: Colors.black12,
                      child: const Icon(
                        Icons.error_outline,
                        color: primaryWhite,
                        size: 34,
                      ),
                    )
                  : imageHelper(
                      onTap: () {
                        Get.toNamed('/poster_viewer');
                      },
                      height: 136,
                      url: posterUrl,
                      title: posterTitle,
                    ),
            ),
            const SizedBox(width: 8),

            /// backdrop
            Expanded(
              flex: 7,
              child: backdropUrl.isEmpty || backdropUrl == ""
                  ? Container(
                      alignment: Alignment.center,
                      height: 136,
                      color: Colors.black12,
                      child: const Icon(
                        Icons.error_outline,
                        color: primaryWhite,
                        size: 34,
                      ),
                    )
                  : imageHelper(
                      onTap: () {
                        Get.toNamed('/backdrops_viewer');
                      },
                      height: 136,
                      url: backdropUrl,
                      title: backdropTitle,
                    ),
            ),
          ],
        ),
      ],
    );
  }

  // helper
  Widget imageHelper({
    required String url,
    double? width,
    double? height,
    String? title,
    void Function()? onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                width: width,
                height: height,
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
                imageUrl: url,
                placeholder: (context, url) => Container(
                  color: Colors.black12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                title ?? "title",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: n - 2,
                  fontWeight: FontWeight.w600,
                  color: primaryWhite,
                  height: 1.2,
                  shadows: [
                    Shadow(
                      color: primaryDarkBlue,
                      blurRadius: 2,
                      offset: Offset(1, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
