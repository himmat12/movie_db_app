import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/details_controller.dart';

class ListComponent extends StatelessWidget {
  ListComponent({Key? key}) : super(key: key);

  final _detailsController = Get.find<DetailsController>();

  @override
  Widget build(BuildContext context) {
    print('HASH CODE: $hashCode');

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 1,
        minChildSize: 0.3,
        expand: true,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              decoration: const BoxDecoration(
                color: primaryWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: const [
                  Text('data'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
