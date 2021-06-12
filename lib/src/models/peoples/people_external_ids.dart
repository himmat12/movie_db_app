class PeopleExternelIds {
  PeopleExternelIds({
    this.id,
    this.freebaseMid,
    this.freebaseId,
    this.imdbId,
    this.tvrageId,
    this.facebookId,
    this.instagramId,
    this.twitterId,
  });

  int? id;
  String? freebaseMid;
  String? freebaseId;
  String? imdbId;
  int? tvrageId;
  String? facebookId;
  String? instagramId;
  String? twitterId;

  factory PeopleExternelIds.fromJson(Map<String, dynamic> json) =>
      _$PeopleExternelIdsFromJson(json);
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

PeopleExternelIds _$PeopleExternelIdsFromJson(Map<String, dynamic> json) {
  return PeopleExternelIds(
    id: json['id'] as int?,
    freebaseMid: json['freebase_mid'] as String?,
    freebaseId: json['freebase_id'] as String?,
    imdbId: json['imdb_id'] as String?,
    tvrageId: json['tvrage_id'] as int?,
    facebookId: json['facebook_id'] as String?,
    instagramId: json['instagram_id'] as String?,
    twitterId: json['twitter_id'] as String?,
  );
}
