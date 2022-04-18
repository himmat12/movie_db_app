import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../configs/configs.dart';
import '../../../../../../controllers/configuration_controller.dart';
import '../../../../../../controllers/details_controller.dart';
import '../../../../../../models/details/movie_details_model.dart';

class MovieCollection extends StatelessWidget {
  MovieCollection({
    required this.collection,
    Key? key,
  }) : super(key: key);
  final BelongsToCollection? collection;

  final _configurationController = Get.find<ConfigurationController>();
  final _detailsController = Get.find<DetailsController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                  '${_configurationController.backDropUrl}${collection!.backdropPath ?? _detailsController.movieDetail.value.backdropPath}'),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
          height: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black.withOpacity(0.2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Belongs to ${collection!.name}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: primaryWhite,
                  fontSize: m + 2,
                  shadows: [
                    Shadow(
                      color: primaryDarkBlue,
                      blurRadius: 4,
                      offset: Offset(1, 2),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 18),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/movie_collection_list', arguments: {
                    "collection_id":
                        "${_detailsController.movieDetail.value.belongsToCollection!.id}"
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryWhite),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'View the collection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryWhite,
                      shadows: [
                        Shadow(
                          color: primaryDarkBlue,
                          blurRadius: 4,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
