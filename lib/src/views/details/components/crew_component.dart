import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../configs/configs.dart';
import '../../../configs/strings.dart';
import '../../../controllers/people_controller.dart';
import '../../../models/details/common_details_models.dart';
import 'header_text.dart';

Widget crewBuilder({required List<Crew> crews, required String resultType}) {
  final _peopleController = Get.find<PeopleController>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headerBuilder(headerText: "Featured Crew"),
          IconButton(
              onPressed: () {
                switch (resultType) {
                  case movieString:
                    Get.toNamed('/movie_crew');
                    break;
                  case tvString:
                    Get.toNamed('/tv_crew');
                    break;
                  default:
                    break;
                }
              },
              icon: Icon(
                Icons.arrow_forward,
                color: primaryDarkBlue.withOpacity(0.8),
              )),
        ],
      ),
      const SizedBox(height: 12),
      crews.isEmpty
          ? Center(
              child: Text(
                'No Crews To Feature at the Moment',
                style: TextStyle(color: primaryDarkBlue.withOpacity(0.6)),
              ),
            )
          : GridView.builder(
              itemCount: crews.length >= 6 ? 6 : crews.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 64,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _peopleController.setPersonId(crews[index].id!);
                    Get.toNamed('/people_details');
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          crews[index].name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: n - 2,
                            color: primaryDarkBlue.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          crews[index].job ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: primaryDarkBlue.withOpacity(0.5),
                            fontSize: n - 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    ],
  );
}
