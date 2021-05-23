import 'package:get/get.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';

class InitBindings extends Bindings {
  InitBindings() {
    dependencies();
  }
  @override
  void dependencies() {
    Get.put(UtilityController());
  }
}
