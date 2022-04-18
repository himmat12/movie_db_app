import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/strings.dart';
import '../../../controllers/account_controller.dart';
import '../../../controllers/configuration_controller.dart';
import '../../../global/loading_spinner.dart';
import '../../../global/movie_thumbnail_card.dart';
import '../../../helpers/widget_builder_helper.dart';

class MovieWatchlist extends StatelessWidget {
  MovieWatchlist({Key? key}) : super(key: key);

  final _accountController = Get.find<AccountController>();
  final _configurationController = Get.find<ConfigurationController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'movie_watchlist',
      init: _accountController,
      initState: (_) {
        _accountController.getWatchlist(mediaType: moviesString);
        print('initialized');
      },
      builder: (controller) => Obx(
        () => WidgetBuilderHelper(
            state: _accountController.watchlistState.value,
            onLoadingBuilder:
                Center(child: LoadingSpinner().fadingCircleSpinner),
            onErrorBuilder: const Center(
              child: Text('error while loading data ...'),
            ),
            onSuccessBuilder: Column(
              children: [
                const SizedBox(height: 28),
                GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _accountController.movieWatchlist.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 186,
                  ),
                  itemBuilder: (context, index) => AbsorbPointer(
                    absorbing:
                        _accountController.movieWatchlist[index].posterPath ==
                                null
                            ? true
                            : false,
                    child: movieThumbnailCard(
                      // onLongPress: () {
                      //   _resultController.setMovieId(
                      //       '${_accountController.movieWatchlist[index].id}');
                      //   Get.bottomSheet(BottomScrollableSheet(
                      //       movie: _accountController.movieWatchlist[index]));
                      // },
                      padding: const EdgeInsets.all(0),
                      movie: _accountController.movieWatchlist[index],
                      imageUrl:
                          '${_configurationController.posterUrl}${_accountController.movieWatchlist[index].posterPath}',
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
