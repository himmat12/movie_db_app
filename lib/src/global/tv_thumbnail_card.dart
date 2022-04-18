import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/configs.dart';
import '../controllers/results_controller.dart';
import '../models/results/tv_result_model.dart';

Widget tvThumbnailCard({
  required TvResultsModel tv,
  required String imageUrl,
  EdgeInsetsGeometry? padding,
  void Function()? onLongPress,
}) {
  final _resultController = Get.find<ResultsController>();

  return GestureDetector(
    onLongPress: onLongPress,
    onTap: () {
      // _resultController.setTv(tv);

      _resultController.setTvId('${tv.id!}');

      Get.offAllNamed('/tv_details');
    },
    child: SizedBox(
      width: 100,
      height: 186,
      child: Column(
        children: [
          Container(
            padding: padding ?? const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: tv.posterPath == null
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
                          imageUrl: imageUrl,
                          placeholder: (context, url) => Container(
                            color: Colors.black12,
                          ),
                        ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: padding ?? const EdgeInsets.fromLTRB(6, 0, 6, 0),
                    decoration: BoxDecoration(
                      color: primaryDark.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${tv.voteAverage}',
                      style: const TextStyle(
                        fontSize: n - 5,
                        color: primaryWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // tv title and option
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    tv.name ?? "Title",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: n - 5,
                      fontWeight: FontWeight.w600,
                      // letterSpacing: 0.2,
                      color: primaryDark,
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     // ignore: avoid_print
                //     print('options bottom sheet ...');
                //   },
                //   child: const Icon(
                //     Icons.more_vert,
                //     color: primaryDarkBlue,
                //     size: 18,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
