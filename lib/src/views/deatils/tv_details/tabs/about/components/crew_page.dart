import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/avatar.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';

class TvCrewPage extends StatelessWidget with AvatarBuilderMixin {
  final _detailsController = Get.find<DetailsController>();
  final _resultController = Get.find<ResultsController>();
  final _configurationController = Get.find<ConfigurationController>();

  TvCrewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Text(_detailsController.tvDetail.value.name ?? "tv title"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder(
                id: 'tv_crews',
                init: _detailsController,
                initState: (_) {
                  _detailsController.getOtherDetails(
                      resultType: TV_STRING,
                      id: _resultController.tv.id!,
                      appendTo: CREDITS_STRING);
                },
                builder: (controller) => WidgetBuilderHelper(
                  state: _detailsController.creditsState.value,
                  onLoadingBuilder: LoadingSpinner.fadingCircleSpinner,
                  onErrorBuilder: const Center(
                    child: Text('error while loading data ...'),
                  ),
                  onSuccessBuilder: _detailsController.credits.value.crew ==
                              null ||
                          _detailsController.credits.value.crew!.isEmpty
                      ? Center(
                          child: Text(
                            'No Crews To Feature at the Moment',
                            style: TextStyle(
                                color: primaryDarkBlue.withOpacity(0.6)),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 18),
                              child: Text(
                                '${_detailsController.credits.value.crew == null ? 0 : _detailsController.credits.value.crew!.length} Persons',
                                style: TextStyle(
                                  color: primaryDarkBlue.withOpacity(0.7),
                                  fontSize: n,
                                ),
                              ),
                            ),
                            ListView.separated(
                              itemCount:
                                  _detailsController.credits.value.crew == null
                                      ? 0
                                      : _detailsController
                                          .credits.value.crew!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                Crew crew = _detailsController
                                    .credits.value.crew![index];

                                return InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: crew.profilePath == null
                                              ? avatarBuilder()
                                              : CachedNetworkImage(
                                                  height: 68,
                                                  width: 68,
                                                  imageUrl:
                                                      '${_configurationController.posterUrl}${crew.profilePath}',
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                          color:
                                                              Colors.black26),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                crew.name ?? "name",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: m - 4,
                                                  color: primaryDarkBlue
                                                      .withOpacity(0.7),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                crew.job ?? "job",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: n - 2,
                                                  color: primaryDarkBlue
                                                      .withOpacity(0.6),
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
                ),
              ),
            ],
          ),
        ));
  }
}
