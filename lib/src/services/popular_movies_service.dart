import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_app/src/models/movie_model.dart';

class PopularMoviesService {
  String authority = "api.themoviedb.org";
  String path = "/3/movie/popular";
  String authorizationBearer =
      "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYTVlYmVmNThiMDhhZDgyNWYyNDU5MTg2MGIyNjk5MCIsInN1YiI6IjYwYTM1OTI2NzMxNGExMDA3OGZjZTRkOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VJG0GMDEpcYQBtm5VZlCHEmqTY5jH4kfIkYhosKqOA0";
  var client = http.Client();
  var popularMovies = <MovieModel>[];

  Map<String, dynamic> queryParma = {
    "api-key": "1a5ebef58b08ad825f24591860b26990",
    "page": "2"
  };

  Map<String, String> headers() {
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: authorizationBearer,
      HttpHeaders.contentTypeHeader: "application/json;charset=utf-8S",
    };

    return headers;
  }

  decodeResponse(http.Response response) {
    return jsonDecode(response.body)["results"];
  }

  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await client.get(Uri.https(authority, path, queryParma),
          headers: headers());

      // ignore: avoid_print
      print(response.statusCode);

      if (response.statusCode == 200) {
        popularMovies = List.from(
            decodeResponse(response).map((e) => MovieModel.fromJson(e)));

        for (var e in popularMovies) {
          // ignore: avoid_print
          print(e.title);
        }

        return popularMovies;
      } else {
        return [];
      }
    } catch (ex) {
      rethrow;
    } finally {}
  }
}
