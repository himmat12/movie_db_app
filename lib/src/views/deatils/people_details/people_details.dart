import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/people_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/loading_spinner_mixin.dart';
import 'package:movie_app/src/views/deatils/components/sliver_appbar_title.dart';
import 'package:movie_app/src/views/deatils/components/sliver_appbar_back_btn.dart';
import 'package:movie_app/src/views/deatils/people_details/tabs/movie/movie_tab.dart';
import 'package:movie_app/src/views/deatils/people_details/tabs/tv/tv_tab.dart';

import 'components/people_bottom_tabbar.dart';
import 'components/people_flexible_spacebar.dart';
import 'tabs/about/people_about_tab.dart';

class PeopleDetails extends StatefulWidget with LoadingSpinnerMixin {
  PeopleDetails({Key? key}) : super(key: key);

  @override
  State<PeopleDetails> createState() => _MoviesDetailsState();
}

class _MoviesDetailsState extends State<PeopleDetails> {
  final _detailsController = Get.find<DetailsController>();

  final _resultssController = Get.find<ResultsController>();

  final _utilityController = Get.find<UtilityController>();

  final scrollController = ScrollController();

  final _resultsController = Get.find<ResultsController>();
  final _peopleController = Get.find<PeopleController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder(
            id: 'people_details',
            init: _peopleController,
            initState: (_) {
              _peopleController.getPeopleDetails(
                  personId: _peopleController.personId);

              _utilityController.resetImgSliderIndex();
              _utilityController.resetPeopleTabbarState();
              _utilityController.resetHideShowState();
              // ignore: avoid_print
              // print("initialized ...");
            },
            builder: (_) {
              return WidgetBuilderHelper(
                state: _peopleController.peopleState.value,
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
                      leading: SABTN(
                        onBack: () {
                          Get.back();
                        },
                      ),
                      title: SABT(
                          child: Text(
                        _peopleController.people.value.name ?? 'name',
                        style: TextStyle(
                          color: primaryDarkBlue.withOpacity(0.9),
                        ),
                      )),
                      expandedHeight: 270,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Column(
                          children: [
                            peopleFlexibleSpacebarComponent(
                              people: _peopleController.people.value,
                              height: 180,
                            ),

                            const SizedBox(height: 18),

                            // ratings / lists / bookmark options
                          ],
                        ),
                      ),
                      bottom: peopleBottomTabbarComponent(
                          tabMenuItems: tabMenuItems),
                    ),

                    // body
                    GetBuilder(
                      id: 'peopleTabs',
                      init: _utilityController,
                      builder: (controller) => SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            movieTabs[
                                _utilityController.peopleTabbarCurrentIndex],
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
  "About",
  "Movies",
  "TV Shows",
];

var movieTabs = <Widget>[
  PeopleAboutTab(),
  PeopleMovieTab(),
  PeopleTvTab(),
];
