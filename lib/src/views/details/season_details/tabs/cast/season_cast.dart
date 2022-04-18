import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../configs/configs.dart';
import '../../../../../controllers/configuration_controller.dart';
import '../../../../../controllers/people_controller.dart';
import '../../../../../controllers/season_controller.dart';
import '../../../../../mixins/avatar.dart';
import '../../../../../models/details/common_details_models.dart';

class SeasonCastsTab extends StatelessWidget with AvatarBuilderMixin {
  final _seasonController = Get.find<SeasonController>();
  final _configurationController = Get.find<ConfigurationController>();
  final _peopleController = Get.find<PeopleController>();

  SeasonCastsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Text(
            '${_seasonController.seasonModel.value.credits!.cast == null ? 0 : _seasonController.seasonModel.value.credits!.cast!.length} Persons',
            style: TextStyle(
              color: primaryDarkBlue.withOpacity(0.7),
              fontSize: n,
            ),
          ),
        ),
        ListView.separated(
          itemCount: _seasonController.seasonModel.value.credits!.cast == null
              ? 0
              : _seasonController.seasonModel.value.credits!.cast!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            Cast cast =
                _seasonController.seasonModel.value.credits!.cast![index];

            return InkWell(
              onTap: () {
                _peopleController.setPersonId(cast.id!);
                Get.toNamed('/people_details');
              },
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
    );
  }
}
