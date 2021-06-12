import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/person_controller.dart';

class PeopleDetails extends StatelessWidget {
  PeopleDetails({Key? key}) : super(key: key);

  final _peopleController = Get.find<PeopleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 90),
            TextButton(
              onPressed: () {
                _peopleController.getPeopleDetails(personId: 54693);
                _peopleController.getCreditsDetails(
                    personId: 54693, resultType: movieCreditsString);
                _peopleController.getCreditsDetails(
                    personId: 54693, resultType: tvCreditsString);
                _peopleController.getCreditsDetails(
                    personId: 54693, resultType: externalIdsString);
                _peopleController.getCreditsDetails(
                    personId: 54693, resultType: imagesString);
              },
              child: const Text('get people details'),
            ),
          ],
        ),
      ),
    );
  }
}
