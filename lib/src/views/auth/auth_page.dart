import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/controllers/auth_v3_controller.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/configuration_controller.dart';
import 'package:movie_app/src/controllers/deatils_controller.dart';
import 'package:movie_app/src/controllers/people_controller.dart';
import 'package:movie_app/src/controllers/results_controller.dart';
import 'package:movie_app/src/controllers/season_controller.dart';
import 'package:movie_app/src/controllers/trending_results_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/global/form_field.dart';
import 'package:movie_app/src/global/form_wrapper.dart';
import 'package:movie_app/src/global/loading_spinner.dart';
import 'package:movie_app/src/services/auth_v3_service.dart';
import 'package:movie_app/src/services/auth_v4_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final v4Service = sl<AuthV4Service>();
  final v3Service = sl<AuthV3Service>();

  final _configurationController = Get.find<ConfigurationController>();
  final _utilityController = Get.find<UtilityController>();
  final _resultsController = Get.find<ResultsController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();
  final _peopleController = Get.find<PeopleController>();
  final _seasonController = Get.find<SeasonController>();
  final _detailsController = Get.find<DetailsController>();
  final _authV3Controller = Get.find<AuthV3Controller>();

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    print('auth page build');

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Obx(
              //   () =>
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: FormWrapper(
                  // absorbing: _authV3Controller.sessionState == ViewState.busy
                  //     ? true
                  //     : false,
                  formKey: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  formFields: [
                    // FormBuilderTextField(
                    //   name: 'username',
                    //   validator: (data) {
                    //     FormBuilderValidators.required(context,
                    //         errorText: data);
                    //   },
                    //   decoration: const InputDecoration(
                    //     labelText: '',
                    //     hintText: 'Username',
                    //   ),
                    // ),
                    // FormBuilderTextField(
                    //   name: 'password',
                    //   validator: (data) {
                    //     FormBuilderValidators.required(context,
                    //         errorText: data);
                    //   },
                    //   decoration: const InputDecoration(
                    //     labelText: '',
                    //     hintText: 'Password',
                    //   ),
                    // ),

                    FormFieldsWidget(
                      controller: TextEditingController(),
                      name: 'username',
                      fillColor: Colors.transparent,
                      labelText: '',
                      hintText: 'Username',
                      validator: (data) {
                        FormBuilderValidators.required(context,
                            errorText: data);
                      },
                      border: const UnderlineInputBorder(),
                      enabledBorder: const UnderlineInputBorder(),
                      errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                    FormFieldsWidget(
                      controller: TextEditingController(),
                      name: 'password',
                      fillColor: Colors.transparent,
                      labelText: '',
                      hintText: 'Password',
                      obscureField: true,
                      // validator: (data) {
                      //   FormBuilderValidators.required(context,
                      //       errorText: data);
                      // },
                      border: const UnderlineInputBorder(),
                      enabledBorder: const UnderlineInputBorder(),
                      errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ],
                ),
              ),
              // ),
              const SizedBox(height: 18),
              Obx(
                () => _authV3Controller.sessionState == ViewState.busy
                    ? LoadingSpinner.horizontalLoading
                    : TextButton(
                        onPressed: () {
                          // v3Service.createV3RequestToken();
                          if (_formKey.currentState!.saveAndValidate()) {
                            print(_formKey.currentState!.value["username"]);
                            print(_formKey.currentState!.value["password"]);

                            _authV3Controller.authV3(userData: {
                              "username":
                                  _formKey.currentState!.value["username"],
                              "password":
                                  _formKey.currentState!.value["password"]
                            });
                          }
                        },
                        child: const Text('login auth V3'),
                      ),
              ),
              TextButton(
                onPressed: () {
                  v4Service.createV4RequestToken();
                },
                child: const Text('login auth V4'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
