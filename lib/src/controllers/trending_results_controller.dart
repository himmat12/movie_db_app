import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/models/movie_result_model.dart';
import 'package:movie_app/src/models/tv_result_model.dart';
import 'package:movie_app/src/services/results_service.dart';
import 'package:movie_app/src/services/trending_results_service.dart';

class TrendingResultsController extends BaseController {
  final _service = sl<TrendingResultsService>();

  var trendingTVs = <TvResultModel>[].obs;
  var trendingMovies = <MovieResultModel>[].obs;

  var tvViewState = ViewState.idle.obs;
  var movieViewState = ViewState.idle.obs;

  int moviesPage = 1;
  int tvPage = 1;

  // movie results controller

  getTrendingMovieResults({required String timeWindow}) async {
    movieViewState.value = ViewState.busy;
    await _service
        .getTrendingResults(
      mediaType: MOVIE_STRING,
      timeWindow: timeWindow,
      page: '$moviesPage',
    )
        .then((value) {
      if (value != null) {
        trendingMovies =
            RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
        // update(['trendingMovies']);
        for (var i in trendingMovies) {
          // ignore: avoid_print
          print(i.title);
        }
      }
    });
    movieViewState.value = ViewState.retrived;
  }

  loadMoreMoviesResults({required String timeWindow}) async {
    movieViewState.value = ViewState.busy;
    moviesPage = moviesPage + 1;

    await _service
        .getTrendingResults(
      mediaType: MOVIE_STRING,
      timeWindow: timeWindow,
      page: '$moviesPage',
    )
        .then((value) {
      if (value != null) {
        trendingMovies.addAll(
            RxList.from(value.map((e) => MovieResultModel.fromJson(e))));
        // update(['trendingMovies']);
        // for (var i in trendingMovies) {
        // ignore: avoid_print
        // print(trendingMovies);
        // }
      }
    });
    movieViewState.value = ViewState.retrived;
  }

  // trendingTVs results controller

  getTvResults({required String timeWindow}) async {
    tvViewState.value = ViewState.busy;
    await _service
        .getTrendingResults(
      mediaType: TV_STRING,
      timeWindow: timeWindow,
      page: '$tvPage',
    )
        .then((value) {
      if (value != null) {
        trendingTVs = RxList.from(value.map((e) => TvResultModel.fromJson(e)));
        // for (var i in trendingTVs) {
        //   // ignore: avoid_print
        //   print(i.name);
        // }
      }
    });
    tvViewState.value = ViewState.retrived;
  }
}
