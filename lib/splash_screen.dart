import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'src/configs/configs.dart';
import 'src/controllers/auth_v3_controller.dart';
import 'src/controllers/configuration_controller.dart';
import 'src/controllers/details_controller.dart';
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
  final configurationController = Get.find<ConfigurationController>();
  final utilityController = Get.find<UtilityController>();
  final resultsController = Get.find<ResultsController>();
  final trendingResultsController = Get.find<TrendingResultsController>();
  final peopleController = Get.find<PeopleController>();
  final seasonController = Get.find<SeasonController>();
  final detailsController = Get.find<DetailsController>();
  final authV3Controller = Get.find<AuthV3Controller>();

  Future delay() async {
    return await Future.delayed(const Duration(microseconds: 3600));
  }

  @override
  void initState() {
    super.initState();
    delay().whenComplete(() {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        if (Auth().isLoggedIn == true || Auth().isGuestLoggedIn == true) {
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
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
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
              Auth().isLoggedIn == true || Auth().isGuestLoggedIn == true
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
                            borderRadius: BorderRadius.circular(2),
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