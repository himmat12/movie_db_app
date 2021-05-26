import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/mixins/query_parameter_mixin.dart';
import 'package:movie_app/src/models/movie_model.dart';
import 'package:movie_app/src/services/popular_movies_service.dart';

class PopularMoviesController extends BaseController with QueryParameterMixin {
  final _service = sl<PopularMoviesService>();
  var popularMovies = <MovieModel>[].obs;
  var viewState = ViewState.idle.obs;
  String page = "9";

  getPopularMovies({String? page}) async {
    viewState.value = ViewState.busy;
    await _service.getPopularMovies(page: page).then((value) {
      if (value != null) {
        popularMovies = RxList.from(value.map((e) => MovieModel.fromJson(e)));
        for (var i in popularMovies) {
          // ignore: avoid_print
          print(i.title);
        }
      }
    });
    viewState.value = ViewState.retrived;
  }
}
