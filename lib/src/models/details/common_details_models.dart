// @JsonSerializable()*
class Genre {
  Genre({
    this.id,
    this.name,
  });

  int? id;
  String? name;
  factory Genre.fromJson(Map<String, dynamic> json) => genreFromJson(json);
}

// @JsonSerializable()*
class Images {
  Images({
    this.backdrops,
    this.posters,
  });

  List<ImageModel>? backdrops;
  List<ImageModel>? posters;
  factory Images.fromJson(Map<String, dynamic> json) => imagesFromJson(json);
}

// @JsonSerializable()*
class ImageModel {
  ImageModel({
    this.aspectRatio,
    this.filePath,
    this.height,
    this.iso6391,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  double? aspectRatio;
  String? filePath;
  int? height;
  String? iso6391;
  double? voteAverage;
  int? voteCount;
  int? width;

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      imageModelFromJson(json);
}

// @JsonSerializable()*
class ProductionCompany {
  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      productionCompanyFromJson(json);
}

// @JsonSerializable()*
class ProductionCountry {
  ProductionCountry({
    this.iso31661,
    this.name,
  });

  String? iso31661;
  String? name;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      productionCountryFromJson(json);
}

// @JsonSerializable()*
class SpokenLanguage {
  SpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });

  String? englishName;
  String? iso6391;
  String? name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      spokenLanguageFromJson(json);
}

// @JsonSerializable()*
class Videos {
  Videos({
    this.results,
  });

  List<VideoModel>? results;

  factory Videos.fromJson(Map<String, dynamic> json) => videosFromJson(json);
}

// @JsonSerializable()*
class VideoModel {
  VideoModel({
    this.id,
    this.iso6391,
    this.iso31661,
    this.key,
    this.name,
    this.site,
    this.size,
    this.type,
  });

  String? id;
  String? iso6391;
  String? iso31661;
  String? key;
  String? name;
  String? site;
  int? size;
  String? type;

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      videoModelFromJson(json);
}

// @JsonSerializable()*
class Credits {
  Credits({
    this.cast,
    this.crew,
  });

  List<Cast>? cast;
  List<Crew>? crew;

  factory Credits.fromJson(Map<String, dynamic> json) => creditsFromJson(json);
}

// @JsonSerializable()*
class Cast {
  Cast({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;

  factory Cast.fromJson(Map<String, dynamic> json) => castFromJson(json);
}

// @JsonSerializable()*
class Crew {
  Crew({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.creditId,
    this.department,
    this.job,
  });

  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? creditId;
  String? department;
  String? job;

  factory Crew.fromJson(Map<String, dynamic> json) => crewFromJson(json);
}

// @JsonSerializable()*
class AccountStates {
  AccountStates({
    this.favorite,
    this.rated,
    this.watchlist,
  });

  bool? favorite;
  dynamic rated; //bug*
  bool? watchlist;

  factory AccountStates.fromJson(Map<String, dynamic> json) =>
      accountStatesFromJson(json);
}

// @JsonSerializable()*
class Rated {
  Rated({
    this.value,
  });

  dynamic value;
  factory Rated.fromJson(Map<String, dynamic> json) => ratedFromJson(json);
}

// @JsonSerializable()*
class Reviews {
  Reviews({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<ReviewsResult>? results;
  int? totalPages;
  int? totalResults;

  factory Reviews.fromJson(Map<String, dynamic> json) => reviewsFromJson(json);
}

// @JsonSerializable()*
class ReviewsResult {
  ReviewsResult({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  String? author;
  AuthorDetails? authorDetails;
  String? content;
  DateTime? createdAt;
  String? id;
  DateTime? updatedAt;
  String? url;

  factory ReviewsResult.fromJson(Map<String, dynamic> json) =>
      reviewsResultFromJson(json);
}

// @JsonSerializable()
class AuthorDetails {
  AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  String? name;
  String? username;
  String? avatarPath;
  double? rating;

  factory AuthorDetails.fromJson(Map<String, dynamic> json) =>
      authorDetailsFromJson(json);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///                                         Generated code
///
///
///
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Genre genreFromJson(Map<String, dynamic> json) {
  return Genre(
    id: json['id'] as int?,
    name: json['name'] as String?,
  );
}

Images imagesFromJson(Map<String, dynamic> json) {
  return Images(
    backdrops: json['backdrops'] == null
        ? null
        : List.from((json['backdrops'] as List<dynamic>)
            .map((e) => imageModelFromJson(e as Map<String, dynamic>))),
    posters: json['posters'] == null
        ? null
        : List.from((json['posters'] as List<dynamic>)
            .map((e) => imageModelFromJson(e as Map<String, dynamic>))),
  );
}

ImageModel imageModelFromJson(Map<String, dynamic> json) {
  return ImageModel(
    aspectRatio: (json['aspect_ratio'] as num?)?.toDouble(),
    filePath: json['file_path'] as String?,
    height: json['height'] as int?,
    iso6391: json['iso_639_1'] as String?,
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    voteCount: json['vote_count'] as int?,
    width: json['width'] as int?,
  );
}

ProductionCompany productionCompanyFromJson(Map<String, dynamic> json) {
  return ProductionCompany(
    id: json['id'] as int?,
    logoPath: json['logo_path'] as String?,
    name: json['name'] as String?,
    originCountry: json['origin_country'] as String?,
  );
}

ProductionCountry productionCountryFromJson(Map<String, dynamic> json) {
  return ProductionCountry(
    iso31661: json['iso_3166_1'] as String?,
    name: json['name'] as String?,
  );
}

SpokenLanguage spokenLanguageFromJson(Map<String, dynamic> json) {
  return SpokenLanguage(
    englishName: json['english_name'] as String?,
    iso6391: json['iso_639_1'] as String?,
    name: json['name'] as String?,
  );
}

Videos videosFromJson(Map<String, dynamic> json) {
  return Videos(
    results: json['results'] == null
        ? null
        : List.from((json['results'] as List<dynamic>)
            .map((e) => videoModelFromJson(e as Map<String, dynamic>))),
  );
}

VideoModel videoModelFromJson(Map<String, dynamic> json) {
  return VideoModel(
    id: json['id'] as String?,
    iso6391: json['iso_639_1'] as String?,
    iso31661: json['iso_3166_1'] as String?,
    key: json['key'] as String?,
    name: json['name'] as String?,
    site: json['site'] as String?,
    size: json['size'] as int?,
    type: json['type'] as String?,
  );
}

Credits creditsFromJson(Map<String, dynamic> json) {
  return Credits(
    cast: json['cast'] == null
        ? null
        : List.from((json['cast'] as List<dynamic>)
            .map((e) => castFromJson(e as Map<String, dynamic>))),
    crew: json['crew'] == null
        ? null
        : List.from((json['crew'] as List<dynamic>)
            .map((e) => crewFromJson(e as Map<String, dynamic>))),
  );
}

Cast castFromJson(Map<String, dynamic> json) {
  return Cast(
    adult: json['adult'] as bool?,
    gender: json['gender'] as int?,
    id: json['id'] as int?,
    knownForDepartment: json['known_for_department'] as String?,
    name: json['name'] as String?,
    originalName: json['original_name'] as String?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    profilePath: json['profile_path'] as String?,
    castId: json['cast_id'] as int?,
    character: json['character'] as String?,
    creditId: json['credit_id'] as String?,
    order: json['order'] as int?,
  );
}

Crew crewFromJson(Map<String, dynamic> json) {
  return Crew(
    adult: json['adult'] as bool?,
    gender: json['gender'] as int?,
    id: json['id'] as int?,
    knownForDepartment: json['known_for_department'] as String?,
    name: json['name'] as String?,
    originalName: json['original_name'] as String?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    profilePath: json['profile_path'] as String?,
    creditId: json['credit_id'] as String?,
    department: json['department'] as String?,
    job: json['job'] as String?,
  );
}

AccountStates accountStatesFromJson(Map<String, dynamic> json) {
  return AccountStates(
    favorite: json['favorite'] as bool?,
    rated: json['rated'],
    watchlist: json['watchlist'] as bool?,
  );
}

Rated ratedFromJson(Map<String, dynamic> json) {
  return Rated(value: json['value']);
}

Reviews reviewsFromJson(Map<String, dynamic> json) {
  return Reviews(
    page: json['page'] as int?,
    results: json['results'] == null
        ? null
        : List.from((json['results'] as List<dynamic>)
            .map((e) => reviewsResultFromJson(e as Map<String, dynamic>))),
    totalPages: json['total_pages'] as int?,
    totalResults: json['total_results'] as int?,
  );
}

ReviewsResult reviewsResultFromJson(Map<String, dynamic> json) {
  return ReviewsResult(
    author: json['author'] as String?,
    authorDetails: json['author_details'] == null
        ? null
        : authorDetailsFromJson(json['author_details'] as Map<String, dynamic>),
    content: json['content'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    id: json['id'] as String?,
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    url: json['url'] as String?,
  );
}

AuthorDetails authorDetailsFromJson(Map<String, dynamic> json) {
  return AuthorDetails(
    name: json['name'] as String?,
    username: json['username'] as String?,
    avatarPath: json['avatar_path'] as String?,
    rating: (json['rating'] as num?)?.toDouble(),
  );
}
