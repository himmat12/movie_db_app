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
import '../season_details/tabs/about/season_about_tab.dart';
import '../season_details/tabs/cast/season_cast.dart';
import '../season_details/tabs/episodes/episodes_tab.dart';
import 'components/episode_flexible_spacebar.dart';
import 'episode_details_info/episode_details_info.dart';

class EpisodeDetails extends StatelessWidget {
  // final TvResultsModel tv;

  final _detailsController = Get.find<DetailsController>();
  final _utilityController = Get.find<UtilityController>();
  final _seasonController = Get.find<SeasonController>();

  EpisodeDetails({
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
            id: "episode_details",
            init: _seasonController,
            initState: (_) {
              _seasonController.getEpisodeDetails(
                tvId: '${_seasonController.tvId}',
                seasonNo: '${_seasonController.seasonNo}',
                episodeNo: '${_seasonController.episodeNo}',
              );

              _utilityController.resetImgSliderIndex();
              _utilityController.resetEpisodeTabbarState();
              _utilityController.resetHideShowState();
            },
            builder: (_) {
              return WidgetBuilderHelper(
                state: _seasonController.episodeState,
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
                            _seasonController.episodeModel.value.name ??
                                'episode name',
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
                      expandedHeight: 370,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Column(
                          children: [
                            // slider img/poster/title
                            episodeFlexibleSpacebarComponent(
                              episode: _seasonController.episodeModel.value,
                              height: 200,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // body
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            EpisodeDetailsInfo(),
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
