import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/loading_spinner_mixin.dart';
import 'package:movie_app/src/models/results/tv_result_model.dart';
import 'package:movie_app/src/views/deatils/components/bottom_tabbar.dart';
import 'package:movie_app/src/views/deatils/components/sliver_appbar_back_btn.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'components/tv_flexible_spacebar.dart';
import '../components/sliver_appbar_title.dart';
import 'components/tv_flexible_spacebar.dart';
import 'components/tv_flexible_spacebar_options.dart';
import 'tabs/tv_about_tab.dart';

class TvDetails extends StatelessWidget {
  final TvResultsModel tv;

  final _detailsController = Get.find<DetailsController>();
  final _utilityController = Get.find<UtilityController>();

  TvDetails({Key? key, required this.tv}) : super(key: key);

  final scrollController = ScrollController();

  get primaryDark => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: GetBuilder(
            init: _detailsController,
            initState: (_) {
              _detailsController.getDetails(resultType: TV_STRING, id: tv.id!);
              _utilityController.resetImgSliderIndex();
              _utilityController.resetTabbarState();
            },
            builder: (_) {
              return Obx(
                () => WidgetBuilderHelper(
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
                          tv.name ?? 'Title',
                          style: TextStyle(
                            color: primaryDark,
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
                              Obx(
                                () => tvFlexibleSpacebarComponent(
                                  tv: tv,
                                  images:
                                      _detailsController.tvDetail.value.images,
                                  height: 200,
                                ),
                              ),
                              const SizedBox(height: 18),

                              // ratings / lists / bookmark options
                              tvFlexibleSpacebarOptions(
                                  controller: _detailsController),
                            ],
                          ),
                        ),
                        bottom:
                            bottomTabbarComponent(tabMenuItems: tabMenuItems),
                      ),

                      // body
                      Obx(
                        () => SliverList(
                          delegate: SliverChildListDelegate.fixed(
                            [
                              tabs[_utilityController.tabbarCurrentIndex],
                              const SizedBox(height: 400),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
  "About",
  "Cast",
  "Seasons",
  "Comments",
  "Reviews",
  "Recommended",
  "Similar",
];

var tabs = <Widget>[
  const TvAboutTab(index: 0),
  const TvAboutTab(index: 1),
  const TvAboutTab(index: 2),
  const TvAboutTab(index: 3),
  const TvAboutTab(index: 4),
  const TvAboutTab(index: 5),
  const TvAboutTab(index: 6),
];
