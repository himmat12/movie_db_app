import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/details_controller.dart';
import 'package:movie_app/src/controllers/season_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/views/details/components/sliver_appbar_back_btn.dart';
import 'package:movie_app/src/views/details/components/sliver_appbar_title.dart';
import 'package:movie_app/src/views/details/episode_details/components/episode_flexible_spacebar.dart';
import 'package:movie_app/src/views/details/episode_details/episode_details_info/episode_details_info.dart';
import 'package:movie_app/src/views/details/season_details/tabs/about/season_about_tab.dart';
import 'package:movie_app/src/views/details/season_details/tabs/cast/season_cast.dart';
import 'package:movie_app/src/views/details/season_details/tabs/episodes/episodes_tab.dart';

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
