import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/configs.dart';
import '../../../../controllers/configuration_controller.dart';
import '../../../../controllers/people_controller.dart';
import '../../../../controllers/season_controller.dart';
import '../../components/header_text.dart';

class GuestCasts extends StatelessWidget {
  GuestCasts({Key? key}) : super(key: key);

  final _seasonController = Get.find<SeasonController>();
  final _configurationController = Get.find<ConfigurationController>();
  final _peopleController = Get.find<PeopleController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            headerBuilder(headerText: "Guest Stars"),
            IconButton(
                onPressed: () {
                  Get.toNamed('/guest_stars', parameters: {
                    'season_number':
                        '${_seasonController.episodeModel.value.seasonNumber}'
                  });
                },
                icon: Icon(
                  Icons.arrow_forward,
                  color: primaryDarkBlue.withOpacity(0.8),
                )),
          ],
        ),
        const SizedBox(height: 12),
        Obx(
          () => _seasonController.episodeModel.value.guestStars!.isEmpty
              ? Text(
                  'No Guest Stars to show at the Moment',
                  style: TextStyle(color: primaryDarkBlue.withOpacity(0.6)),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.from(
                      _seasonController.episodeModel.value.guestStars!.map(
                        (e) => GestureDetector(
                          onTap: () {
                            _peopleController.setPersonId(e.id!);
                            Get.toNamed('/people_details');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 94,
                                height: 190,
                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: e.profilePath == null
                                          ? Container(
                                              alignment: Alignment.center,
                                              width: 94,
                                              height: 130,
                                              color: Colors.black12,
                                              child: const Icon(
                                                Icons.error_outline,
                                                color: primaryWhite,
                                                size: 34,
                                              ),
                                            )
                                          : CachedNetworkImage(
                                              width: 94,
                                              height: 130,
                                              fit: BoxFit.fill,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
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
                                                  '${_configurationController.posterUrl}${e.profilePath}',
                                              placeholder: (context, url) =>
                                                  Container(
                                                color: Colors.black12,
                                              ),
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        e.name ?? 'name',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: n - 2,
                                          color:
                                              primaryDarkBlue.withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
