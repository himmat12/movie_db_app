import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/models/results/movie_result_model.dart';
import 'package:movie_app/src/models/results/tv_result_model.dart';
import 'package:movie_app/src/services/results_service.dart';

class ResultsController extends BaseController {
  final _service = sl<ResultsService>();

// tv observable lists
  var popularTvList = <TvResultsModel>[].obs;
  var topRatedTvList = <TvResultsModel>[].obs;
  var onTheAirTvList = <TvResultsModel>[].obs;
  var airingTodayTvList = <TvResultsModel>[].obs;

// movies observable lists
  var popularMovies = <MovieResultModel>[].obs;
  var topRatedMovies = <MovieResultModel>[].obs;
  var upcommingMovies = <MovieResultModel>[].obs;
  var nowPlayingMovies = <MovieResultModel>[].obs;

// tv view states
  var popularTvState = ViewState.idle.obs;
  var topRatedTvState = ViewState.idle.obs;
  var onTheAirTvState = ViewState.idle.obs;
  var airingTodayTvState = ViewState.idle.obs;

// movie view states
  var popularMoviesState = ViewState.idle.obs;
  var topRatedMoviesState = ViewState.idle.obs;
  var upcommingMoviesState = ViewState.idle.obs;
  var nowPlayingMoviesState = ViewState.idle.obs;

// movie pages
  int popularMoviesPage = 1;
  int topRatedMoviesPage = 1;
  int upcommingMoviesPage = 1;
  int nowPlayingMoviesPage = 1;

// tv pages
  int popularTvPage = 1;
  int topRatedTvPage = 1;
  int onTheAirTvPage = 1;
  int airingTodayTvPage = 1;

// method only for trending movie pagination state
  resetMoviePage() {
    popularMoviesPage = 1;
  }

// method only for trending tv pagination state
  resetTvPage() {
    popularTvPage = 1;
  }

  /// [movie results controller]
  getMovieResults({required String resultType}) async {
    switch (resultType) {
      case POPULAR_STRING:
        popularMoviesState.value = ViewState.busy;
        await _service
            .getMovieResults(resultType: resultType, page: '$popularMoviesPage')
            .then((value) {
          if (value != null) {
            popularMovies =
                RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
            popularMovies.refresh();
            popularMoviesState.value = ViewState.retrived;
          }
        });
        break;
      case TOP_RATED_STRING:
        topRatedMoviesState.value = ViewState.busy;
        await _service
            .getMovieResults(
                resultType: resultType, page: '$topRatedMoviesPage')
            .then((value) {
          if (value != null) {
            topRatedMovies =
                RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
            topRatedMoviesState.value = ViewState.retrived;
          }
        });
        break;
      case UPCOMING_STRING:
        upcommingMoviesState.value = ViewState.busy;
        await _service
            .getMovieResults(
                resultType: resultType, page: '$upcommingMoviesPage')
            .then((value) {
          if (value != null) {
            upcommingMovies =
                RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
            upcommingMoviesState.value = ViewState.retrived;
          }
        });
        break;
      case NOW_PLAYING_STRING:
        nowPlayingMoviesState.value = ViewState.busy;
        await _service
            .getMovieResults(
                resultType: resultType, page: '$nowPlayingMoviesPage')
            .then((value) {
          if (value != null) {
            nowPlayingMovies =
                RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
            nowPlayingMoviesState.value = ViewState.retrived;
          }
        });
        break;

      default:
        break;
    }
  }

  loadMoreMoviesResults({required String resultType}) async {
    switch (resultType) {
      case POPULAR_STRING:
        popularMoviesPage = popularMoviesPage + 1;
        popularMoviesState.value = ViewState.busy;
        await _service
            .getMovieResults(resultType: resultType, page: '$popularMoviesPage')
            .then((value) {
          if (value != null) {
            popularMovies.addAll(
                RxList.from(value.map((e) => MovieResultModel.fromJson(e))));
            popularMoviesState.value = ViewState.retrived;
          }
        });
        break;
      case TOP_RATED_STRING:
        topRatedMoviesPage = topRatedMoviesPage + 1;
        topRatedMoviesState.value = ViewState.busy;
        await _service
            .getMovieResults(
                resultType: resultType, page: '$topRatedMoviesPage')
            .then((value) {
          if (value != null) {
            topRatedMovies.addAll(
                RxList.from(value.map((e) => MovieResultModel.fromJson(e))));
            topRatedMoviesState.value = ViewState.retrived;
          }
        });
        break;
      case UPCOMING_STRING:
        upcommingMoviesPage = upcommingMoviesPage + 1;
        upcommingMoviesState.value = ViewState.busy;
        await _service
            .getMovieResults(
                resultType: resultType, page: '$upcommingMoviesPage')
            .then((value) {
          if (value != null) {
            upcommingMovies.addAll(
                RxList.from(value.map((e) => MovieResultModel.fromJson(e))));
            upcommingMoviesState.value = ViewState.retrived;
          }
        });
        break;
      case NOW_PLAYING_STRING:
        nowPlayingMoviesPage = nowPlayingMoviesPage + 1;
        nowPlayingMoviesState.value = ViewState.busy;
        await _service
            .getMovieResults(
                resultType: resultType, page: '$nowPlayingMoviesPage')
            .then((value) {
          if (value != null) {
            nowPlayingMovies.addAll(
                RxList.from(value.map((e) => MovieResultModel.fromJson(e))));
            nowPlayingMoviesState.value = ViewState.retrived;
          }
        });
        break;

      default:
        break;
    }
  }

  /// [tvList results controller]
  getTvResults({required String resultType}) async {
    switch (resultType) {
      case POPULAR_STRING:
        popularTvState.value = ViewState.busy;
        await _service
            .getTvResults(resultType: resultType, page: '$popularTvPage')
            .then((value) {
          if (value != null) {
            popularTvList =
                RxList.from(value.map((e) => TvResultsModel.fromJson(e)));
            popularTvList.refresh();
            popularTvState.value = ViewState.retrived;
          }
        });
        break;
      case TOP_RATED_STRING:
        topRatedTvState.value = ViewState.busy;
        await _service
            .getTvResults(resultType: resultType, page: '$topRatedTvPage')
            .then((value) {
          if (value != null) {
            topRatedTvList =
                RxList.from(value.map((e) => TvResultsModel.fromJson(e)));
            topRatedTvState.value = ViewState.retrived;
          }
        });
        break;
      case ON_THE_AIR_STRING:
        onTheAirTvState.value = ViewState.busy;
        await _service
            .getTvResults(resultType: resultType, page: '$onTheAirTvPage')
            .then((value) {
          if (value != null) {
            onTheAirTvList =
                RxList.from(value.map((e) => TvResultsModel.fromJson(e)));
            onTheAirTvState.value = ViewState.retrived;
          }
        });
        break;
      case AIRING_TODAY_STRING:
        airingTodayTvState.value = ViewState.busy;
        await _service
            .getTvResults(resultType: resultType, page: '$airingTodayTvPage')
            .then((value) {
          if (value != null) {
            airingTodayTvList =
                RxList.from(value.map((e) => TvResultsModel.fromJson(e)));
            airingTodayTvState.value = ViewState.retrived;
          }
        });
        break;

      default:
        break;
    }
  }

  loadMoreTvResults({required String resultType}) async {
    switch (resultType) {
      case POPULAR_STRING:
        popularTvPage = popularTvPage + 1;
        popularTvState.value = ViewState.busy;
        await _service
            .getTvResults(resultType: resultType, page: '$popularTvPage')
            .then((value) {
          if (value != null) {
            popularTvList.addAll(
                RxList.from(value.map((e) => TvResultsModel.fromJson(e))));
            popularTvState.value = ViewState.retrived;
          }
        });
        break;
      case TOP_RATED_STRING:
        topRatedTvPage = topRatedTvPage + 1;
        topRatedTvState.value = ViewState.busy;
        await _service
            .getTvResults(resultType: resultType, page: '$topRatedTvPage')
            .then((value) {
          if (value != null) {
            topRatedTvList.addAll(
                RxList.from(value.map((e) => TvResultsModel.fromJson(e))));
            topRatedTvState.value = ViewState.retrived;
          }
        });
        break;
      case ON_THE_AIR_STRING:
        onTheAirTvPage = onTheAirTvPage + 1;
        onTheAirTvState.value = ViewState.busy;
        await _service
            .getTvResults(resultType: resultType, page: '$onTheAirTvPage')
            .then((value) {
          if (value != null) {
            onTheAirTvList.addAll(
                RxList.from(value.map((e) => TvResultsModel.fromJson(e))));
            onTheAirTvState.value = ViewState.retrived;
          }
        });
        break;
      case AIRING_TODAY_STRING:
        airingTodayTvPage = airingTodayTvPage + 1;
        airingTodayTvState.value = ViewState.busy;
        await _service
            .getTvResults(resultType: resultType, page: '$airingTodayTvPage')
            .then((value) {
          if (value != null) {
            airingTodayTvList.addAll(
                RxList.from(value.map((e) => TvResultsModel.fromJson(e))));
            airingTodayTvState.value = ViewState.retrived;
          }
        });
        break;

      default:
        break;
    }
  }
}
