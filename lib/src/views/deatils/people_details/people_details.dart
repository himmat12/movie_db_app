// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:movie_app/src/configs/strings.dart';
// import 'package:movie_app/src/controllers/person_controller.dart';

// class PeopleDetails extends StatelessWidget {
//   PeopleDetails({Key? key}) : super(key: key);

// final _peopleController = Get.find<PeopleController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 90),
//             TextButton(
//               onPressed: () {
// _peopleController.getPeopleDetails(personId: 54693);
// _peopleController.getCreditsDetails(
//     personId: 54693, resultType: movieCreditsString);
// _peopleController.getCreditsDetails(
//     personId: 54693, resultType: tvCreditsString);
// _peopleController.getCreditsDetails(
//     personId: 54693, resultType: externalIdsString);
// _peopleController.getCreditsDetails(
//     personId: 54693, resultType: imagesString);
//               },
//               child: const Text('get people details'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/people_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/loading_spinner_mixin.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';
import 'package:movie_app/src/views/deatils/components/bottom_tabbar.dart';
import 'package:movie_app/src/views/deatils/components/sliver_appbar_title.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/components/movie_flexible_spacebar.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/components/movie_flexible_spacebar_options.dart';
import 'package:movie_app/src/views/deatils/components/sliver_appbar_back_btn.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/about/movie_about_tab.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/casts/casts_tab.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/movie%20_list/recommended_list.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/reviews/reviews_tab.dart';
import 'package:movie_app/src/views/deatils/people_details/tabs/movie/movie_tab.dart';

import 'components/people_flexible_spacebar.dart';
import 'components/people_flexible_spacebar_option.dart';
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
        // Get.offAllNamed('/');
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
              // _peopleController.getCreditsDetails(
              //     personId: 54693, resultType: tvCreditsString);
              // _peopleController.getCreditsDetails(
              //     personId: 54693, resultType: externalIdsString);
              // _peopleController.getCreditsDetails(
              //     personId: 54693, resultType: imagesString);

              _utilityController.resetImgSliderIndex();
              _utilityController.resetTabbarState();
              _utilityController.resetHideShowState();
              // ignore: avoid_print
              // print("initialized ...");
            },
            builder: (_) {
              return
                  // Obx(
                  //   () =>
                  WidgetBuilderHelper(
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
                      leading: const SABTN(),
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
                            // peopleFlexibleSpacebarOptions(
                            //     people: _peopleController.people.value),
                          ],
                        ),
                      ),
                      bottom: bottomTabbarComponent(tabMenuItems: tabMenuItems),
                    ),

                    // body
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
                  ],
                ),
              )
                  //   ,
                  // )
                  ;
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
  MovieReviewTab(),
];
