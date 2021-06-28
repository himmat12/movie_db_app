import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/services/auth_v4_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthorizeRequestToken extends StatefulWidget {
  const AuthorizeRequestToken({Key? key}) : super(key: key);

  @override
  _AuthorizeRequestTokenState createState() => _AuthorizeRequestTokenState();
}

class _AuthorizeRequestTokenState extends State<AuthorizeRequestToken> {
  final service = sl<AuthV4Service>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: Get.parameters['url'],
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) async {
          if (url == "https://www.themoviedb.org/auth/access/approve") {
            Get.dialog(
              AlertDialog(
                actions: [
                  TextButton(
                    onPressed: () {
                      service
                          .createV4AccessToken(
                              requestToken:
                                  Get.parameters['requestToken'] ?? "")
                          .then((value) {
                        Get.back();
                        Get.back();
                      });
                    },
                    child: const Text("Continue"),
                  ),
                ],
                title: const Text('Authorized'),
                content: const Text(
                    '3rd party Authuntication request has been authorized!!'),
              ),
              barrierDismissible: false,
            );
          }
        },
      ),
    );
  }
}
