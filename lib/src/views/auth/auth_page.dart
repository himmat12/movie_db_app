import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/services/auth_service.dart';

import '../../controllers/configuration_controller.dart';
import '../../controllers/deatils_controller.dart';
import '../../controllers/people_controller.dart';
import '../../controllers/results_controller.dart';
import '../../controllers/season_controller.dart';
import '../../controllers/trending_results_controller.dart';
import '../../controllers/utility_controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final service = sl<AuthService>();

  final _configurationController = Get.find<ConfigurationController>();
  final _utilityController = Get.find<UtilityController>();
  final _resultsController = Get.find<ResultsController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();
  final _peopleController = Get.find<PeopleController>();
  final _seasonController = Get.find<SeasonController>();
  final _detailsController = Get.find<DetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  service.createRequestToken();
                },
                child: const Text('login auth'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
