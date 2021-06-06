import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/mixins/avatar.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';

class MovieCastsTab extends StatelessWidget with AvatarBuilderMixin {
  final _detailsController = Get.find<DetailsController>();
  final _configurationController = Get.find<ConfigurationController>();

  MovieCastsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
            child: Text(
              '${_detailsController.movieDetail.value.credits!.cast!.length} Persons',
              style: TextStyle(
                color: primaryDarkBlue.withOpacity(0.7),
                fontSize: n,
              ),
            ),
          ),
          ListView.separated(
            itemCount:
                _detailsController.movieDetail.value.credits!.cast!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              Cast cast =
                  _detailsController.movieDetail.value.credits!.cast![index];

              return InkWell(
                onTap: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: cast.profilePath == null
                            ? avatarBuilder()
                            : CachedNetworkImage(
                                height: 68,
                                width: 68,
                                imageUrl:
                                    '${_configurationController.posterUrl}${cast.profilePath}',
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Container(color: Colors.black26),
                                errorWidget: (context, url, error) => Container(
                                  color: Colors.black38,
                                  child: const Center(
                                    child: Icon(
                                      Icons.error_outline,
                                      color: primaryWhite,
                                      size: 34,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cast.name ?? "name",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: m - 4,
                                color: primaryDarkBlue.withOpacity(0.7),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              cast.character ?? "character",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: n - 2,
                                color: primaryDarkBlue.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
