import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:get/get.dart';

enum SwitchBtnState { option1, option2 } //switch btn state

class UtilityController extends BaseController {
// bottom navigation state
  var _navCurrentIndex = 0.obs;

  int get navCurrentIndex => _navCurrentIndex.value;

  setBottomNavIndex(int newIndex) {
    _navCurrentIndex.value = newIndex;
  }

  // switch btn state
  var _switchBtnState = SwitchBtnState.option1.obs;

  SwitchBtnState get switchBtnState => _switchBtnState.value;

  toggleSwitchBtnState(SwitchBtnState newSatate) {
    _switchBtnState.value = newSatate;
  }
}
