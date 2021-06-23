import 'package:get/get.dart';
import 'package:movie_app/service_locator.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:movie_app/src/models/details/season_details_model.dart';
import 'package:movie_app/src/services/season_service.dart';

class SeasonController extends BaseController {
  final service = sl<SeasonService>();

  var seasonModel = SeasonModel().obs;
  var episodeModel = Episode().obs;

  var _seasonState = ViewState.idle.obs;
  var _episodeState = ViewState.idle.obs;

  ViewState get seasonState => _seasonState.value;
  ViewState get episodeState => _episodeState.value;

  var _tvId = 0.obs;
  var _seasonNo = 1.obs;
  var _episodeNo = 1.obs;

  int get tvId => _tvId.value;
  int get seasonNo => _seasonNo.value;
  int get episodeNo => _episodeNo.value;

  void setTvId(int tvId) => _tvId.value = tvId;
  void setSeasonNo(int seasonNo) => _seasonNo.value = seasonNo;
  void setEpisodeNo(int episodeNo) => _episodeNo.value = episodeNo;

  // get season details
  getSeasonDetails({
    required String tvId,
    required String seasonNo,
  }) async {
    _seasonState.value = ViewState.busy;
    await service
        .getSeasonDetails(tvId: tvId, seasonNo: seasonNo)
        .then((value) {
      seasonModel.value = SeasonModel.fromJson(value);
      _seasonState.value = ViewState.retrived;
      update(['season_details']);
    });
  }

  // get episode details
  getEpisodeDetails({
    required String tvId,
    required String seasonNo,
    required String episodeNo,
  }) async {
    _episodeState.value = ViewState.busy;
    await service
        .getEpisodeDetails(tvId: tvId, seasonNo: seasonNo, episodeNo: episodeNo)
        .then((value) {
      episodeModel.value = Episode.fromJson(value);
      _episodeState.value = ViewState.retrived;
      update(['episode_details']);
    });
  }

  // rate episode
  rateEpisode({
    required String tvId,
    required String seasonNo,
    required String episodeNo,
    required double ratingValue,
  }) async {
    await service.rateTvEpisode(
        tvId: tvId,
        seasonNo: seasonNo,
        episodeNo: episodeNo,
        ratingValue: ratingValue);
    update(['episode_details']);
  }

  // rate episode
  deleteEpisodeRating({
    required String tvId,
    required String seasonNo,
    required String episodeNo,
    required double ratingValue,
  }) async {
    await service.deleteTvEpisodeRating(
        tvId: tvId,
        seasonNo: seasonNo,
        episodeNo: episodeNo,
        ratingValue: ratingValue);
    update(['episode_details']);
  }
}
