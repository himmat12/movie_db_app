import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/src/exceptions/app_exceptions.dart';
import 'dart:convert';
import 'package:movie_app/src/utils/auth.dart';

enum Requests { get, post, put, delete, update }

String authority = "api.themoviedb.org";

class BaseService {
  final client = http.Client();
  late http.Response response;
  final _timeOutDuration = 30;

// headers
  Map<String, String> headers() => {
        HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8',
        HttpHeaders.acceptHeader: 'application/json'
      };

// response
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;

      case 400:
        throw BadRequestException(jsonDecode(jsonEncode(response.body)));

      case 401:
      case 403:
        throw UnauthorizedException(jsonDecode(jsonEncode(response.body)));

      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communicating with Server with StatusCode: ${response.statusCode}');
    }
  }

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
            .timeout(Duration(seconds: _timeOutDuration));
        break;
      case Requests.post:
        response = await client
            .post(
              Uri.https(authority, path, queryParameter),
              headers: headers(),
              body: jsonEncode(body),
            )
            .timeout(Duration(seconds: _timeOutDuration));
        break;
      case Requests.delete:
        response = await client
            .delete(
              Uri.https(authority, path, queryParameter),
              headers: headers(),
              body: jsonEncode(body),
            )
            .timeout(Duration(seconds: _timeOutDuration));
        break;

      default:
        break;
    }

    if (response.statusCode == 401 || response.statusCode == 403) {
      Auth.logout();
      // Get.offAll(page);
      return returnResponse(response);
    }
    return returnResponse(response);
  }

  //decodes response from string to json object
  decodeResponse(http.Response response) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  }
}
