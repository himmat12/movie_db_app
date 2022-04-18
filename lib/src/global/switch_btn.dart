import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../configs/configs.dart';
import '../configs/strings.dart';
import '../controllers/base_controller.dart';
import '../controllers/trending_results_controller.dart';
import '../controllers/utility_controller.dart';
import 'loading_spinner.dart';

// trending movie switch

Widget trendingMovieSwitchBtnBuilder({
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
          _trendingResultsController.movieViewState == ViewState.busy
              ? Padding(
                  padding: padding ??
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: LoadingSpinner().horizontalLoading,
                )
              : GestureDetector(
                  onTap: () {
                    _controller.toggleTrendingMovieSwitch();
                    _trendingResultsController.resetMoviePage();

                    if (_controller.isMovieToday == true) {
                      _trendingResultsController.getTrendingMovieResults(
                          timeWindow: dayString);
                    } else if (_controller.isMovieToday != true) {
                      _trendingResultsController.getTrendingMovieResults(
                          timeWindow: weekString);
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
                        fontSize: n - 6,
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

// trending tv switch
Widget trendingTvSwitchBtnBuilder({
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
          _trendingResultsController.tvViewState == ViewState.busy
              ? Padding(
                  padding: padding ??
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: LoadingSpinner().horizontalLoading,
                )
              : GestureDetector(
                  onTap: () {
                    _controller.toggleTrendingTvSwitch();
                    _trendingResultsController.resetTvPage();

                    if (_controller.isTvToday == true) {
                      _trendingResultsController.getTrendingTvResults(
                          timeWindow: dayString);
                    } else if (_controller.isTvToday != true) {
                      _trendingResultsController.getTrendingTvResults(
                          timeWindow: weekString);
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
                        fontSize: n - 6,
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
