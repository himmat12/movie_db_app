import 'dart:async';
import 'dart:io';

import 'package:movie_app/src/exceptions/app_exceptions.dart';
import 'package:movie_app/src/services/base_service.dart';

class ResultsService extends BaseService {
  // movie results service
  Future<dynamic> getMovieResults({
    String page = "",
    String region = "",
    required String resultType,
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: "/3/movie/$resultType",
        header: setHeaders(),
        queryParameter: setQueryParameters(query: {"page": page}),
      );
      // ignore: avoid_print
      // print('$resultType MOVIE RESULTS STATUS => ${response.statusCode}');
      // ignore: avoid_print
      // print('PAGE => $page');

      return decodeResponse(response)['results'];
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

  // tv results service
  Future<dynamic> getTvResults({
    String page = "",
    required String resultType,
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: "/3/tv/$resultType",
        header: setHeaders(),
        queryParameter: setQueryParameters(query: {"page": page}),
      );
      // ignore: avoid_print
      // print('$resultType TV RESULTS STATUS => ${response.statusCode}');
      // ignore: avoid_print
      // print('PAGE => ${decodeResponse(response)['page']}');

      return decodeResponse(response)['results'];
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }
}
