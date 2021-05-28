import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';

// movie switch
Widget movieSwitchBtnBuilder({
  String? text1,
  String? text2,
  Color? color,
  Color? selectedColor,
  Color? textColor,
  BorderRadiusGeometry? borderRadius,
  EdgeInsetsGeometry? padding,
  BoxBorder? border,
}) {
  final _controller = Get.find<UtilityController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();

  return Obx(
    () => Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        color: color ?? secondaryDarkBlue,
        border: border ??
            const Border(
              bottom: BorderSide.none,
              top: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none,
            ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _controller.toggleMovieSwitch();
              _trendingResultsController.resetMoviePage();

              if (_controller.isMovieToday == true) {
                _trendingResultsController.getTrendingMovieResults(
                    timeWindow: DAY_STRING);
              } else if (_controller.isMovieToday != true) {
                _trendingResultsController.getTrendingMovieResults(
                    timeWindow: WEEK_STRING);
              }
            },
            child: Container(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: secondaryDarkBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _controller.isMovieToday == true ? 'Today' : 'This Week',
                style: TextStyle(
                  color: textColor ?? primaryWhite,
                  fontSize: n - 4,
                ),
              ),
            ),
          ),
          const Icon(
            Icons.import_export,
            size: 16,
            color: primaryWhite,
          ),
        ],
      ),
    ),
  );
}

// tv switch
Widget tvSwitchBtnBuilder({
  String? text1,
  String? text2,
  Color? color,
  Color? selectedColor,
  Color? textColor,
  BorderRadiusGeometry? borderRadius,
  EdgeInsetsGeometry? padding,
  BoxBorder? border,
}) {
  final _controller = Get.find<UtilityController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();

  return Obx(
    () => Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        color: color ?? secondaryDarkBlue,
        border: border ??
            const Border(
              bottom: BorderSide.none,
              top: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none,
            ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _controller.toggleTvSwitch();
              _trendingResultsController.resetTvPage();

              if (_controller.isTvToday == true) {
                _trendingResultsController.getTrendingTvResults(
                    timeWindow: DAY_STRING);
              } else if (_controller.isTvToday != true) {
                _trendingResultsController.getTrendingTvResults(
                    timeWindow: WEEK_STRING);
              }
            },
            child: Container(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: secondaryDarkBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _controller.isTvToday == true ? 'Today' : 'This Week',
                style: TextStyle(
                  color: textColor ?? primaryWhite,
                  fontSize: n - 4,
                ),
              ),
            ),
          ),
          const Icon(
            Icons.import_export,
            size: 16,
            color: primaryWhite,
          ),
        ],
      ),
    ),
  );
}
