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
  var movieViewState = ViewState.idle.obs;

  // movie results controller

  getMovieResults({String? page, required String resultType}) async {
    movieViewState.value = ViewState.busy;
    await _service
        .getMovieResults(resultType: resultType, page: page!)
        .then((value) {
      if (value != null) {
        movies = RxList.from(value.map((e) => MovieResultModel.fromJson(e)));
        // for (var i in movies) {
        //   // ignore: avoid_print
        //   print(i.title);
        // }
      }
    });
    movieViewState.value = ViewState.retrived;
  }

  // tv results controller

  getTvResults({String? page, required String resultType}) async {
    tvViewState.value = ViewState.busy;
    await _service
        .getTvResults(resultType: resultType, page: page!)
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
