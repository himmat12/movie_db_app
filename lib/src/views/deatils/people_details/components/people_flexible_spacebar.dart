import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/people_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';
import 'package:movie_app/src/models/peoples/people_model.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget peopleFlexibleSpacebarComponent({
  required PeopleModel people,
  double? height,
}) {
  final _utilityController = Get.find<UtilityController>();
  final _configController = Get.find<ConfigurationController>();
  final _peopleController = Get.find<PeopleController>();
  // final _peopleController = Get.put(PeopleController());

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
          child: Container(
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
