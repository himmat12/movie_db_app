import 'dart:io';

import 'package:movie_app/src/exceptions/app_exceptions.dart';
import 'package:movie_app/src/mixins/query_parameter_mixin.dart';
import 'package:movie_app/src/services/base_service.dart';

class ConfigurationService extends BaseService with QueryParameterMixin {
  Future<dynamic> getConfiguration() async {
    try {
      await request(
          method: Requests.get,
          path: "/3/configuration",
          queryParameter: setQueryParameters(query: {}));
      // ignore: avoid_print
      // print('CONFIGURATION STATUS => ${response.statusCode}');

      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }
}
