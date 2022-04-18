import '../results/movie_result_model.dart';

class MovieListDetails {
  MovieListDetails({
    this.createdBy,
    this.description,
    this.favoriteCount,
    this.id,
    this.items,
    this.itemCount,
    this.iso6391,
    this.name,
    this.posterPath,
  });

  String? createdBy;
  String? description;
  int? favoriteCount;
  String? id;
  List<MovieResultModel>? items;
  int? itemCount;
  String? iso6391;
  String? name;
  String? posterPath;

  factory MovieListDetails.fromJson(Map<String, dynamic> json) =>
      MovieListDetails(
        createdBy: json["created_by"] as String,
        description: json["description"] as String,
        favoriteCount: json["favorite_count"] as int,
        id: json["id"] as String,
        items: json["items"] == null
            ? null
            : List.from((json["items"] as List)
                .map((e) => MovieResultModel.fromJson(e))),
        itemCount: json["item_count"] as int,
        iso6391: json["iso_639_1"] as String,
        name: json["name"] as String,
        posterPath: json["poster_path"] as String,
      );
}
