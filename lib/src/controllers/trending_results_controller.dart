import 'package:get/get.dart';

import '../../service_locator.dart';
import '../configs/strings.dart';
import '../models/results/movie_result_model.dart';
import '../models/results/tv_result_model.dart';
import '../services/trending_results_service.dart';
import 'base_controller.dart';
import 'utility_controller.dart';

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

  void resetMoviePage() {
    moviesPage = 1;
  }

  void resetTvPage() {
    tvPage = 1;
  }

  // trending movie results controller
  void getTrendingMovieResults(
      {required String timeWindow, String? page}) async {
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

  void loadMoreTrendingMoviesResults({required String timeWindow}) async {
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

  void getTrendingTvResults({required String timeWindow, String? page}) async {
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

  void loadMoreTrendingTvResults({required String timeWindow}) async {
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
