class ListModel {
  ListModel({
    this.description,
    this.favoriteCount,
    this.id,
    this.itemCount,
    this.iso6391,
    this.listType,
    this.name,
    this.posterPath,
  });

  String? description;
  int? favoriteCount;
  int? id;
  int? itemCount;
  String? iso6391;
  String? listType;
  String? name;
  String? posterPath;

  factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
        description: json["description"],
        favoriteCount: json["favorite_count"],
        id: json["id"],
        itemCount: json["item_count"],
        iso6391: json["iso_639_1"],
        listType: json["list_type"],
        name: json["name"],
        posterPath: json["poster_path"],
      );
}
