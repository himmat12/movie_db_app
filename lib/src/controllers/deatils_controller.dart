import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/models/details/movie_details_model.dart';
import 'package:movie_app/src/models/details/tv_details_model.dart';
import 'package:movie_app/src/services/details_service.dart';
import 'package:get/get.dart';

class DetailsController extends BaseController {
  final _service = sl<DetailsService>();

  var movieDetailState = ViewState.idle.obs;
  var tvDetailState = ViewState.idle.obs;

  var movieDetail = MovieDetailsModel().obs;
  var tvDetail = TvDetailsModel().obs;

  getDetails({required String resultType, required int id}) async {
    switch (resultType) {
      case MOVIE_STRING:
        movieDetailState.value = ViewState.busy;
        await _service.getDetails(resultType: resultType, id: id).then((value) {
          if (value != null) {
            movieDetail.value = MovieDetailsModel.fromJson(value);
            // ignore: avoid_print
            print('${movieDetail.value.title} MOVIE DETAILS');
          }
        });
        movieDetailState.value = ViewState.retrived;
        break;

      case TV_STRING:
        tvDetailState.value = ViewState.busy;
        await _service.getDetails(resultType: resultType, id: id).then((value) {
          if (value != null) {
            tvDetail.value = TvDetailsModel.fromJson(value);
            // ignore: avoid_print
            print('${tvDetail.value.name} TV DETAILS');
          }
        });
        tvDetailState.value = ViewState.retrived;
        break;
      default:
        break;
    }
  }
}
