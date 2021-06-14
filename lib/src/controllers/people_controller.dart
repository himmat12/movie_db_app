import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/models/details/common_details_models.dart';
import 'package:movie_app/src/models/peoples/people_external_ids.dart';
import 'package:movie_app/src/models/peoples/people_model.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/models/peoples/people_movie_credits.dart';
import 'package:movie_app/src/models/peoples/people_tv_credits.dart';
import 'package:movie_app/src/services/people_service.dart';

import '../../service_locator.dart';

class PeopleController extends BaseController {
  final _service = sl<PeopleService>();

  var _personId = 0.obs;

  int get personId => _personId.value;

  void setPersonId(int id) => _personId.value = id;

  final _movie = MovieCast().obs;
  final _tv = TvCast().obs;

  MovieCast get movie => _movie.value;
  TvCast get tv => _tv.value;

  void setMovie(MovieCast movie) {
    _movie.value = movie;
    update();
  }

  void setTv(TvCast tv) {
    _tv.value = tv;
    update();
  }

  final people = PeopleModel().obs;
  final tvCredits = PeopleTvCreditsModel().obs;
  final movieCredits = PeopleMovieCreditsModel().obs;
  final images = <ImageModel>[].obs;
  final externalIds = PeopleExternelIds().obs;

  final peopleState = ViewState.idle.obs;
  final tvCreditsState = ViewState.idle.obs;
  final movieCreditsState = ViewState.idle.obs;
  final imagesState = ViewState.idle.obs;
  final externalIdsState = ViewState.idle.obs;

  getPeopleDetails({required int personId}) async {
    peopleState.value = ViewState.busy;
    await _service.getPeopleDetails(personId: personId).then((value) {
      people.value = PeopleModel.fromJson(value);
      peopleState.value = ViewState.retrived;
      // ignore: avoid_print
      print(people.value.name);
      update(['people_details']);
    });
  }

  getCreditsDetails({required int personId, required String resultType}) async {
    switch (resultType) {
      case movieCreditsString:
        movieCreditsState.value = ViewState.busy;
        await _service
            .getCreditsDetails(personId: personId, resultType: resultType)
            .then((value) {
          movieCredits.value = PeopleMovieCreditsModel.fromJson(value);
          // ignore: avoid_print
          print(movieCredits.value.cast![0].originalTitle);
          movieCreditsState.value = ViewState.retrived;
          update(['people_movies']);
        });
        break;
      case tvCreditsString:
        tvCreditsState.value = ViewState.busy;
        await _service
            .getCreditsDetails(personId: personId, resultType: resultType)
            .then((value) {
          tvCredits.value = PeopleTvCreditsModel.fromJson(value);
          // ignore: avoid_print
          print(tvCredits.value.cast![0].originalName);
          tvCreditsState.value = ViewState.retrived;
        });
        break;
      case imagesString:
        imagesState.value = ViewState.busy;
        await _service
            .getCreditsDetails(personId: personId, resultType: resultType)
            .then((value) {
          images.value =
              List.from(value['profiles'].map((e) => ImageModel.fromJson(e)));
          imagesState.value = ViewState.retrived;
          update(['people_images']);
        });
        break;
      case externalIdsString:
        externalIdsState.value = ViewState.busy;
        await _service
            .getCreditsDetails(personId: personId, resultType: resultType)
            .then((value) {
          externalIds.value = PeopleExternelIds.fromJson(value);
          externalIdsState.value = ViewState.retrived;
        });
        break;
      default:
        break;
    }
  }
}
