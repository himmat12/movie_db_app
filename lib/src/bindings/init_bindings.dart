import 'package:get/get.dart';

import '../controllers/account_controller.dart';
import '../controllers/auth_v3_controller.dart';
import '../controllers/configuration_controller.dart';
import '../controllers/details_controller.dart';
import '../controllers/download_controller.dart';
import '../controllers/list_controller.dart';
import '../controllers/people_controller.dart';
import '../controllers/results_controller.dart';
import '../controllers/search_controller.dart';
import '../controllers/season_controller.dart';
import '../controllers/trending_results_controller.dart';
import '../controllers/utility_controller.dart';

class InitBindings extends Bindings {
  InitBindings() {
    dependencies();
  }
  @override
  void dependencies() {
    Get.lazyPut(() => ConfigurationController(), fenix: true);
    Get.lazyPut(() => UtilityController(), fenix: true);
    Get.lazyPut(() => ResultsController(), fenix: true);
    Get.lazyPut(() => TrendingResultsController(), fenix: true);
    Get.lazyPut(() => DetailsController(), fenix: true);
    Get.lazyPut(() => PeopleController(), fenix: true);
    Get.lazyPut(() => SeasonController(), fenix: true);
    Get.lazyPut(() => AuthV3Controller(), fenix: true);
    Get.lazyPut(() => AccountController(), fenix: true);
    Get.lazyPut(() => ListController(), fenix: true);
    Get.lazyPut(() => DownloadController(), fenix: true);
    Get.lazyPut(() => AccountController(), fenix: true);
    Get.put(SearchController(), permanent: true);
  }
}
