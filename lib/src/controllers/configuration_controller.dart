import 'package:get/get.dart';

import '../../service_locator.dart';
import '../models/configurations/api_configuration_model.dart';
import '../services/configuration_service.dart';
import 'base_controller.dart';

class ConfigurationController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    getConfigurations();
  }

  final _service = sl<ConfigurationService>();
  var configuration = ApiConfigurationModel(
      changeKeys: [],
      images: Images(
        baseUrl: "",
        secureBaseUrl: "",
        backdropSizes: [],
        logoSizes: [],
        posterSizes: [],
        profileSizes: [],
        stillSizes: [],
      )).obs;

  var configState = ViewState.idle.obs;

  String _posterUrl = "";
  String _backDropUrl = "";
  String _profileUrl = "";
  String _logoUrl = "";
  String _stillUrl = "";

  String get posterUrl => _posterUrl;
  String get backDropUrl => _backDropUrl;
  String get profileUrl => _profileUrl;
  String get logoUrl => _logoUrl;
  String get stillUrl => _stillUrl;

  void getConfigurations() async {
    configState.value = ViewState.busy;
    await _service.getConfiguration().then((value) {
      // if (value != null) {
      configuration.value = ApiConfigurationModel.fromJson(value);
      _posterUrl =
          '${configuration.value.images.secureBaseUrl}${configuration.value.images.posterSizes[3]}';
      _backDropUrl =
          '${configuration.value.images.secureBaseUrl}${configuration.value.images.backdropSizes[1]}';
      _profileUrl =
          '${configuration.value.images.secureBaseUrl}${configuration.value.images.profileSizes[2]}';
      _logoUrl =
          '${configuration.value.images.secureBaseUrl}${configuration.value.images.logoSizes[3]}';
      _stillUrl =
          '${configuration.value.images.secureBaseUrl}${configuration.value.images.stillSizes[3]}';
      // ignore: avoid_print
      // print(configuration.value.changeKeys);
      configState.value = ViewState.retrived;
      // }
    });
  }
}
