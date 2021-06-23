// import 'package:json_annotation/json_annotation.dart';

// part 'season_details_model.g.dart';

// @JsonSerializable()
import 'package:movie_app/src/models/details/common_details_models.dart';

class SeasonModel {
  SeasonModel({
    this.id,
    this.airDate,
    this.episodes,
    this.name,
    this.overview,
    this.seasonModelId,
    this.posterPath,
    this.seasonNumber,
    this.credits,
  });

  int? id;
  DateTime? airDate;
  List<Episode>? episodes;
  String? name;
  String? overview;
  int? seasonModelId;
  String? posterPath;
  int? seasonNumber;
  Credits? credits;
  factory SeasonModel.fromJson(Map<String, dynamic> json) =>
      _$SeasonModelFromJson(json);
}

// @JsonSerializable()
class Episode {
  Episode({
    this.airDate,
    this.episodeNumber,
    this.crew,
    this.guestStars,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
    this.accountState,
  });

  DateTime? airDate;
  int? episodeNumber;
  List<SeasonCrew>? crew;
  List<SeasonCrew>? guestStars;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? seasonNumber;
  String? stillPath;
  double? voteAverage;
  int? voteCount;
  AccountStae? accountState;

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
}

// @JsonSerializable()
class SeasonCrew {
  SeasonCrew({
    this.job,
    this.department,
    this.creditId,
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.character,
    this.order,
  });

  String? job;
  String? department;
  String? creditId;
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? character;
  int? order;

  factory SeasonCrew.fromJson(Map<String, dynamic> json) =>
      _$SeasonCrewFromJson(json);
}

class AccountStae {
  AccountStae({this.rated});
  dynamic rated;
}

///
///
///
///
///
///
///
///               Generated Code
///
///
///
///
///
///
///

SeasonModel _$SeasonModelFromJson(Map<String, dynamic> json) {
  return SeasonModel(
    id: json['id'] as int?,
    airDate: json['air_date'] == null
        ? null
        : DateTime.parse(json['air_date'] as String),
    episodes: json['episodes'] == null
        ? null
        : List.from((json['episodes'] as List<dynamic>?)!
            .map((e) => _$EpisodeFromJson(e))),
    name: json['name'] as String?,
    overview: json['overview'] as String?,
    seasonModelId: json['season_model_id'] as int?,
    posterPath: json['poster_path'] as String?,
    seasonNumber: json['season_number'] as int?,
    credits: json['credits'] == null
        ? null
        : Credits.fromJson((json['credits'] as Map<String, dynamic>)),
  );
}

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return Episode(
    airDate: json['air_date'] == null || json['air_date'] == ""
        ? null
        : DateTime.parse(json['air_date'] as String),
    episodeNumber: json['episode_number'] as int?,
    crew: json['crew'] == null
        ? null
        : List.from((json['crew'] as List<dynamic>?)!
            .map((e) => SeasonCrew.fromJson(e as Map<String, dynamic>))),
    guestStars: json['crew'] == null
        ? null
        : List.from((json['guest_stars'] as List<dynamic>?)!
            .map((e) => SeasonCrew.fromJson(e as Map<String, dynamic>))),
    id: json['id'] as int?,
    name: json['name'] as String?,
    overview: json['overview'] as String?,
    productionCode: json['production_code'] as String?,
    seasonNumber: json['season_number'] as int?,
    stillPath: json['still_path'] as String?,
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    voteCount: json['vote_count'] as int?,
  );
}

SeasonCrew _$SeasonCrewFromJson(Map<String, dynamic> json) {
  return SeasonCrew(
    job: json['job'] as String?,
    department: json['department'] as String?,
    creditId: json['credit_id'] as String?,
    adult: json['adult'] as bool?,
    gender: json['gender'] as int?,
    id: json['id'] as int?,
    knownForDepartment: json['known_for_department'] as String?,
    name: json['name'] as String?,
    originalName: json['original_name'] as String?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    profilePath: json['profile_path'] as String?,
    character: json['character'] as String?,
    order: json['order'] as int?,
  );
}

AccountStae accountStateFromJson(Map<String, dynamic> json) {
  return AccountStae(
      rated: json['rated'] == null ? null : ratedFromJson(json['rated']));
}
