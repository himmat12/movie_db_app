import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/configs/color_config.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/models/lists/list_model.dart';
import 'package:movie_app/src/models/lists/movie_list_details.dart';
import 'package:movie_app/src/services/lists_services.dart';

class ListController extends BaseController {
  final _service = sl<ListService>();

  var movieListDetails = MovieListDetails().obs;
  var lists = <ListModel>[].obs;

  var movieListState = ViewState.idle.obs;
  var addMovieState = ViewState.idle.obs;

// create  list - for now in V3 api only movie lists exists
  void createMovieList({required String name, String? description}) async {
    await _service.createList(name: name, description: description ?? '');
    getMovieLists();
    Get.showSnackbar(
      GetBar(
        title: 'Collections',
        message: '$name collections list successfuly created ...',
        duration: const Duration(milliseconds: 1600),
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: primaryDarkBlue,
      ),
    );
  }

  // get list details - for now in V3 api only movie lists exists
  void getMovieListDetails({required int listId}) async {
    movieListState.value = ViewState.busy;
    await _service.getListDetails(listId: listId).then((value) {
      movieListDetails.value = MovieListDetails.fromJson(value);
    });

    movieListState.value = ViewState.retrived;
  }

  //  get created lists
  void getMovieLists({String}) async {
    movieListState.value = ViewState.busy;
    await _service.getLists().then((value) {
      lists.value = List.from(
          (value['results'] as List).map((e) => ListModel.fromJson(e)));
    });

    movieListState.value = ViewState.retrived;
    update(['collections_list']);
  }

  // add movie to list
  void addMovieToList(
      {required int? listId, required int? movieId, String? listTitle}) async {
    addMovieState.value == ViewState.busy;

    await Future.wait([
      _service.addMovieToList(listId: listId, movieId: movieId).then((value) {
        if (value['success'] == true) {
          _service.getLists().then((value) {
            lists.value = List.from(
                (value['results'] as List).map((e) => ListModel.fromJson(e)));
          });

          Get.showSnackbar(
            GetBar(
              message: 'Successfuly added to $listTitle',
              isDismissible: true,
              duration: const Duration(milliseconds: 1600),
              dismissDirection: SnackDismissDirection.HORIZONTAL,
              snackStyle: SnackStyle.GROUNDED,
              backgroundColor: primaryDarkBlue,
              mainButton: TextButton(
                onPressed: () {
                  // watchlist route
                },
                child: const Text('Go to list'),
              ),
            ),
          );
        } else if (value['success'] == false) {
          Get.showSnackbar(
            GetBar(
              message: '${value['status_message']}',
              isDismissible: true,
              duration: const Duration(milliseconds: 1600),
              dismissDirection: SnackDismissDirection.HORIZONTAL,
              snackStyle: SnackStyle.GROUNDED,
              backgroundColor: primaryDarkBlue,
            ),
          );
        }
      }),
    ]);

    update(['collections_list']);

    addMovieState.value == ViewState.retrived;
  }

  //  remove movie from list
  void removeMovieFromlist(
      {required int listId, required int movieId, String? listTitle}) async {
    movieListState.value = ViewState.busy;
    await _service
        .removeMovieFromList(listId: listId, movieId: movieId)
        .then((value) {
      if (value['success'] == true) {
        Get.showSnackbar(
          GetBar(
            message: 'Successfuly added to $listTitle',
            isDismissible: true,
            duration: const Duration(milliseconds: 1600),
            dismissDirection: SnackDismissDirection.HORIZONTAL,
            snackStyle: SnackStyle.GROUNDED,
            backgroundColor: primaryDarkBlue,
            mainButton: TextButton(
              onPressed: () {
                // watchlist route
              },
              child: const Text('Go to list'),
            ),
          ),
        );
      }
    });

    movieListState.value = ViewState.retrived;
  }

  // clear list
  void clearList({required int listId}) async {
    movieListState.value = ViewState.busy;
    await _service.clearList(listId: listId).then((value) {
      if (value['success'] == true) {
        Get.showSnackbar(
          GetBar(
            message: 'Collections list cleared successfuly ...',
            isDismissible: true,
            duration: const Duration(milliseconds: 1600),
            dismissDirection: SnackDismissDirection.HORIZONTAL,
            snackStyle: SnackStyle.GROUNDED,
            backgroundColor: primaryDarkBlue,
          ),
        );
      }
    });

    movieListState.value = ViewState.retrived;
    update(['collections_list']);
  }

  // delete list
  void deleteList({required int listId}) async {
    movieListState.value = ViewState.busy;
    await _service.deleteList(listId: listId).then((value) {
      if (value['success'] == true) {
        Get.showSnackbar(
          GetBar(
            message: 'Collections list deleted successfuly ...',
            isDismissible: true,
            animationDuration: const Duration(milliseconds: 1200),
            dismissDirection: SnackDismissDirection.HORIZONTAL,
            snackStyle: SnackStyle.GROUNDED,
            backgroundColor: primaryDarkBlue,
          ),
        );
      }
    });

    movieListState.value = ViewState.retrived;
    update(['collections_list']);
  }
}
