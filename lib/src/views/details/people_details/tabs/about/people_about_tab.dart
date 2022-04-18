import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../configs/configs.dart';
import '../../../../../configs/strings.dart';
import '../../../../../controllers/people_controller.dart';
import '../../../../../global/loading_spinner.dart';
import '../../../../../helpers/widget_builder_helper.dart';
import '../../../components/header_text.dart';
import '../../../components/poster_card.dart';
import '../../../components/storyline_text.dart';
import 'components/about_info.dart';
import 'components/chips_builder.dart';

class PeopleAboutTab extends StatelessWidget {
  final _peopleController = Get.find<PeopleController>();

  PeopleAboutTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          aboutInfo(people: _peopleController.people.value),
          const SizedBox(height: 12),
          StoryLineTextBuilder(
              headerText: 'Biography',
              text: _peopleController.people.value.biography == "" ||
                      _peopleController.people.value.biography == null
                  ? 'No Biography at the moment'
                  : _peopleController.people.value.biography ?? "biography"),
          const SizedBox(height: 12),
          chipsBuilder(chips: _peopleController.people.value.alsoKnownAs ?? []),
          const SizedBox(height: 18),
          GetBuilder(
            id: 'people_images',
            init: _peopleController,
            initState: (_) {
              _peopleController.getCreditsDetails(
                  personId: _peopleController.personId,
                  resultType: imagesString);
            },
            builder: (controller) => WidgetBuilderHelper(
              state: _peopleController.imagesState.value,
              onLoadingBuilder: LoadingSpinner().horizontalLoading,
              onSuccessBuilder: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerBuilder(headerText: 'Images'),
                  const SizedBox(height: 12),
                  _peopleController.images.isEmpty
                      ? Text(
                          'No images to show at the moment',
                          style: TextStyle(
                            color: primaryDarkBlue.withOpacity(0.6),
                            fontSize: n - 2,
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.from(
                              _peopleController.images.map(
                                (e) => posterCard(imageUrl: e.filePath ?? "#"),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              onErrorBuilder: const Center(
                child: Text('error while loading data ...'),
              ),
              // )
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }
}
