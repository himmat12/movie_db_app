import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/mixins/loading_spinner_mixin.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';

import 'components/movie_flexible_spacebar.dart';
import 'components/sliver_appbar_title.dart';

class MoviesDetails extends StatelessWidget with LoadingSpinnerMixin {
  final MovieResultModel movie;

  final _detailsController = Get.find<DetailsController>();
  final _utilityController = Get.find<UtilityController>();

  MoviesDetails({Key? key, required this.movie}) : super(key: key);

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: GetBuilder(
            init: _detailsController,
            initState: (_) {
              _detailsController.getDetails(
                  resultType: MOVIE_STRING, id: movie.id!);
              _utilityController.resetImgSliderIndex();
            },
            builder: (_) {
              return Obx(
                () => WidgetBuilderHelper(
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
                        elevation: 0,
                        title: const SABT(
                            child: Text(
                          'Title',
                          style: TextStyle(
                            color: primaryDark,
                          ),
                        )),
                        expandedHeight: 400,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(
                            children: [
                              Obx(
                                () => movieFlexibleSpacebarComponent(
                                  movie: movie,
                                  images: _detailsController
                                      .movieDetail.value.images,
                                  height: 200,
                                ),
                              ),
                            ],
                          ),
                        ),
                        bottom: PreferredSize(
                          preferredSize: Size(MediaQuery.of(context).size.width,
                              kToolbarHeight),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              height: kToolbarHeight,
                              child: Row(
                                children: List.generate(
                                    6,
                                    (index) => Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 0, 12, 0),
                                          child: Text('Tab Index $index'),
                                        )),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverFixedExtentList(
                          itemExtent: 50.0,
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text('List item $index'),
                            );
                          }, childCount: 100)),
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
