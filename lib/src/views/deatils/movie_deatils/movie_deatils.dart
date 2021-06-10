import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/loading_spinner_mixin.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';
import 'package:movie_app/src/views/deatils/components/bottom_tabbar.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/components/movie_flexible_spacebar_options.dart';
import 'package:movie_app/src/views/deatils/components/sliver_appbar_back_btn.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/about/movie_about_tab.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/casts/casts_tab.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/movie%20_list/recommended_list.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/reviews/reviews_tab.dart';

import 'components/movie_flexible_spacebar.dart';
import '../components/sliver_appbar_title.dart';
import 'tabs/movie _list/movie_list.dart';

class MoviesDetails extends StatelessWidget with LoadingSpinnerMixin {
  // final MovieResultModel movie;

  final _detailsController = Get.find<DetailsController>();
  final _resultssController = Get.find<ResultsController>();
  final _utilityController = Get.find<UtilityController>();

  MoviesDetails({
    Key? key,
    // required this.movie,
  }) : super(key: key);

  final scrollController = ScrollController();

  final _resultsController = Get.find<ResultsController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _detailsController.getDetails(
          resultType: MOVIE_STRING, id: _resultsController.movie.id!),
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            body: GetBuilder(
              id: 'movie_details',
              init: _detailsController,
              initState: (_) {
                _detailsController.getDetails(
                    resultType: MOVIE_STRING, id: _resultsController.movie.id!);
                _utilityController.resetImgSliderIndex();
                _utilityController.resetTabbarState();
                _utilityController.resetHideShowState();
                // ignore: avoid_print
                print("initialized ...");
              },
              builder: (_) {
                return WidgetBuilderHelper(
                  state: _detailsController.movieDetailState.value,
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
                          _resultsController.movie.title ?? 'Title',
                          style: TextStyle(
                            color: primaryDarkBlue.withOpacity(0.9),
                          ),
                        )),
                        expandedHeight:
                            _utilityController.titlevisiblity == false
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
                                      resultType: MOVIE_STRING,
                                      id: _resultsController.movie.id!,
                                      appendTo: IMAGES_STRING);
                                },
                                builder: (controller) => WidgetBuilderHelper(
                                  state: _detailsController.imagesState.value,
                                  onLoadingBuilder:
                                      LoadingSpinner.fadingCircleSpinner,
                                  onErrorBuilder: const Center(
                                    child: Text('error while loading data ...'),
                                  ),
                                  onSuccessBuilder:
                                      movieFlexibleSpacebarComponent(
                                    movie: _resultsController.movie,
                                    height: 200,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 18),

                              // ratings / lists / bookmark options
                              movieFlexibleSpacebarOptions(),
                            ],
                          ),
                        ),
                        bottom:
                            bottomTabbarComponent(tabMenuItems: tabMenuItems),
                      ),

                      // body

                      // Obx(
                      //   () =>

                      GetBuilder(
                        id: 'tabs',
                        init: _utilityController,
                        builder: (controller) => SliverList(
                          delegate: SliverChildListDelegate.fixed(
                            [
                              movieTabs[_utilityController.tabbarCurrentIndex],
                              const SizedBox(height: 120),
                            ],
                          ),
                        ),
                      ),

                      // ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

var tabMenuItems = <String>[
  "About",
  "Cast",
  "Reviews",
  "Recommended",
  "Similar",
];

var movieTabs = <Widget>[
  MovieAboutTab(),
  MovieCastsTab(),
  MovieReviewTab(),
  RecommendedTab(),
  MovieAboutTab(),
];
