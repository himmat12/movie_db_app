import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget movieFlexibleSpacebarComponent({
  required MovieResultModel movie,
  required Images? images,
  double? height,
}) {
  final _utilityController = Get.find<UtilityController>();
  final _configController = Get.find<ConfigurationController>();
  final _detailsController = Get.find<DetailsController>();

  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      WidgetBuilderHelper(
        state: _detailsController.movieDetailState.value,
        onLoadingBuilder: Center(child: LoadingSpinner.horizontalLoading),
        onErrorBuilder: const Center(
          child: Text('error while initializing data...'),
        ),
        onSuccessBuilder: ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.black,
                Colors.black,
                Colors.transparent
              ],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.transparent)),
            ),
            child: SizedBox(
              height: height ?? 190,
              child: PageView.builder(
                onPageChanged: (value) {
                  _utilityController.setSliderIndex(value);
                },
                itemCount: images!.backdrops!.length,
                controller: PageController(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          '${_configController.backDropUrl}${images.backdrops![index].filePath}');
                },
              ),
            ),
          ),
        ),
      ),
      Obx(
        () => AnimatedSmoothIndicator(
          activeIndex: _utilityController.imgSliderIndex,
          effect: const ScrollingDotsEffect(
            activeDotColor: primaryDarkBlue,
            dotColor: primaryblue,
            dotHeight: 6,
            dotWidth: 6,
          ),
          count: images.backdrops!.length,
        ),
      ),
      Container(),
    ],
  );
}
