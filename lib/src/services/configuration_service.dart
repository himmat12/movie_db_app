import 'dart:async';
import 'dart:io';

import 'package:movie_app/src/exceptions/app_exceptions.dart';
import 'package:movie_app/src/services/base_service.dart';

class ConfigurationService extends BaseService {
  Future<dynamic> getConfiguration() async {
    try {
      await request(
          method: Requests.get,
          path: "/3/configuration",
          header: setHeaders(),
          queryParameter: setQueryParameters());
      // ignore: avoid_print
      // print('CONFIGURATION STATUS => ${response.statusCode}');

      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }
}
