class TvResultsModel {
  TvResultsModel({
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    this.id,
    this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  String? backdropPath;
  DateTime? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  factory TvResultsModel.fromJson(Map<String, dynamic> json) => TvResultsModel(
        backdropPath: json['backdrop_path'] as String?,
        firstAirDate:
            json['first_air_date'] == null || json['first_air_date'] == ""
                ? null
                : DateTime.parse(json['first_air_date'] as String),
        genreIds: (json['genre_ids'] as List<dynamic>?)
            ?.map((e) => e as int)
            .toList(),
        id: json['id'] as int?,
        name: json['name'] as String?,
        originCountry: (json['origin_country'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        originalLanguage: json['original_language'] as String?,
        originalName: json['original_name'] as String?,
        overview: json['overview'] as String?,
        popularity: (json['popularity'] as num?)?.toDouble(),
        posterPath: json['poster_path'] as String?,
        voteAverage: (json['vote_average'] as num?)?.toDouble(),
        voteCount: json['vote_count'] as int?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'backdropPath': backdropPath,
        'firstAirDate': firstAirDate?.toIso8601String(),
        'genreIds': genreIds,
        'id': id,
        'name': name,
        'originCountry': originCountry,
        'originalLanguage': originalLanguage,
        'originalName': originalName,
        'overview': overview,
        'popularity': popularity,
        'posterPath': posterPath,
        'voteAverage': voteAverage,
        'voteCount': voteCount,
      };
}
