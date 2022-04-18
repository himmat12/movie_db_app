import 'dart:async';
import 'dart:io';

import '../exceptions/app_exceptions.dart';
import 'base_service.dart';

class SearchService extends BaseService {
// search query
  Future<dynamic> search({
    required String query,
    required String resultType,
  }) async {
    try {
      await request(
          method: Requests.get,
          path: '/3/search/$resultType',
          queryParameter: setQueryParameters(query: {"query": query}));
      // print(decodeResponse(response)['results']);

      return decodeResponse(response)['results'];
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }
}
