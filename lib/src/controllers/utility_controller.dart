import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:get/get.dart';

class UtilityController extends BaseController {
// bottom navigation state
  var _navCurrentIndex = 0.obs;

  int get navCurrentIndex => _navCurrentIndex.value;

  setBottomNavIndex(int newIndex) {
    _navCurrentIndex.value = newIndex;
  }
}
