import 'package:get/get.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/people_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/season_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';

import 'src/controllers/auth_v3_controller.dart';

class InitBindings extends Bindings {
  InitBindings() {
    dependencies();
  }
  @override
  void dependencies() {
    Get.lazyPut(() => ConfigurationController());
    Get.lazyPut(() => UtilityController());
    Get.lazyPut(() => ResultsController());
    Get.lazyPut(() => TrendingResultsController());
    Get.lazyPut(() => DetailsController());
    Get.lazyPut(() => PeopleController());
    Get.lazyPut(() => SeasonController());
    Get.lazyPut(() => AuthV3Controller());
  }
}
