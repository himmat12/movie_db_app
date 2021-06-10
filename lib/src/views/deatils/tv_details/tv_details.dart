import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/loading_spinner_mixin.dart';
import 'package:movie_app/src/models/results/tv_result_model.dart';
import 'package:movie_app/src/views/deatils/components/bottom_tabbar.dart';
import 'package:movie_app/src/views/deatils/components/sliver_appbar_back_btn.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/movie%20_list/recommended_list.dart';
import 'package:movie_app/src/views/deatils/tv_details/tabs/cast/cast_tab.dart';
import 'package:movie_app/src/views/deatils/tv_details/tabs/reviews/reviews_tab.dart';
import 'package:movie_app/src/views/deatils/tv_details/tabs/tv_list/similar_list.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'components/tv_flexible_spacebar.dart';
import '../components/sliver_appbar_title.dart';
import 'components/tv_flexible_spacebar.dart';
import 'components/tv_flexible_spacebar_options.dart';
import 'tabs/about/tv_about_tab.dart';
import 'tabs/tv_list/recommended_list.dart';

class TvDetails extends StatelessWidget {
  // final TvResultsModel tv;

  final _detailsController = Get.find<DetailsController>();
  final _utilityController = Get.find<UtilityController>();
  final _resultssController = Get.find<ResultsController>();

  TvDetails({
    Key? key,
    // required this.tv,
  }) : super(key: key);

  final scrollController = ScrollController();

  get primaryDark => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: GetBuilder(
            id: "tv_details",
            init: _detailsController,
            initState: (_) {
              _detailsController.getDetails(
                  resultType: TV_STRING, id: _resultssController.tv.id!);
              _utilityController.resetImgSliderIndex();
              _utilityController.resetTabbarState();
              _utilityController.resetHideShowState();
            },
            builder: (_) {
              return WidgetBuilderHelper(
                state: _detailsController.tvDetailState.value,
                onLoadingBuilder:
                    Center(child: LoadingSpinner.horizontalLoading),
                onErrorBuilder: const Center(
                  child: Text('error while initializing data...'),
                ),
                onSuccessBuilder: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      elevation: 0.5,
                      forceElevated: true,
                      leading: const SABTN(),
                      title: SABT(
                          child: Text(
                        _resultssController.tv.name ?? 'Title',
                        style: TextStyle(
                          color: primaryDark,
                        ),
                      )),
                      expandedHeight: _utilityController.titlevisiblity == false
                          ? 446
                          : 440,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Column(
                          children: [
                            // slider img/poster/title

                            GetBuilder(
                              init: _detailsController,
                              initState: (_) {
                                // _resultssController.setMovie(movie);
                                _detailsController.getOtherDetails(
                                    resultType: TV_STRING,
                                    id: _resultssController.tv.id!,
                                    appendTo: IMAGES_STRING);
                              },
                              builder: (controller) => WidgetBuilderHelper(
                                state: _detailsController.imagesState.value,
                                onLoadingBuilder:
                                    LoadingSpinner.fadingCircleSpinner,
                                onErrorBuilder: const Center(
                                  child: Text('error while loading data ...'),
                                ),
                                onSuccessBuilder: tvFlexibleSpacebarComponent(
                                  tv: _resultssController.tv,
                                  height: 200,
                                ),
                              ),
                            ),

                            // ),
                            const SizedBox(height: 18),

                            // ratings / lists / bookmark options
                            tvFlexibleSpacebarOptions(
                                controller: _detailsController),
                          ],
                        ),
                      ),
                      bottom: bottomTabbarComponent(tabMenuItems: tabMenuItems),
                    ),

                    // body
                    // Obx(
                    //   () =>
                    GetBuilder(
                      id: 'tabs',
                      init: _utilityController,
                      initState: (_) {},
                      builder: (controller) => SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            tvTabs[_utilityController.tabbarCurrentIndex],
                            const SizedBox(height: 120),
                          ],
                        ),
                      ),
                    ),
                    // ),
                  ],
                ),
                // ),
              );
            },
          ),
        ),
      ),
    );
  }
}

var tabMenuItems = <String>[
  "About",
  "Cast",
  "Seasons",
  "Reviews",
  "Recommended",
  "Similar",
];

var tvTabs = <Widget>[
  TvAboutTab(),
  TvCastsTab(),
  TvAboutTab(),
  TvReviewTab(),
  TvRecommendedTab(),
  TvSimilarTab(),
];
