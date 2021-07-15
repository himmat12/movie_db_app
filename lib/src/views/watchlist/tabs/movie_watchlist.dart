import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/account_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/views/details/movie_deatils/tabs/movie%20_list/movie_list.dart';

class MovieWatchlist extends StatelessWidget {
  MovieWatchlist({Key? key}) : super(key: key);

  final _accountController = Get.find<AccountController>();

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
          onLoadingBuilder: Center(child: LoadingSpinner().fadingCircleSpinner),
          onErrorBuilder: const Center(
            child: Text('error while loading data ...'),
          ),
          onSuccessBuilder: Column(
            children: [
              MovieList(movies: _accountController.movieWatchlist),
            ],
          ),
        ),
      ),
    );
  }
}
