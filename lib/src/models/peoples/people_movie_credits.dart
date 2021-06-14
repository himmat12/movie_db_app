class PeopleMovieCreditsModel {
  PeopleMovieCreditsModel({
    this.cast,
    this.id,
  });

  List<MovieCast>? cast;
  int? id;

  factory PeopleMovieCreditsModel.fromJson(Map<String, dynamic> json) =>
      _$PeopleMovieCreditsModelFromJson(json);
}

class MovieCast {
  MovieCast({
    this.adult,
    this.backdropPath,
    this.title,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.overview,
    this.releaseDate,
    this.id,
    this.popularity,
    this.character,
    this.creditId,
    this.order,
  });

  bool? adult;
  String? backdropPath;
  String? title;
  List<int>? genreIds;
  String? originalLanguage;
  String? originalTitle;
  String? posterPath;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? overview;
  String? releaseDate;
  int? id;
  double? popularity;
  String? character;
  String? creditId;
  int? order;

  factory MovieCast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
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

PeopleMovieCreditsModel _$PeopleMovieCreditsModelFromJson(
    Map<String, dynamic> json) {
  return PeopleMovieCreditsModel(
    cast: json['cast'] == null
        ? null
        : List.from(json['cast'].map((e) => MovieCast.fromJson(e))),
    id: json['id'] as int?,
  );
}

MovieCast _$CastFromJson(Map<String, dynamic> json) {
  return MovieCast(
    adult: json['adult'] as bool?,
    backdropPath: json['backdrop_path'] as String?,
    title: json['title'] as String?,
    genreIds:
        (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
    originalLanguage: json['original_language'] as String?,
    originalTitle: json['original_title'] as String?,
    posterPath: json['poster_path'] as String?,
    video: json['video'] as bool?,
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    voteCount: json['vote_count'] as int?,
    overview: json['overview'] as String?,
    releaseDate:
        json['release_date'] == null ? null : json['release_date'] as String,
    id: json['id'] as int?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    character: json['character'] as String?,
    creditId: json['credit_id'] as String?,
    order: json['order'] as int?,
  );
}
