

// TvDetailsModel _$TvDetailsModelFromJson(Map<String, dynamic> json) {
//   return TvDetailsModel(
//     backdropPath: json['backdropPath'] as String?,
//     createdBy: (json['createdBy'] as List<dynamic>?)
//         ?.map((e) => CreatedBy.fromJson(e as Map<String, dynamic>))
//         .toList(),
//     episodeRunTime: (json['episodeRunTime'] as List<dynamic>?)
//         ?.map((e) => e as int)
//         .toList(),
//     firstAirDate: json['firstAirDate'] == null
//         ? null
//         : DateTime.parse(json['firstAirDate'] as String),
//     genres: (json['genres'] as List<dynamic>?)
//         ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
//         .toList(),
//     homepage: json['homepage'] as String?,
//     id: json['id'] as int?,
//     inProduction: json['inProduction'] as bool?,
//     languages:
//         (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList(),
//     lastAirDate: json['lastAirDate'] == null
//         ? null
//         : DateTime.parse(json['lastAirDate'] as String),
//     lastEpisodeToAir: json['lastEpisodeToAir'] == null
//         ? null
//         : EpisodeToAir.fromJson(
//             json['lastEpisodeToAir'] as Map<String, dynamic>),
//     name: json['name'] as String?,
//     nextEpisodeToAir: json['nextEpisodeToAir'] == null
//         ? null
//         : EpisodeToAir.fromJson(
//             json['nextEpisodeToAir'] as Map<String, dynamic>),
//     networks: (json['networks'] as List<dynamic>?)
//         ?.map((e) => Network.fromJson(e as Map<String, dynamic>))
//         .toList(),
//     numberOfEpisodes: json['numberOfEpisodes'] as int?,
//     numberOfSeasons: json['numberOfSeasons'] as int?,
//     originCountry: (json['originCountry'] as List<dynamic>?)
//         ?.map((e) => e as String)
//         .toList(),
//     originalLanguage: json['originalLanguage'] as String?,
//     originalName: json['originalName'] as String?,
//     overview: json['overview'] as String?,
//     popularity: (json['popularity'] as num?)?.toDouble(),
//     posterPath: json['posterPath'] as String?,
//     productionCompanies: json['productionCompanies'] as List<dynamic>?,
//     productionCountries: json['productionCountries'] as List<dynamic>?,
//     seasons: (json['seasons'] as List<dynamic>?)
//         ?.map((e) => Season.fromJson(e as Map<String, dynamic>))
//         .toList(),
//     spokenLanguages: (json['spokenLanguages'] as List<dynamic>?)
//         ?.map((e) => e as String)
//         .toList(),
//     status: json['status'] as String?,
//     tagline: json['tagline'] as String?,
//     type: json['type'] as String?,
//     voteAverage: (json['voteAverage'] as num?)?.toDouble(),
//     voteCount: json['voteCount'] as int?,
//     images: json['images'] == null
//         ? null
//         : Images.fromJson(json['images'] as Map<String, dynamic>),
//     videos: json['videos'] == null
//         ? null
//         : Videos.fromJson(json['videos'] as Map<String, dynamic>),
//     credits: json['credits'] == null
//         ? null
//         : Credits.fromJson(json['credits'] as Map<String, dynamic>),
//     accountStates: json['accountStates'] == null
//         ? null
//         : AccountStates.fromJson(json['accountStates'] as Map<String, dynamic>),
//     similar: json['similar'] == null
//         ? null
//         : Recommendations.fromJson(json['similar'] as Map<String, dynamic>),
//     recommendations: json['recommendations'] == null
//         ? null
//         : Recommendations.fromJson(
//             json['recommendations'] as Map<String, dynamic>),
//     reviews: json['reviews'] == null
//         ? null
//         : Recommendations.fromJson(json['reviews'] as Map<String, dynamic>),
//     externalIds: json['externalIds'] == null
//         ? null
//         : _$ExternalIdsFromJson(json['externalIds'] as Map<String, dynamic>),
//   );
// }


// CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) {
//   return CreatedBy(
//     id: json['id'] as int?,
//     creditId: json['creditId'] as String?,
//     name: json['name'] as String?,
//     gender: json['gender'] as int?,
//     profilePath: json['profilePath'] as String?,
//   );
// }


// ExternalIds _$ExternalIdsFromJson(Map<String, dynamic> json) {
//   return ExternalIds(
//     imdbId: json['imdbId'] as String?,
//     freebaseMid: json['freebaseMid'] as String?,
//     freebaseId: json['freebaseId'] as String?,
//     tvdbId: json['tvdbId'] as int?,
//     tvrageId: json['tvrageId'] as String?,
//     facebookId: json['facebookId'] as String?,
//     instagramId: json['instagramId'] as String?,
//     twitterId: json['twitterId'] as String?,
//   );
// }


// Network _$NetworkFromJson(Map<String, dynamic> json) {
//   return Network(
//     name: json['name'] as String?,
//     id: json['id'] as int?,
//     logoPath: json['logoPath'] as String?,
//     originCountry: json['originCountry'] as String?,
//   );
// }


// Season _$SeasonFromJson(Map<String, dynamic> json) {
//   return Season(
//     airDate: json['airDate'] == null
//         ? null
//         : DateTime.parse(json['airDate'] as String),
//     episodeCount: json['episodeCount'] as int?,
//     id: json['id'] as int?,
//     name: json['name'] as String?,
//     overview: json['overview'] as String?,
//     posterPath: json['posterPath'] as String?,
//     seasonNumber: json['seasonNumber'] as int?,
//   );
// }

