import 'package:get/get.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';

class InitBindings extends Bindings {
  InitBindings() {
    dependencies();
  }
  @override
  void dependencies() {
    Get.put(ConfigurationController());
    Get.put(UtilityController());
    Get.put(ResultsController());
    Get.put(TrendingResultsController());
    Get.put(DetailsController());
  }
}
