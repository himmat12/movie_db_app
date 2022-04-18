import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/strings.dart';
import '../../../controllers/account_controller.dart';
import '../../../global/loading_spinner.dart';
import '../../../helpers/widget_builder_helper.dart';
import '../../details/tv_details/tabs/tv_list/tv_list.dart';

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
