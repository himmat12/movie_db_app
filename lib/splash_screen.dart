import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';

import 'src/controllers/auth_v3_controller.dart';
import 'src/controllers/configuration_controller.dart';
import 'src/controllers/deatils_controller.dart';
import 'src/controllers/people_controller.dart';
import 'src/controllers/results_controller.dart';
import 'src/controllers/season_controller.dart';
import 'src/controllers/trending_results_controller.dart';
import 'src/controllers/utility_controller.dart';
import 'src/utils/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _configurationController = Get.find<ConfigurationController>();
  final _utilityController = Get.find<UtilityController>();
  final _resultsController = Get.find<ResultsController>();
  final _trendingResultsController = Get.find<TrendingResultsController>();
  final _peopleController = Get.find<PeopleController>();
  final _seasonController = Get.find<SeasonController>();
  final _detailsController = Get.find<DetailsController>();
  final _authV3Controller = Get.find<AuthV3Controller>();

  Future delay() async {
    return await Future.delayed(const Duration(microseconds: 3600));
  }

  @override
  void initState() {
    super.initState();
    delay().whenComplete(() {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        if (Auth.isLoggedIn == true) {
          Get.offAllNamed('/dashboard');
        }
        // else {
        //   Get.offAllNamed('/auth');
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    const Text(
                      'Movie Database Archive',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: l + 6,
                        fontWeight: FontWeight.w700,
                        color: primaryDarkBlue,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/movie.svg',
                      height: 400,
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                ),
              ),
              Auth.isLoggedIn == true
                  ? const SizedBox.shrink()
                  : Positioned(
                      bottom: 30,
                      child: GestureDetector(
                        onTap: () {
                          Get.offNamed('/auth');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryDarkBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                                fontSize: m,
                                fontWeight: FontWeight.w600,
                                color: primaryblue),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
///
///
///
///
///
///
///