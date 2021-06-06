import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/mixins/avatar.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';
import 'package:movie_app/src/views/deatils/components/hide_show_btn.dart';

class MovieList extends StatelessWidget with AvatarBuilderMixin {
  final _detailsController = Get.find<DetailsController>();
  final _configurationController = Get.find<ConfigurationController>();

  final _utilityController = Get.find<UtilityController>();

  MovieList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Text(
            '${_detailsController.movieDetail.value.reviews!.results!.length} Reviews',
            style: TextStyle(
              color: primaryDarkBlue.withOpacity(0.7),
              fontSize: n,
            ),
          ),
        ),
      ],
    );
  }
}
