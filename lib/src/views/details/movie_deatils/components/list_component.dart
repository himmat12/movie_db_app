import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../configs/configs.dart';
import '../../../../controllers/details_controller.dart';
import '../../../../controllers/list_controller.dart';
import 'collection_listview.dart';

class ListComponent extends StatelessWidget {
  const ListComponent({Key? key}) : super(key: key);

  // final _listController = Get.find<ListController>();

  @override
  Widget build(BuildContext context) {
    print('HASH CODE: $hashCode');

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 1,
        maxChildSize: 1,
        minChildSize: 0.3,
        expand: true,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              height: 360,
              decoration: const BoxDecoration(
                color: primaryWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  // create new list btn
                  const CreateListBtn(),
                  const SizedBox(height: 6),

                  // search field
                  const SearchField(),
                  const SizedBox(height: 12),

                  // caption text
                  const CaptionText(),

                  // collection lists listview
                  CollectionListview(scrollController),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// list title dialog helper
void createListDialog() {
  final _listController = Get.find<ListController>();
  final TextEditingController _listTitle = TextEditingController();

  Get.dialog(AlertDialog(
    content: TextField(
      controller: _listTitle,
      decoration: const InputDecoration(
        hintText: 'Title',
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          if (_listTitle.text.trim().isNotEmpty) {
            _listController.createMovieList(name: _listTitle.text);
            _listTitle.clear();
            Get.back();
          }
        },
        child: const Text('Create'),
      ),
    ],
  ));
}

/// create list btn
class CreateListBtn extends StatelessWidget {
  const CreateListBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        createListDialog();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: const [
            Icon(
              Icons.add,
              size: 28,
              color: primaryblue,
            ),
            Text(
              'Create New Collections List',
              style: TextStyle(
                fontSize: m - 2,
                color: primaryblue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///search field
class SearchField extends GetView<ListController> {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FormBuilderTextField(
        name: 'search_collection',
        onChanged: (value) {
          controller.getMovieLists(query: value);
        },
        style: const TextStyle(
          fontSize: n,
          color: secondaryDarkBlue,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: 'Search',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          filled: true,
          focusColor: Colors.green.shade200,
          suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: primaryDarkBlue.withOpacity(0.8),
                size: 28,
              )),
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
          enabledBorder:
              const UnderlineInputBorder(borderSide: BorderSide.none),
          disabledBorder:
              const UnderlineInputBorder(borderSide: BorderSide.none),
          errorBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
          focusedBorder:
              const UnderlineInputBorder(borderSide: BorderSide.none),
          focusedErrorBorder:
              const UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

///caption text
class CaptionText extends GetView<DetailsController> {
  const CaptionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'Add "${controller.movieDetail.value.title}" to one of your collections ...',
        style: TextStyle(
          fontSize: m - 4,
          color: primaryDarkBlue.withOpacity(0.9),
        ),
      ),
    );
  }
}
