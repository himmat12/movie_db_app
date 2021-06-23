import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/season_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/views/deatils/components/sliver_appbar_back_btn.dart';
import 'package:movie_app/src/views/deatils/season_details/tabs/about/season_about_tab.dart';
import 'package:movie_app/src/views/deatils/season_details/tabs/cast/season_cast.dart';
import 'package:movie_app/src/views/deatils/season_details/tabs/episodes/episodes_tab.dart';

import '../components/sliver_appbar_title.dart';
import 'components/season_bottom_tabbar.dart';
import 'components/season_flexible_spacebar.dart';

class SeasonDetails extends StatelessWidget {
  // final TvResultsModel tv;

  final _detailsController = Get.find<DetailsController>();
  final _utilityController = Get.find<UtilityController>();
  final _resultssController = Get.find<ResultsController>();
  final _seasonController = Get.find<SeasonController>();

  SeasonDetails({
    Key? key,
    // required this.tv,
  }) : super(key: key);

  final scrollController = ScrollController();

  get primaryDark => null;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Get.offAllNamed('/');
        Get.back();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Scaffold(
            body: GetBuilder(
              id: "season_details",
              init: _seasonController,
              initState: (_) {
                _seasonController.getSeasonDetails(
                    tvId: '${_seasonController.tvId}',
                    seasonNo: '${_seasonController.seasonNo}');

                _utilityController.resetImgSliderIndex();
                _utilityController.resetSeasonTabbarState();
                _utilityController.resetHideShowState();
              },
              builder: (_) {
                return WidgetBuilderHelper(
                  state: _seasonController.seasonState,
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
                        leading: const SABTN(
                            // onBack: () {
                            // Get.offAllNamed('/');
                            // },
                            ),
                        title: SABT(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _seasonController.seasonModel.value.name ??
                                  'season name',
                              style: TextStyle(
                                color: primaryDark,
                              ),
                            ),
                            Text(
                              _detailsController.tvDetail.value.name ?? 'name',
                              style: TextStyle(
                                fontSize: n,
                                color: primaryDarkBlue.withOpacity(0.8),
                              ),
                            ),
                          ],
                        )),
                        expandedHeight: 390,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Column(
                            children: [
                              // slider img/poster/title
                              seasonFlexibleSpacebarComponent(
                                season: _seasonController.seasonModel.value,
                                height: 200,
                              ),

                              // ),
                              // const SizedBox(height: 18),

                              // overview
                              // seasonFlexibleSpacebarOptions(),
                            ],
                          ),
                        ),
                        bottom: seasonBottomTabbarComponent(
                            tabMenuItems: tabMenuItems),
                      ),

                      // body
                      // Obx(
                      //   () =>
                      GetBuilder(
                        id: 'seasonTabs',
                        init: _utilityController,
                        initState: (_) {},
                        builder: (controller) => SliverList(
                          delegate: SliverChildListDelegate.fixed(
                            [
                              tvTabs[
                                  _utilityController.seasonTabbarCurrentIndex],
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
      ),
    );
  }
}

var tabMenuItems = <String>[
  "Episodes",
  "Overview",
  "Cast",
];

var tvTabs = <Widget>[
  EpisodesTab(),
  SeasonAboutTab(),
  SeasonCastsTab(),
];
