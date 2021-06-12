import 'dart:convert';

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

  final _people = PeopleModel().obs;
  final _tvCredits = PeopleTvCreditsModel().obs;
  final _movieCredits = PeopleMovieCreditsModel().obs;
  final _images = <ImageModel>[].obs;
  final _externalIds = PeopleExternelIds().obs;

  final _peopleState = ViewState.idle.obs;
  final _tvCreditsState = ViewState.idle.obs;
  final _movieCreditsState = ViewState.idle.obs;
  final _imagesState = ViewState.idle.obs;
  final _externalIdsState = ViewState.idle.obs;

  getPeopleDetails({required int personId}) async {
    _peopleState.value = ViewState.busy;
    await _service.getPeopleDetails(personId: personId).then((value) {
      _people.value = PeopleModel.fromJson(value);
      _peopleState.value = ViewState.retrived;
      // ignore: avoid_print
      print(_people.value.name);
      update(['person_details']);
    });
  }

  getCreditsDetails({required int personId, required String resultType}) async {
    switch (resultType) {
      case movieCreditsString:
        _movieCreditsState.value = ViewState.busy;
        await _service
            .getCreditsDetails(personId: personId, resultType: resultType)
            .then((value) {
          _movieCredits.value = PeopleMovieCreditsModel.fromJson(value);
          // ignore: avoid_print
          print(_movieCredits.value.cast![0].originalTitle);
          _movieCreditsState.value = ViewState.retrived;
        });
        break;
      case tvCreditsString:
        _tvCreditsState.value = ViewState.busy;
        await _service
            .getCreditsDetails(personId: personId, resultType: resultType)
            .then((value) {
          _tvCredits.value = PeopleTvCreditsModel.fromJson(value);
          // ignore: avoid_print
          print(_tvCredits.value.cast![0].originalName);
          _tvCreditsState.value = ViewState.retrived;
        });
        break;
      case imagesString:
        _imagesState.value = ViewState.busy;
        await _service
            .getCreditsDetails(personId: personId, resultType: resultType)
            .then((value) {
          _images.value =
              List.from(value['profiles'].map((e) => ImageModel.fromJson(e)));
          _imagesState.value = ViewState.retrived;
        });
        break;
      case externalIdsString:
        _externalIdsState.value = ViewState.busy;
        await _service
            .getCreditsDetails(personId: personId, resultType: resultType)
            .then((value) {
          _externalIds.value = PeopleExternelIds.fromJson(value);
          _externalIdsState.value = ViewState.retrived;
        });
        break;
      default:
        break;
    }
  }
}
