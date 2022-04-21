import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../controllers/details_controller.dart';
import '../../../controllers/season_controller.dart';
import '../../../controllers/utility_controller.dart';
import '../../../global/loading_spinner.dart';
import '../../../helpers/widget_builder_helper.dart';
import '../components/sliver_appbar_back_btn.dart';
import '../components/sliver_appbar_title.dart';
import 'components/season_bottom_tabbar.dart';
import 'components/season_flexible_spacebar.dart';
import 'tabs/about/season_about_tab.dart';
import 'tabs/cast/season_cast.dart';
import 'tabs/episodes/episodes_tab.dart';

class SeasonDetails extends StatelessWidget {
  // final TvResultsModel tv;

  final _detailsController = Get.find<DetailsController>();
  final _utilityController = Get.find<UtilityController>();
  final _seasonController = Get.find<SeasonController>();

  SeasonDetails({
    Key? key,
    // required this.tv,
  }) : super(key: key);

  final scrollController = ScrollController();

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
          child: GetBuilder(
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
                    Center(child: LoadingSpinner().horizontalLoading),
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
                      backgroundColor: primaryWhite,
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
                            style: const TextStyle(
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
                            SeasonFlexibleSpacebarComponent(
                              season: _seasonController.seasonModel.value,
                              height: 200,
                            ),
                          ],
                        ),
                      ),
                      bottom: seasonBottomTabbarComponent(
                          tabMenuItems: tabMenuItems),
                    ),

                    // body
                    GetBuilder(
                      id: 'seasonTabs',
                      init: _utilityController,
                      initState: (_) {},
                      builder: (controller) => SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            tvTabs[_utilityController.seasonTabbarCurrentIndex],
                            const SizedBox(height: 120),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
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
