import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../configs/configs.dart';
import '../../../../controllers/base_controller.dart';
import '../../../../controllers/details_controller.dart';
import '../../../../controllers/list_controller.dart';
import '../../../../global/loading_spinner.dart';

class CollectionListview extends StatelessWidget {
  CollectionListview(this.scrollController, {Key? key}) : super(key: key);
  final ScrollController scrollController;

  final _detailsController = Get.find<DetailsController>();
  final _listController = Get.find<ListController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                            onLongPress: () {
                              Get.showSnackbar(GetBar(
                                message:
                                    'Do you want to delete ${_listController.lists[index].name} list?',
                                dismissDirection:
                                    SnackDismissDirection.HORIZONTAL,
                                mainButton: Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text('Cancle'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _listController.deleteList(
                                            listId: _listController
                                                .lists[index].id);
                                        Get.back();
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              ));
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 10),
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
  }
}
