import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/auth_v3_controller.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/form_field.dart';
import 'package:movie_app/src/global/form_wrapper.dart';
import 'package:movie_app/src/services/auth_v3_service.dart';
import 'package:movie_app/src/services/auth_v4_service.dart';

import 'components/auth_btn.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final v4Service = sl<AuthV4Service>();
  final v3Service = sl<AuthV3Service>();

  // final _configurationController = Get.find<ConfigurationController>();
  final _utilityController = Get.find<UtilityController>();
  // final _resultsController = Get.find<ResultsController>();
  // final _trendingResultsController = Get.find<TrendingResultsController>();
  // final _peopleController = Get.find<PeopleController>();
  // final _seasonController = Get.find<SeasonController>();
  // final _detailsController = Get.find<DetailsController>();
  final _authV3Controller = Get.find<AuthV3Controller>();

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 38),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  child: SvgPicture.asset(
                    'assets/login.svg',
                    height: 160,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Column(
                  children: [
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 18),
                        child: FormWrapper(
                          enabled:
                              _authV3Controller.sessionState == ViewState.busy
                                  ? false
                                  : true,
                          skipDisabled: true,
                          formKey: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          formFields: [
                            FormFieldsWidget(
                              name: 'username',
                              fillColor: Colors.transparent,
                              hintText: 'USERNAME',
                              validator: FormBuilderValidators.compose([
                                (data) {
                                  if (data == "" || data == null) {
                                    return "you must provide your username ...";
                                  }
                                }
                              ]),
                              border: const UnderlineInputBorder(),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: secondaryDarkBlue, width: 0.6)),
                              disabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: secondaryDarkBlue, width: 0.6)),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryDarkBlue, width: 0.6)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryblue, width: 0.6)),
                              focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryblue, width: 0.6)),
                            ),
                            const SizedBox(height: 8),
                            FormFieldsWidget(
                              name: 'password',
                              fillColor: Colors.transparent,
                              hintText: 'PASSWORD',
                              obscureField: true,
                              validator: FormBuilderValidators.compose([
                                (data) {
                                  if (data == "" || data == null) {
                                    return "you must provide your password ...";
                                  }
                                }
                              ]),
                              border: const UnderlineInputBorder(),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: secondaryDarkBlue, width: 0.6)),
                              disabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: secondaryDarkBlue, width: 0.6)),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: secondaryDarkBlue, width: 0.6)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryblue, width: 0.6)),
                              focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryblue, width: 0.6)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    AuthBtn(
                      onTap: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          _authV3Controller.authV3(
                              userData: jsonDecode(
                                  jsonEncode(_formKey.currentState!.value)));
                        }
                      },
                      title: 'Sign In'.toUpperCase(),
                    ),
                    const SizedBox(height: 18),
                    AuthBtn(
                      onTap: () {},
                      btnColor: primaryDarkBlue,
                      title: 'Continue as Guest'.toUpperCase(),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an Account?",
                          style: TextStyle(
                            fontSize: n - 2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            _utilityController.loadUrl(
                                url: 'https://www.themoviedb.org/signup');
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: n - 2,
                              color: primaryblue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 38),

                    /// developer option for authuntication to app providing (api_key, access_token) of TMDb registered acc
                    // TextButton(
                    //   onPressed: () {
                    //     v4Service.createV4RequestToken();
                    //   },
                    //   child: const Text('login auth V4'),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
