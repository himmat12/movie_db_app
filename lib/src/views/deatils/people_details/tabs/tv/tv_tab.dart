import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/people_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/avatar.dart';

import 'components/tv_credits_thumbnail.dart';

class PeopleTvTab extends StatelessWidget with AvatarBuilderMixin {
  // final List<MovieResultModel> movies;

  final _configurationController = Get.find<ConfigurationController>();

  final _peopleController = Get.find<PeopleController>();

  PeopleTvTab({
    Key? key,
    // required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'people_tv',
      init: _peopleController,
      initState: (_) {
        _peopleController.getCreditsDetails(
            personId: _peopleController.personId, resultType: tvCreditsString);
      },
      builder: (controller) {
        return WidgetBuilderHelper(
          state: _peopleController.tvCreditsState.value,
          onLoadingBuilder: LoadingSpinner.fadingCircleSpinner,
          onErrorBuilder: const Center(
            child: Text('error while loading data ...'),
          ),
          onSuccessBuilder: _peopleController.tvCredits.value.cast == null ||
                  _peopleController.tvCredits.value.cast!.isEmpty
              ? SizedBox(
                  height: 80,
                  child: Center(
                    child: Text(
                      'No Movies Credits at the Moment',
                      style: TextStyle(color: primaryDarkBlue.withOpacity(0.6)),
                    ),
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: 28),
                    GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _peopleController.tvCredits.value.cast!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        mainAxisExtent: 186,
                      ),
                      itemBuilder: (context, index) => tvCreditsThumbnailCard(
                        padding: const EdgeInsets.all(0),
                        tv: _peopleController.tvCredits.value.cast![index],
                        imageUrl:
                            '${_configurationController.posterUrl}${_peopleController.tvCredits.value.cast![index].posterPath}',
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
