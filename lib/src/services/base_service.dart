import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/src/utils/auth.dart';

enum Requests { get, post, put, delete, update }

String authority = "api.themoviedb.org";

class BaseService {
  final client = http.Client();
  late http.Response response;
  // late Map<String, String> queryParma;
  int _timeOutDuration = 30;

  // String api = "1a5ebef58b08ad825f24591860b26990";
  // String authorization =
  //     "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYTVlYmVmNThiMDhhZDgyNWYyNDU5MTg2MGIyNjk5MCIsInN1YiI6IjYwYTM1OTI2NzMxNGExMDA3OGZjZTRkOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VJG0GMDEpcYQBtm5VZlCHEmqTY5jH4kfIkYhosKqOA0";

// headers
  Map<String, String> headers() => {
        HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8',
        HttpHeaders.acceptHeader: 'application/json'
      };

// query parameter
  // setQueryParameters({Map<String, String>? query}) {
  //   queryParma = {"api_key": api};
  //   queryParma.addAll(query ?? {});
  //   if (Auth.isLoggedIn == true) {
  //     queryParma["session_id"] = Auth.sessionId;
  //   }
  // }

  Future<http.Response> request({
    required Requests method,
    Map<String, dynamic>? body,
    Map<String, String>? queryParameter,
    required String path,
  }) async {
    // setQueryParameters();
    switch (method) {
      case Requests.get:
        response = await client
            .get(
          Uri.https(authority, path, queryParameter),
          headers: headers(),
        )
            .timeout(Duration(seconds: _timeOutDuration), onTimeout: () {
          throw TimeoutException(
              'The connection has timed out, Please try again!');
        });
        break;
      case Requests.post:
        response = await client
            .post(
          Uri.https(authority, path, queryParameter),
          headers: headers(),
          body: jsonEncode(body),
        )
            .timeout(Duration(seconds: _timeOutDuration), onTimeout: () {
          throw TimeoutException(
              'The connection has timed out, Please try again!');
        });
        break;
      case Requests.delete:
        response = await client
            .delete(
          Uri.https(authority, path, queryParameter),
          headers: headers(),
          body: jsonEncode(body),
        )
            .timeout(Duration(seconds: _timeOutDuration), onTimeout: () {
          throw TimeoutException(
              'The connection has timed out, Please try again!');
        });
        break;

      default:
        break;
    }

    if (response.statusCode == 401 || response.statusCode == 403) {
      Auth.logout();
      // Get.offAll(page);
      return response;
    }
    return response;
  }

  //
  decodeResponse(http.Response response) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  }
}
