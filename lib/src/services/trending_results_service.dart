import 'dart:async';
import 'dart:io';

import '../exceptions/app_exceptions.dart';
import 'base_service.dart';

class TrendingResultsService extends BaseService {
  // trending results service
  Future<dynamic> getTrendingResults({
    required String mediaType,
    required String timeWindow,
    String page = "",
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: "/3/trending/$mediaType/$timeWindow",
        header: setHeaders(),
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
