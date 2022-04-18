import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/configs.dart';
import '../../../../configs/strings.dart';
import '../../../../controllers/configuration_controller.dart';
import '../../../../controllers/people_controller.dart';
import '../../../../controllers/utility_controller.dart';
import '../../../../global/external_id_btn.dart';
import '../../../../global/loading_spinner.dart';
import '../../../../helpers/widget_builder_helper.dart';
import '../../../../models/peoples/people_model.dart';

Widget peopleFlexibleSpacebarComponent({
  required PeopleModel people,
  double? height,
}) {
  final _utilityController = Get.find<UtilityController>();
  final _configController = Get.find<ConfigurationController>();
  final _peopleController = Get.find<PeopleController>();

  return SizedBox(
    height: 200,
    child: Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        // poster and title people details
        Positioned(
          bottom: 0.0,
          left: 0,
          right: 0,
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    // poster
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: people.profilePath == null
                          ? Container(
                              alignment: Alignment.center,
                              width: 104,
                              height: 104,
                              color: Colors.black12,
                              child: const Icon(
                                Icons.error_outline,
                                color: primaryWhite,
                                size: 34,
                              ),
                            )
                          : CachedNetworkImage(
                              width: 104,
                              height: 104,
                              fit: BoxFit.cover,
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
                                  '${_configController.profileUrl}${people.profilePath}',
                              placeholder: (context, url) => Container(
                                color: Colors.black12,
                              ),
                            ),
                    ),
                    const SizedBox(width: 16),
                    //  titles
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Text(
                            people.name ?? 'name',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: m,
                              fontWeight: FontWeight.bold,
                              color: primaryDarkBlue,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _peopleController.people.value.knownForDepartment ??
                                'department',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: n - 2,
                              fontWeight: FontWeight.bold,
                              color: primaryDarkBlue.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 8),

                          ///external ids
                          GetBuilder(
                            id: 'external_id',
                            init: _peopleController,
                            initState: (_) {
                              _peopleController.getCreditsDetails(
                                  personId: _peopleController.personId,
                                  resultType: externalIdsString);
                            },
                            builder: (controller) => WidgetBuilderHelper(
                              state: _peopleController.externalIdsState.value,
                              onLoadingBuilder: Row(
                                children: [
                                  LoadingSpinner().horizontalLoading,
                                ],
                              ),
                              onErrorBuilder: const Center(
                                  child: Text(
                                      'error occured while loading data ...')),
                              onSuccessBuilder: Row(
                                children: [
                                  _peopleController.externalIds.value.imdbId ==
                                              null ||
                                          _peopleController
                                                  .externalIds.value.imdbId ==
                                              ""
                                      ? const SizedBox.shrink()
                                      : GestureDetector(
                                          onTap: () {
                                            _utilityController.loadUrl(
                                                url:
                                                    '$imdbString/${_peopleController.externalIds.value.imdbId}');
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.amber.shade700,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: const Text(
                                              'IMDb',
                                              style: TextStyle(
                                                letterSpacing: 0.2,
                                                color: primaryDark,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                  _peopleController.externalIds.value.imdbId ==
                                              null ||
                                          _peopleController
                                                  .externalIds.value.imdbId ==
                                              ""
                                      ? const SizedBox.shrink()
                                      : const SizedBox(width: 18),
                                  _peopleController.externalIds.value
                                                  .facebookId ==
                                              null ||
                                          _peopleController.externalIds.value
                                                  .facebookId ==
                                              ""
                                      ? const SizedBox.shrink()
                                      : externalIdBtn(
                                          targetUrl:
                                              '$facebookString/${_peopleController.externalIds.value.facebookId}',
                                          asset: 'facebook.svg',
                                        ),
                                  _peopleController.externalIds.value
                                                  .facebookId ==
                                              null ||
                                          _peopleController.externalIds.value
                                                  .facebookId ==
                                              ""
                                      ? const SizedBox.shrink()
                                      : const SizedBox(width: 18),
                                  _peopleController.externalIds.value
                                                  .twitterId ==
                                              null ||
                                          _peopleController.externalIds.value
                                                  .twitterId ==
                                              ""
                                      ? const SizedBox.shrink()
                                      : externalIdBtn(
                                          targetUrl:
                                              '$twitterString/${_peopleController.externalIds.value.twitterId}',
                                          asset: 'twitter.svg',
                                        ),
                                  _peopleController.externalIds.value
                                                  .twitterId ==
                                              null ||
                                          _peopleController.externalIds.value
                                                  .twitterId ==
                                              ""
                                      ? const SizedBox.shrink()
                                      : const SizedBox(width: 18),
                                  _peopleController.externalIds.value
                                                  .instagramId ==
                                              null ||
                                          _peopleController.externalIds.value
                                                  .instagramId ==
                                              ""
                                      ? const SizedBox.shrink()
                                      : externalIdBtn(
                                          targetUrl:
                                              '$instagramString/${_peopleController.externalIds.value.instagramId}',
                                          asset: 'instagram.svg',
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
