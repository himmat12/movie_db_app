// import 'package:json_annotation/json_annotation.dart';

import 'package:movie_app/src/models/results/movie_result_model.dart';

import 'common_details_models.dart';

// part 'movie_details_model.g.dart';

// @JsonSerializable()
class MovieDetailsModel {
  MovieDetailsModel({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.images,
    this.videos,
    this.credits,
    this.accountStates,
    this.externalIds,
    this.recommendations,
    this.similar,
    this.reviews,
  });

  bool? adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int? budget;
  List<Genre>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompany>? productionCompanies;
  List<ProductionCountry>? productionCountries;
  DateTime? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  Images? images;
  Videos? videos;
  Credits? credits;
  AccountStates? accountStates;
  Similar? similar;
  Recommendations? recommendations;
  Reviews? reviews;
  ExternalIds? externalIds;

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      movieDetailsModelFromJson(json);
}

// @JsonSerializable()
class BelongsToCollection {
  BelongsToCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      belongsToCollectionFromJson(json);
}

// @JsonSerializable()
class ExternalIds {
  ExternalIds({
    this.imdbId,
    this.facebookId,
    this.instagramId,
    this.twitterId,
  });

  String? imdbId;
  String? facebookId;
  String? instagramId;
  String? twitterId;

  factory ExternalIds.fromJson(Map<String, dynamic> json) =>
      externalIdsFromJson(json);
}

// @JsonSerializable()
class Similar {
  Similar({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<MovieResultModel>? results;
  int? totalPages;
  int? totalResults;

  factory Similar.fromJson(Map<String, dynamic> json) => similarFromJson(json);
}

// @JsonSerializable()
class Recommendations {
  Recommendations({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<MovieResultModel>? results;
  int? totalPages;
  int? totalResults;
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

MovieDetailsModel movieDetailsModelFromJson(Map<String, dynamic> json) {
  return MovieDetailsModel(
    adult: json['adult'] as bool?,
    backdropPath: json['backdrop_path'] as String?,
    belongsToCollection: json['belongs_to_collection'] == null
        ? null
        : belongsToCollectionFromJson(
            json['belongs_to_collection'] as Map<String, dynamic>),
    budget: json['budget'] as int?,
    genres: json['genres'] == null
        ? null
        : List.from((json['genres'] as List<dynamic>)
            .map((e) => genreFromJson(e as Map<String, dynamic>))),
    homepage: json['homepage'] as String?,
    id: json['id'] as int?,
    imdbId: json['imdb_id'] as String?,
    originalLanguage: json['original_language'] as String?,
    originalTitle: json['original_title'] as String?,
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
    releaseDate: json['release_date'] == null
        ? null
        : json['release_date'] == ""
            ? null
            : DateTime.parse(json['release_date'] as String),
    revenue: json['revenue'] as int?,
    runtime: json['runtime'] as int?,
    spokenLanguages: json['spoken_languages'] == null
        ? null
        : List.from((json['spoken_languages'] as List<dynamic>)
            .map((e) => spokenLanguageFromJson(e as Map<String, dynamic>))),
    status: json['status'] as String?,
    tagline: json['tagline'] as String?,
    title: json['title'] as String?,
    video: json['video'] as bool?,
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
    externalIds: json['external_ids'] == null
        ? null
        : externalIdsFromJson(json['external_ids'] as Map<String, dynamic>),
    recommendations: json['recommendations'] == null
        ? null
        : recommendationsFromJson(
            json['recommendations'] as Map<String, dynamic>),
    reviews: json['reviews'] == null
        ? null
        : reviewsFromJson(json['reviews'] as Map<String, dynamic>),
    similar: json['similar'] == null
        ? null
        : similarFromJson(json['similar'] as Map<String, dynamic>),
  );
}

BelongsToCollection belongsToCollectionFromJson(Map<String, dynamic> json) {
  return BelongsToCollection(
    id: json['id'] as int?,
    name: json['name'] as String?,
    posterPath: json['poster_path'] as String?,
    backdropPath: json['backdrop_path'] as String?,
  );
}

ExternalIds externalIdsFromJson(Map<String, dynamic> json) {
  return ExternalIds(
    imdbId: json['imdb_id'] as String?,
    facebookId: json['facebook_id'] as String?,
    instagramId: json['instagram_id'] as String?,
    twitterId: json['twitter_id'] as String?,
  );
}

Similar similarFromJson(Map<String, dynamic> json) {
  return Similar(
    page: json['page'] as int?,
    results: json['results'] == null
        ? null
        : List.from((json['results'] as List<dynamic>)
            .map((e) => MovieResultModel.fromJson(e as Map<String, dynamic>))),
    totalPages: json['total_pages'] as int?,
    totalResults: json['total_results'] as int?,
  );
}

Recommendations recommendationsFromJson(Map<String, dynamic> json) {
  return Recommendations(
    page: json['page'] as int?,
    results: json['results'] == null
        ? null
        : List.from((json['results'] as List<dynamic>)
            .map((e) => MovieResultModel.fromJson(e as Map<String, dynamic>))),
    totalPages: json['total_pages'] as int?,
    totalResults: json['total_results'] as int?,
  );
}
