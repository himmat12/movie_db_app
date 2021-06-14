class PeopleTvCreditsModel {
  PeopleTvCreditsModel({
    this.cast,
    this.id,
  });

  List<TvCast>? cast;
  int? id;

  factory PeopleTvCreditsModel.fromJson(Map<String, dynamic> json) =>
      _$PeopleTvCreditsModelFromJson(json);
}

class TvCast {
  TvCast({
    this.originalName,
    this.genreIds,
    this.originalLanguage,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
    this.overview,
    this.id,
    this.backdropPath,
    this.name,
    this.originCountry,
    this.firstAirDate,
    this.popularity,
    this.character,
    this.creditId,
    this.episodeCount,
  });

  String? originalName;
  List<int>? genreIds;
  String? originalLanguage;
  String? posterPath;
  double? voteAverage;
  int? voteCount;
  String? overview;
  int? id;
  String? backdropPath;
  String? name;
  List<String>? originCountry;
  String? firstAirDate;
  double? popularity;
  String? character;
  String? creditId;
  int? episodeCount;

  factory TvCast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///                                    generated code
///
///
///
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

PeopleTvCreditsModel _$PeopleTvCreditsModelFromJson(Map<String, dynamic> json) {
  return PeopleTvCreditsModel(
    cast: json['cast'] == null
        ? null
        : List.from(json['cast'].map((e) => TvCast.fromJson(e))),
    id: json['id'] as int?,
  );
}

TvCast _$CastFromJson(Map<String, dynamic> json) {
  return TvCast(
    originalName: json['original_name'] as String?,
    genreIds:
        (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
    originalLanguage: json['original_language'] as String?,
    posterPath: json['poster_path'] as String?,
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    voteCount: json['vote_count'] as int?,
    overview: json['overview'] as String?,
    id: json['id'] as int?,
    backdropPath: json['backdrop_path'] as String?,
    name: json['name'] as String?,
    originCountry: (json['origin_country'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    firstAirDate: json['first_air_date'] == null
        ? null
        : json['first_air_date'] as String,
    popularity: (json['popularity'] as num?)?.toDouble(),
    character: json['character'] as String?,
    creditId: json['credit_id'] as String?,
    episodeCount: json['episode_count'] as int?,
  );
}
