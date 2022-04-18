import 'package:get/get.dart';

import '../../service_locator.dart';
import '../configs/strings.dart';
import '../models/results/movie_result_model.dart';
import '../models/results/tv_result_model.dart';
import '../services/results_service.dart';
import 'base_controller.dart';

class ResultsController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    // initializing popular/top rated/upcomming/now playing MOVIES services
    getMovieResults(resultType: popularString);
    getMovieResults(resultType: topRatedString);
    getMovieResults(resultType: upcomingString);
    getMovieResults(resultType: nowPlayingString);

    // initializing popular/top rated/airing today/on the air TV services
    getTvResults(resultType: popularString);
    getTvResults(resultType: topRatedString);
    getTvResults(resultType: airingTodayString);
    getTvResults(resultType: onTheAirString);
  }

  final _service = sl<ResultsService>();

  // final _movie = MovieResultModel().obs;
  // final _tv = TvResultsModel().obs;

  final _movieId = '0'.obs;
  final _tvId = '0'.obs;

  String get movieId => _movieId.value;
  String get tvId => _tvId.value;

  void setMovieId(String id) => _movieId.value = id;
  void setTvId(String id) => _tvId.value = id;

  // MovieResultModel get movie => _movie.value;
  // TvResultsModel get tv => _tv.value;

  // void setMovie(MovieResultModel movie) {
  //   _movie.value = movie;
  //
  // }

  // void setTv(TvResultsModel tv) {
  //   _tv.value = tv;
  //
  // }

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
  void resetMoviePage() {
    popularMoviesPage = 1;
  }

// method only for trending tv pagination state
  void resetTvPage() {
    popularTvPage = 1;
  }

  /// [movie results controller]
  void getMovieResults({required String resultType, String? page}) async {
    switch (resultType) {
      case popularString:
        popularMoviesState.value = ViewState.busy;
        popularMoviesPage = 1;
        await _service
            .getMovieResults(
                resultType: resultType, page: page ?? '$popularMoviesPage')
            .then((value) {
          if (value != null) {
            popularMovies =
                RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
            popularMovies.refresh();
            popularMoviesState.value = ViewState.retrived;

            update(['movies_result']);
          }
        });
        break;
      case topRatedString:
        topRatedMoviesState.value = ViewState.busy;
        topRatedMoviesPage = 1;
        await _service
            .getMovieResults(
                resultType: resultType, page: page ?? '$topRatedMoviesPage')
            .then((value) {
          if (value != null) {
            topRatedMovies =
                RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
            topRatedMoviesState.value = ViewState.retrived;

            update(['movies_result']);
          }
        });
        break;
      case upcomingString:
        upcommingMoviesState.value = ViewState.busy;
        upcommingMoviesPage = 1;
        await _service
            .getMovieResults(
                resultType: resultType, page: page ?? '$upcommingMoviesPage')
            .then((value) {
          if (value != null) {
            upcommingMovies =
                RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
            upcommingMoviesState.value = ViewState.retrived;

            update(['movies_result']);
          }
        });
        break;
      case nowPlayingString:
        nowPlayingMoviesState.value = ViewState.busy;
        nowPlayingMoviesPage = 1;
        await _service
            .getMovieResults(
                resultType: resultType, page: page ?? '$nowPlayingMoviesPage')
            .then((value) {
          if (value != null) {
            nowPlayingMovies =
                RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
            nowPlayingMoviesState.value = ViewState.retrived;

            update(['movies_result']);
          }
        });
        break;

      default:
        break;
    }
  }

  void loadMoreMoviesResults({required String resultType}) async {
    switch (resultType) {
      case popularString:
        popularMoviesPage = popularMoviesPage + 1;
        popularMoviesState.value = ViewState.busy;
        await _service
            .getMovieResults(resultType: resultType, page: '$popularMoviesPage')
            .then((value) {
          if (value != null) {
            popularMovies.addAll(
                RxList.from(value.map((e) => MovieResultModel.fromJson(e))));
            popularMoviesState.value = ViewState.retrived;

            update(['movies_result']);
          }
        });
        break;
      case topRatedString:
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

            update(['movies_result']);
          }
        });
        break;
      case upcomingString:
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

            update(['movies_result']);
          }
        });
        break;
      case nowPlayingString:
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

            update(['movies_result']);
          }
        });
        break;

      default:
        break;
    }
  }

  /// [tvList results controller]
  void getTvResults({required String resultType, String? page}) async {
    switch (resultType) {
      case popularString:
        popularTvState.value = ViewState.busy;
        popularTvPage = 1;
        await _service
            .getTvResults(
                resultType: resultType, page: page ?? '$popularTvPage')
            .then((value) {
          if (value != null) {
            popularTvList =
                RxList.from(value.map((e) => TvResultsModel.fromJson(e)));
            popularTvList.refresh();
            popularTvState.value = ViewState.retrived;

            update(['tv_result']);
          }
        });
        break;
      case topRatedString:
        topRatedTvState.value = ViewState.busy;
        topRatedTvPage = 1;
        await _service
            .getTvResults(
                resultType: resultType, page: page ?? '$topRatedTvPage')
            .then((value) {
          if (value != null) {
            topRatedTvList =
                RxList.from(value.map((e) => TvResultsModel.fromJson(e)));
            topRatedTvState.value = ViewState.retrived;

            update(['tv_result']);
          }
        });
        break;
      case onTheAirString:
        onTheAirTvState.value = ViewState.busy;
        onTheAirTvPage = 1;
        await _service
            .getTvResults(
                resultType: resultType, page: page ?? '$onTheAirTvPage')
            .then((value) {
          if (value != null) {
            onTheAirTvList =
                RxList.from(value.map((e) => TvResultsModel.fromJson(e)));
            onTheAirTvState.value = ViewState.retrived;

            update(['tv_result']);
          }
        });
        break;
      case airingTodayString:
        airingTodayTvState.value = ViewState.busy;
        airingTodayTvPage = 1;
        await _service
            .getTvResults(
                resultType: resultType, page: page ?? '$airingTodayTvPage')
            .then((value) {
          if (value != null) {
            airingTodayTvList =
                RxList.from(value.map((e) => TvResultsModel.fromJson(e)));
            airingTodayTvState.value = ViewState.retrived;

            update(['tv_result']);
          }
        });
        break;

      default:
        break;
    }
  }

  void loadMoreTvResults({required String resultType}) async {
    switch (resultType) {
      case popularString:
        popularTvPage = popularTvPage + 1;
        popularTvState.value = ViewState.busy;
        await _service
            .getTvResults(resultType: resultType, page: '$popularTvPage')
            .then((value) {
          if (value != null) {
            popularTvList.addAll(
                RxList.from(value.map((e) => TvResultsModel.fromJson(e))));
            popularTvState.value = ViewState.retrived;

            update(['tv_result']);
          }
        });
        break;
      case topRatedString:
        topRatedTvPage = topRatedTvPage + 1;
        topRatedTvState.value = ViewState.busy;
        await _service
            .getTvResults(resultType: resultType, page: '$topRatedTvPage')
            .then((value) {
          if (value != null) {
            topRatedTvList.addAll(
                RxList.from(value.map((e) => TvResultsModel.fromJson(e))));
            topRatedTvState.value = ViewState.retrived;

            update(['tv_result']);
          }
        });
        break;
      case onTheAirString:
        onTheAirTvPage = onTheAirTvPage + 1;
        onTheAirTvState.value = ViewState.busy;
        await _service
            .getTvResults(resultType: resultType, page: '$onTheAirTvPage')
            .then((value) {
          if (value != null) {
            onTheAirTvList.addAll(
                RxList.from(value.map((e) => TvResultsModel.fromJson(e))));
            onTheAirTvState.value = ViewState.retrived;

            update(['tv_result']);
          }
        });
        break;
      case airingTodayString:
        airingTodayTvPage = airingTodayTvPage + 1;
        airingTodayTvState.value = ViewState.busy;
        await _service
            .getTvResults(resultType: resultType, page: '$airingTodayTvPage')
            .then((value) {
          if (value != null) {
            airingTodayTvList.addAll(
                RxList.from(value.map((e) => TvResultsModel.fromJson(e))));
            airingTodayTvState.value = ViewState.retrived;

            update(['tv_result']);
          }
        });
        break;

      default:
        break;
    }
  }
}
