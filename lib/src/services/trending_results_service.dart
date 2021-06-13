import 'dart:async';
import 'dart:io';

import 'package:movie_app/src/exceptions/app_exceptions.dart';
import 'package:movie_app/src/mixins/query_parameter_mixin.dart';
import 'package:movie_app/src/services/base_service.dart';

class TrendingResultsService extends BaseService with QueryParameterMixin {
  // trending results service
  Future<dynamic> getTrendingResults({
    String page = "",
    required String mediaType,
    required String timeWindow,
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: "/3/trending/$mediaType/$timeWindow",
        queryParameter: setQueryParameters(query: {"page": page}),
      );
      // ignore: avoid_print
      // print('TRENDING $mediaType RESULTS STATUS => ${response.statusCode}');
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
