import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../configs/strings.dart';
import '../../../controllers/utility_controller.dart';
import '../../../models/details/common_details_models.dart';
import 'header_text.dart';

class TrailerComponent extends StatelessWidget {
  TrailerComponent({
    required this.videos,
    Key? key,
  }) : super(key: key);
  final Videos videos;

  final _utilityController = Get.find<UtilityController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: headerBuilder(headerText: "Teasers & Trailers"),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 118,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: videos.results == null ? 0 : videos.results!.length,
            scrollDirection: Axis.horizontal,
            cacheExtent: 1200,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return videos.results == null
                  ? const SizedBox.shrink()
                  : GestureDetector(
                      onTap: () {
                        _utilityController.loadUrl(
                            url:
                                '$youtubeUrlString/${videos.results![index].key}');
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: 152,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                height: 92,
                                fit: BoxFit.fill,
                                placeholder: (context, url) =>
                                    Container(color: Colors.black12),
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
                                    '$youtubeThumbnailString/${videos.results![index].key}$mqQualityString',
                              ),
                            ),
                            Text(
                              videos.results![index].name ?? 'Trailer',
                              style: const TextStyle(color: primaryDarkBlue05),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}
