import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/configs/configs.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/details_controller.dart';
import 'package:movie_app/src/controllers/list_controller.dart';
import 'package:movie_app/src/global/loading_spinner.dart';

class ListComponent extends StatelessWidget {
  ListComponent({Key? key}) : super(key: key);

  final _detailsController = Get.find<DetailsController>();
  final _listController = Get.find<ListController>();

  final TextEditingController _listTitle = TextEditingController();

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
                  createListBtn(),
                  const SizedBox(height: 6),

                  // search field
                  searchField(),
                  const SizedBox(height: 12),

                  // caption text
                  captionText(),

                  // collection lists listview
                  collectionListview(scrollController),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// list title dialog helper
  void createListDialog() {
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
            _listController.createMovieList(name: _listTitle.text);
            _listTitle.clear();
            Get.back();
          },
          child: const Text('Create'),
        ),
      ],
    ));
  }

  /// create list btn
  Widget createListBtn() => GestureDetector(
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

  ///search field
  Widget searchField() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FormBuilderTextField(
          name: 'search_collection',
          onChanged: (value) {
            _listController.getMovieLists(query: value);
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
            errorBorder:
                const UnderlineInputBorder(borderSide: BorderSide.none),
            focusedBorder:
                const UnderlineInputBorder(borderSide: BorderSide.none),
            focusedErrorBorder:
                const UnderlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      );

  ///caption text
  Widget captionText() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Add "${_detailsController.movieDetail.value.title}" to one of your collections ...',
          style: TextStyle(
            fontSize: m - 4,
            color: primaryDarkBlue.withOpacity(0.9),
          ),
        ),
      );

  ///collections list listview
  Widget collectionListview(ScrollController scrollController) => Expanded(
        child: Scrollbar(
          isAlwaysShown: true,
          controller: scrollController,
          thickness: 6.0,
          radius: const Radius.circular(8.0),
          child: GetBuilder(
            id: 'collections_list',
            init: _listController,
            initState: (state) {
              _listController.getMovieLists();
            },
            builder: (controller) => Obx(
              () => _listController.movieListState.value == ViewState.busy
                  ? LoadingSpinner().fadingCircleSpinner
                  : ListView.builder(
                      primary: true,
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                      itemCount: _listController.lists.isEmpty
                          ? 1
                          : _listController.lists.length,
                      itemBuilder: (context, index) => _listController
                              .lists.isEmpty
                          ? const Center(
                              child: Text('No collections list available'),
                            )
                          : GestureDetector(
                              onTap: () {
                                print(
                                    'added to ${_listController.lists[index].name}');

                                _listController.addMovieToList(
                                  listTitle: _listController.lists[index].name,
                                  listId: _listController.lists[index].id,
                                  movieId:
                                      _detailsController.movieDetail.value.id,
                                );
                              },
                              child: Container(
                                color: Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _listController.lists[index].name ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: n,
                                          fontWeight: FontWeight.w400,
                                          color: primaryblue,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ' (${_listController.lists[index].itemCount})',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: primaryblue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
            ),
          ),
        ),
      );

  ///
  ///
  ///
  ///
}
