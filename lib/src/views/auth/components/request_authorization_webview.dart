import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/services/auth_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthorizeRequestToken extends StatefulWidget {
  const AuthorizeRequestToken({Key? key}) : super(key: key);

  @override
  _AuthorizeRequestTokenState createState() => _AuthorizeRequestTokenState();
}

class _AuthorizeRequestTokenState extends State<AuthorizeRequestToken> {
  final service = sl<AuthService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: Get.parameters['url'],
        javascriptMode: JavascriptMode.unrestricted,
        // navigationDelegate: (navigation) async {
        //   if (navigation.url ==
        //       "https://www.themoviedb.org/auth/access/approve") {
        //     Get.back();
        //   }
        //   return NavigationDecision.navigate;
        // },
        onPageFinished: (url) async {
          if (url == "https://www.themoviedb.org/auth/access/approve") {
            // await Future.delayed(const Duration(milliseconds: 1200));
            // Get.back();
            Get.dialog(
              AlertDialog(
                actions: [
                  TextButton(
                    onPressed: () {
                      // print(
                      //     'REQUEST TOKEN ==>> ${Get.parameters['requestToken']}');
                      service
                          .createAccessToken(
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
                content:
                    const Text('3rd Party Authuntication Request Authorized'),
              ),
              barrierDismissible: false,
            );
          }
          // print('NAVIGATION URL ==>> $url');
        },
      ),
    );
  }
}
