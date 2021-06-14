class PeopleModel {
  PeopleModel({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  bool? adult;
  List<String>? alsoKnownAs;
  String? biography;
  String? birthday;
  dynamic deathday;
  int? gender;
  dynamic homepage;
  int? id;
  String? imdbId;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  double? popularity;
  String? profilePath;

  factory PeopleModel.fromJson(Map<String, dynamic> json) =>
      _$PeopleModelFromJson(json);
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

PeopleModel _$PeopleModelFromJson(Map<String, dynamic> json) {
  return PeopleModel(
    adult: json['adult'] as bool?,
    alsoKnownAs: (json['also_known_as'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    biography: json['biography'] as String?,
    birthday: json['birthday'] as String?,
    deathday: json['deathday'] as String?,
    gender: json['gender'] as int?,
    homepage: json['homepage'],
    id: json['id'] as int?,
    imdbId: json['imdb_id'] as String?,
    knownForDepartment: json['known_for_department'] as String?,
    name: json['name'] as String?,
    placeOfBirth: json['place_of_birth'] as String?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    profilePath: json['profile_path'] as String?,
  );
}
