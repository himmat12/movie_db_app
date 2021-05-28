import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/models/movie_result_model.dart';
import 'package:movie_app/src/models/tv_result_model.dart';
import 'package:movie_app/src/services/results_service.dart';

class ResultsController extends BaseController {
  final _service = sl<ResultsService>();

  var tv = <TvResultModel>[].obs;
  var movies = <MovieResultModel>[].obs;

  var tvViewState = ViewState.idle.obs;
  var _movieViewState = ViewState.idle.obs;

  int moviesPage = 1;
  int tvPage = 1;

  ViewState get movieViewState => _movieViewState.value;

  // movie results controller

  getMovieResults({required String resultType}) async {
    _movieViewState.value = ViewState.busy;
    await _service
        .getMovieResults(resultType: resultType, page: '$moviesPage')
        .then((value) {
      if (value != null) {
        movies = RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
        // update(['movies']);
        // for (var i in movies) {
        // ignore: avoid_print
        print(movies.length);

        // }
      }
    });
    _movieViewState.value = ViewState.retrived;
  }

  loadMoreMoviesResults({required String resultType}) async {
    _movieViewState.value = ViewState.busy;
    moviesPage = moviesPage + 1;
    await _service
        .getMovieResults(resultType: resultType, page: '$moviesPage')
        .then((value) {
      if (value != null) {
        movies.addAll(
            RxList.from(value.map((e) => MovieResultModel.fromJson(e))));
        // update(['movies']);
        // for (var i in movies) {
        // ignore: avoid_print
        // print(movies);
        // }
      }
    });
    _movieViewState.value = ViewState.retrived;
  }

  // tv results controller

  getTvResults({required String resultType}) async {
    tvViewState.value = ViewState.busy;
    await _service
        .getTvResults(resultType: resultType, page: '$tvPage')
        .then((value) {
      if (value != null) {
        tv = RxList.from(value.map((e) => TvResultModel.fromJson(e)));
        // for (var i in tv) {
        //   // ignore: avoid_print
        //   print(i.name);
        // }
      }
    });
    tvViewState.value = ViewState.retrived;
  }
}
