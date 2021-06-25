import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/controllers/utility_controller.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';
import 'package:movie_app/src/models/results/tv_result_model.dart';
import 'package:movie_app/src/services/trending_results_service.dart';

class TrendingResultsController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    final _utilityController = Get.find<UtilityController>();

    // initializing trending MOVIES services
    if (_utilityController.isMovieToday == true) {
      getTrendingMovieResults(timeWindow: dayString);
    } else {
      getTrendingMovieResults(timeWindow: weekString);
    }

    // initializing trending TV services
    if (_utilityController.isTvToday == true) {
      getTrendingTvResults(timeWindow: dayString);
    } else {
      getTrendingTvResults(timeWindow: weekString);
    }
  }

  final _service = sl<TrendingResultsService>();

  var trendingTVs = <TvResultsModel>[].obs;
  var trendingMovies = <MovieResultModel>[].obs;

  final _tvViewState = ViewState.idle.obs;
  final _movieViewState = ViewState.idle.obs;

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
  getTrendingMovieResults({required String timeWindow, String? page}) async {
    _movieViewState.value = ViewState.busy;
    resetMoviePage();
    await _service
        .getTrendingResults(
      mediaType: movieString,
      timeWindow: timeWindow,
      page: page ?? '$moviesPage',
    )
        .then((value) {
      // if (value != null) {
      trendingMovies =
          RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
      // for (var i in trendingMovies) {
      // // ignore: avoid_print
      //   print(i.title);
      // }
      _movieViewState.value = ViewState.retrived;
      update(['trending_movies_list']);
      // }
    });
  }

  loadMoreTrendingMoviesResults({required String timeWindow}) async {
    _movieViewState.value = ViewState.busy;
    moviesPage = moviesPage + 1;

    await _service
        .getTrendingResults(
      mediaType: movieString,
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
        _movieViewState.value = ViewState.retrived;
        update(['trending_movies_list']);
      }
    });
  }

// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

  getTrendingTvResults({required String timeWindow, String? page}) async {
    _tvViewState.value = ViewState.busy;
    resetTvPage();
    await _service
        .getTrendingResults(
      mediaType: tvString,
      timeWindow: timeWindow,
      page: page ?? '$tvPage',
    )
        .then((value) {
      if (value != null) {
        trendingTVs = RxList.from(value.map((e) => TvResultsModel.fromJson(e)));
        // for (var i in trendingMovies) {
        // // ignore: avoid_print
        //   print(i.title);
        // }
        _tvViewState.value = ViewState.retrived;
        update(['trending_tv_list']);
      }
    });
  }

  loadMoreTrendingTvResults({required String timeWindow}) async {
    _tvViewState.value = ViewState.busy;
    tvPage = tvPage + 1;

    await _service
        .getTrendingResults(
      mediaType: tvString,
      timeWindow: timeWindow,
      page: '$tvPage',
    )
        .then((value) {
      if (value != null) {
        trendingTVs
            .addAll(RxList.from(value.map((e) => TvResultsModel.fromJson(e))));
        // update(['trendingMovies']);
        // for (var i in trendingMovies) {
        // ignore: avoid_print
        // print(trendingMovies);
        // }
        _tvViewState.value = ViewState.retrived;
        update(['trending_tv_list']);
      }
    });
  }
}
