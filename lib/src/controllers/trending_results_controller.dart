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

  var _tvViewState = ViewState.idle.obs;
  var _movieViewState = ViewState.idle.obs;

  int moviesPage = 1;
  int tvPage = 1;

  ViewState get movieViewState => _movieViewState.value;
  ViewState get tvViewState => _tvViewState.value;

  resetMoviePage() {
    moviesPage = 1;
  }

  resetTvPage() {
    tvPage = 1;
  }

  // trending movie results controller
  getTrendingMovieResults({required String timeWindow}) async {
    _movieViewState.value = ViewState.busy;
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
        // for (var i in trendingMovies) {
        // // ignore: avoid_print
        //   print(i.title);
        // }
      }
    });
    _movieViewState.value = ViewState.retrived;
  }

  loadMoreTrendingMoviesResults({required String timeWindow}) async {
    _movieViewState.value = ViewState.busy;
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
    _movieViewState.value = ViewState.retrived;
  }

// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

  getTrendingTvResults({required String timeWindow}) async {
    _tvViewState.value = ViewState.busy;
    await _service
        .getTrendingResults(
      mediaType: TV_STRING,
      timeWindow: timeWindow,
      page: '$tvPage',
    )
        .then((value) {
      if (value != null) {
        trendingTVs = RxList.from(value.map((e) => TvResultModel.fromJson(e)));
        // for (var i in trendingMovies) {
        // // ignore: avoid_print
        //   print(i.title);
        // }
      }
    });
    _tvViewState.value = ViewState.retrived;
  }

  loadMoreTrendingTvResults({required String timeWindow}) async {
    _tvViewState.value = ViewState.busy;
    tvPage = tvPage + 1;

    await _service
        .getTrendingResults(
      mediaType: TV_STRING,
      timeWindow: timeWindow,
      page: '$tvPage',
    )
        .then((value) {
      if (value != null) {
        trendingTVs
            .addAll(RxList.from(value.map((e) => TvResultModel.fromJson(e))));
        // update(['trendingMovies']);
        // for (var i in trendingMovies) {
        // ignore: avoid_print
        // print(trendingMovies);
        // }
      }
    });
    _tvViewState.value = ViewState.retrived;
  }
}
