import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/services/account_service.dart';
import 'package:movie_app/src/services/auth_v3_service.dart';
import 'package:movie_app/src/utils/auth.dart';

class AuthV3Controller extends BaseController {
  final v3Service = sl<AuthV3Service>();
  final _service = sl<AccountService>();

  var _sessionState = ViewState.idle.obs;

  ViewState get sessionState => _sessionState.value;

  // authuntication method
  void authV3({required Map<String, dynamic> userData}) async {
    // _requestTokenState.value = ViewState.busy;
    _sessionState.value = ViewState.busy;
    Get.dialog(
      AlertDialog(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Authunticating ...'),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
    await v3Service.createV3RequestToken().then((value) async {
      if (value['success'] != false) {
        // _requestTokenState.value = ViewState.retrived;
        // _authorizationState.value = ViewState.busy;
        await v3Service
            .authorizeV3RequestTokenWithLogin(
                requestToken: value['request_token'], data: userData)
            .then((value) async {
          if (value['success'] != false) {
            // _authorizationState.value = ViewState.retrived;
            // _sessionState.value = ViewState.busy;
            await v3Service
                .createV3Session(requestToken: value['request_token'])
                .then((value) {
              _sessionState.value = ViewState.retrived;

              Auth().setSessionId(value['session_id']);

              // print('\n\n\n SESSION_ID ==>> ${value['session_id']}');
            });

            // get user details
            await _service.getAccountDetails().then((value) {
              Auth().setUsername(usename: value['username']);
              Auth().setFullname(fullname: value['name']);
              Auth().setUserAvatar(url: value['avatar']['tmdb']['avatar_path']);
              Auth().setUserGrvatar(url: value['avatar']['gravatar']['hash']);
            });

            print(Auth().username);

            Get.offAllNamed('/dashboard');
          } else {
            _sessionState.value = ViewState.retrived;
            Get.back();
            Get.snackbar(
              'Authuntication failed!!',
              value['status_message'],
              // duration: const Duration(milliseconds: 1600),
              backgroundColor: primaryWhite,
              dismissDirection: SnackDismissDirection.HORIZONTAL,
              barBlur: 0,
              colorText: secondaryDarkBlue,
            );
          }
        });
      } else {
        _sessionState.value = ViewState.retrived;
        Get.snackbar(
          'Authuntication failed!!',
          value['status_message'],
          // duration: const Duration(milliseconds: 1600),
          backgroundColor: primaryWhite,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          barBlur: 0,
          colorText: secondaryDarkBlue,
        );
      }
    });
  }

  /// guest authuntication
  void authGuestV3() async {
    _sessionState.value = ViewState.busy;
    Get.dialog(
      AlertDialog(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Authunticating ...'),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    await v3Service.createGuestSession().then((value) {
      if (value['success'] == true) {
        print(value['guest_session_id']);
        Auth().setGuestSessionId(value['guest_session_id']);

        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar(
          'Authuntication failed!!',
          value['status_message'],
          // duration: const Duration(milliseconds: 1600),
          backgroundColor: primaryWhite,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          barBlur: 0,
          colorText: secondaryDarkBlue,
        );
      }
    });

    _sessionState.value = ViewState.retrived;
  }

  ///logout
  void logoutV3() async {
    _sessionState.value = ViewState.busy;
    Get.back();
    Get.dialog(
      AlertDialog(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Destroying sessions ...'),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    Auth().isLoggedIn
        ? await v3Service
            .deleteSession(sessionId: Auth().sessionId)
            .then((value) {
            Auth().logout();
            _sessionState.value = ViewState.retrived;

            Get.offAllNamed('/');
          })
        : await v3Service
            .deleteSession(sessionId: Auth().guestSessionId)
            .then((value) {
            Auth().logout();
            _sessionState.value = ViewState.retrived;
            Get.offAllNamed('/');
          });
  }
}
