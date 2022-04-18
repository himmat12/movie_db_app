import '../results/tv_result_model.dart';
import 'common_details_models.dart';

// part 'test.g.dart';

// @JsonSerializable()
class TvDetailsModel {
  TvDetailsModel({
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
    this.images,
    this.videos,
    this.credits,
    this.accountStates,
    this.similar,
    this.recommendations,
    this.reviews,
    this.externalIds,
  });

  String? backdropPath;
  List<CreatedBy>? createdBy;
  List<int>? episodeRunTime;
  DateTime? firstAirDate;
  List<Genre>? genres;
  String? homepage;
  int? id;
  bool? inProduction;
  List<String>? languages;
  DateTime? lastAirDate;
  EpisodeToAir? lastEpisodeToAir;
  String? name;
  EpisodeToAir? nextEpisodeToAir;
  List<Network>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompany>? productionCompanies;
  List<ProductionCountry>? productionCountries;
  List<Season>? seasons;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;
  Images? images;
  Videos? videos;
  Credits? credits;
  AccountStates? accountStates;
  SimilarTv? similar;
  TvRecommendations? recommendations;
  Reviews? reviews;
  TvExternalIds? externalIds;

  factory TvDetailsModel.fromJson(Map<String, dynamic> json) =>
      tvDetailsModelFromJson(json);
}

// @JsonSerializable()
class CreatedBy {
  CreatedBy({
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });

  int? id;
  String? creditId;
  String? name;
  int? gender;
  String? profilePath;

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      createdByFromJson(json);
}

// @JsonSerializable()
class TvExternalIds {
  TvExternalIds({
    this.imdbId,
    this.freebaseMid,
    this.freebaseId,
    this.tvdbId,
    this.tvrageId,
    this.facebookId,
    this.instagramId,
    this.twitterId,
  });

  String? imdbId;
  String? freebaseMid;
  String? freebaseId;
  int? tvdbId;
  int? tvrageId; //bug fixed*
  String? facebookId;
  String? instagramId;
  String? twitterId;

  factory TvExternalIds.fromJson(Map<String, dynamic> json) =>
      externalIdsFromJson(json);
}

// @JsonSerializable()
class EpisodeToAir {
  EpisodeToAir({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  DateTime? airDate;
  int? episodeNumber;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? seasonNumber;
  String? stillPath;
  double? voteAverage;
  int? voteCount;

  factory EpisodeToAir.fromJson(Map<String, dynamic> json) =>
      episodeToAirFromJson(json);
}

// @JsonSerializable()
class Network {
  Network({
    this.name,
    this.id,
    this.logoPath,
    this.originCountry,
  });

  String? name;
  int? id;
  String? logoPath;
  String? originCountry;

  factory Network.fromJson(Map<String, dynamic> json) => networkFromJson(json);
}

// @JsonSerializable()
class Season {
  Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });

  DateTime? airDate;
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;

  factory Season.fromJson(Map<String, dynamic> json) => seasonFromJson(json);
}

// @JsonSerializable()
class SimilarTv {
  SimilarTv({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<TvResultsModel>? results;
  int? totalPages;
  int? totalResults;

  factory SimilarTv.fromJson(Map<String, dynamic> json) =>
      similarFromJson(json);
}

// @JsonSerializable()
class TvRecommendations {
  TvRecommendations({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<TvResultsModel>? results;
  int? totalPages;
  int? totalResults;

  factory TvRecommendations.fromJson(Map<String, dynamic> json) =>
      recommendationsFromJson(json);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///                                      Generated code
///
///
///
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////\

TvDetailsModel tvDetailsModelFromJson(Map<String, dynamic> json) {
  return TvDetailsModel(
    backdropPath: json['backdrop_path'] as String?,
    createdBy: json['created_by'] == null
        ? null
        : List.from((json['created_by'] as List<dynamic>)
            .map((e) => createdByFromJson(e as Map<String, dynamic>))),
    episodeRunTime: (json['episode_run_time'] as List<dynamic>?)
        ?.map((e) => e as int)
        .toList(),
    firstAirDate: json['first_air_date'] == null
        ? null
        : DateTime.parse(json['first_air_date'] as String),
    genres: (json['genres'] as List<dynamic>?)
        ?.map((e) => genreFromJson(e as Map<String, dynamic>))
        .toList(),
    homepage: json['homepage'] as String?,
    id: json['id'] as int?,
    inProduction: json['in_production'] as bool?,
    languages:
        (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList(),
    lastAirDate: json['last_air_date'] == null
        ? null
        : DateTime.parse(json['last_air_date'] as String),
    lastEpisodeToAir: json['last_episode_to_air'] == null
        ? null
        : episodeToAirFromJson(
            json['last_episode_to_air'] as Map<String, dynamic>),
    name: json['name'] as String?,
    nextEpisodeToAir: json['next_episode_to_air'] == null
        ? null
        : episodeToAirFromJson(
            json['next_episode_to_air'] as Map<String, dynamic>),
    networks: json['networks'] == null
        ? null
        : List.from((json['networks'] as List<dynamic>)
            .map((e) => networkFromJson(e as Map<String, dynamic>))),
    numberOfEpisodes: json['number_of_episodes'] as int?,
    numberOfSeasons: json['number_of_seasons'] as int?,
    originCountry: (json['origin_country'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    originalLanguage: json['original_language'] as String?,
    originalName: json['original_name'] as String?,
    overview: json['overview'] as String?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    posterPath: json['poster_path'] as String?,
    productionCompanies: json['production_companies'] == null
        ? null
        : List.from((json['production_companies'] as List<dynamic>)
            .map((e) => productionCompanyFromJson(e as Map<String, dynamic>))),
    productionCountries: json['production_countries'] == null
        ? null
        : List.from((json['production_countries'] as List<dynamic>)
            .map((e) => productionCountryFromJson(e as Map<String, dynamic>))),
    seasons: json['seasons'] == null
        ? null
        : List.from((json['seasons'] as List<dynamic>)
            .map((e) => seasonFromJson(e as Map<String, dynamic>))),
    spokenLanguages: json['spoken_languages'] == null
        ? null
        : List.from((json['spoken_languages'] as List<dynamic>)
            .map((e) => spokenLanguageFromJson(e as Map<String, dynamic>))),
    status: json['status'] as String?,
    tagline: json['tagline'] as String?,
    type: json['type'] as String?,
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    voteCount: json['vote_count'] as int?,
    images: json['images'] == null
        ? null
        : imagesFromJson(json['images'] as Map<String, dynamic>),
    videos: json['videos'] == null
        ? null
        : videosFromJson(json['videos'] as Map<String, dynamic>),
    credits: json['credits'] == null
        ? null
        : creditsFromJson(json['credits'] as Map<String, dynamic>),
    accountStates: json['account_states'] == null
        ? null
        : accountStatesFromJson(json['account_states'] as Map<String, dynamic>),
    similar: json['similar'] == null
        ? null
        : similarFromJson(json['similar'] as Map<String, dynamic>),
    recommendations: json['recommendations'] == null
        ? null
        : recommendationsFromJson(
            json['recommendations'] as Map<String, dynamic>),
    reviews: json['reviews'] == null
        ? null
        : reviewsFromJson(json['reviews'] as Map<String, dynamic>),
    externalIds: json['external_ids'] == null
        ? null
        : externalIdsFromJson(json['external_ids'] as Map<String, dynamic>),
  );
}

EpisodeToAir episodeToAirFromJson(Map<String, dynamic> json) {
  return EpisodeToAir(
    airDate: json['air_date'] == null
        ? null
        : DateTime.parse(json['air_date'] as String),
    episodeNumber: json['episode_number'] as int?,
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

CreatedBy createdByFromJson(Map<String, dynamic> json) {
  return CreatedBy(
    id: json['id'] as int?,
    creditId: json['credit_d'] as String?,
    name: json['name'] as String?,
    gender: json['gender'] as int?,
    profilePath: json['profile_path'] as String?,
  );
}

TvExternalIds externalIdsFromJson(Map<String, dynamic> json) {
  return TvExternalIds(
    imdbId: json['imdb_id'] as String?,
    freebaseMid: json['freebase_mid'] as String?,
    freebaseId: json['freebase_id'] as String?,
    tvdbId: json['tvdb_id'] as int?,
    tvrageId: json['tvrage_id'] as int?,
    facebookId: json['facebook_id'] as String?,
    instagramId: json['instagram_id'] as String?,
    twitterId: json['twitter_id'] as String?,
  );
}

Network networkFromJson(Map<String, dynamic> json) {
  return Network(
    name: json['name'] as String?,
    id: json['id'] as int?,
    logoPath: json['logo_path'] as String?,
    originCountry: json['origin_country'] as String?,
  );
}

Season seasonFromJson(Map<String, dynamic> json) {
  return Season(
    airDate: json['air_date'] == null
        ? null
        : DateTime.parse(json['air_date'] as String),
    episodeCount: json['episode_count'] as int?,
    id: json['id'] as int?,
    name: json['name'] as String?,
    overview: json['overview'] as String?,
    posterPath: json['poster_path'] as String?,
    seasonNumber: json['season_number'] as int?,
  );
}

SimilarTv similarFromJson(Map<String, dynamic> json) {
  return SimilarTv(
    page: json['page'] as int?,
    results: json['results'] == null
        ? null
        : List.from((json['results'] as List<dynamic>)
            .map((e) => TvResultsModel.fromJson(e as Map<String, dynamic>))),
    totalPages: json['total_pages'] as int?,
    totalResults: json['total_results'] as int?,
  );
}

TvRecommendations recommendationsFromJson(Map<String, dynamic> json) {
  return TvRecommendations(
    page: json['page'] as int?,
    results: json['results'] == null
        ? null
        : List.from((json['results'] as List<dynamic>)
            .map((e) => TvResultsModel.fromJson(e as Map<String, dynamic>))),
    totalPages: json['total_pages'] as int?,
    totalResults: json['total_results'] as int?,
  );
}
