import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/account_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/helpers/widget_builder_helper.dart';
import 'package:movie_app/src/views/details/tv_details/tabs/tv_list/tv_list.dart';

class TvWatchlist extends StatelessWidget {
  TvWatchlist({Key? key}) : super(key: key);

  final _accountController = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: 'tv_watchlist',
      init: _accountController,
      initState: (_) {
        _accountController.getWatchlist(mediaType: tvString);
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
              TvList(tv: _accountController.tvWatchlist),
            ],
          ),
        ),
      ),
    );
  }
}
