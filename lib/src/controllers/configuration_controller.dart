import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/models/configuration_model.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/services/configuration_service.dart';
import 'package:movie_app/src/services/results_service.dart';

class ConfigurationController extends BaseController {
  final _service = sl<ConfigurationService>();
  var configuration = ConfigurationModel().obs;

  getConfigurations() async {
    await _service.getConfiguration().then((value) {
      if (value != null) {
        configuration.value = ConfigurationModel.fromJson(value);
        // ignore: avoid_print
        // print(configuration.value.changeKeys);
      }
    });
  }
}
