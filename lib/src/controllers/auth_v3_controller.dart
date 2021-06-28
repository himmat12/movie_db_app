import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/services/auth_v3_service.dart';
import 'package:movie_app/src/utils/auth.dart';

class AuthV3Controller extends BaseController {
  final v3Service = sl<AuthV3Service>();

  var _requestTokenState = ViewState.idle.obs;
  var _authorizationState = ViewState.idle.obs;
  var _sessionState = ViewState.idle.obs;

  ViewState get requestTokenState => _requestTokenState.value;
  ViewState get authorizationState => _authorizationState.value;
  ViewState get sessionState => _sessionState.value;

  // authuntication method
  authV3({required Map<String, dynamic> userData}) {
    // _requestTokenState.value = ViewState.busy;
    _sessionState.value = ViewState.busy;
    v3Service.createV3RequestToken().then((value) {
      if (value['success'] != false) {
        // _requestTokenState.value = ViewState.retrived;
        // _authorizationState.value = ViewState.busy;
        v3Service
            .authorizeV3RequestTokenWithLogin(
                requestToken: value['request_token'], data: userData)
            .then((value) {
          if (value['success'] != false) {
            // _authorizationState.value = ViewState.retrived;
            // _sessionState.value = ViewState.busy;
            v3Service
                .createV3Session(requestToken: value['request_token'])
                .then((value) {
              _sessionState.value = ViewState.retrived;

              Auth.setSessionId(value['session_id']);

              print('\n\n\n SESSION_ID ==>> ${value['session_id']}');

              Get.offAllNamed('/dashboard');
            });
          } else {
            _sessionState.value = ViewState.retrived;
            Get.snackbar('Authuntication failed!!', value['status_message']);
          }
        });
      } else {
        _sessionState.value = ViewState.retrived;
        Get.snackbar('Authuntication failed!!', value['status_message']);
      }
    });
  }

  logoutV3() {
    Auth.logout();
    Get.offAllNamed('/');
  }
}
