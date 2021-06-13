import 'dart:async';
import 'dart:io';

import 'package:movie_app/src/exceptions/app_exceptions.dart';
import 'package:movie_app/src/mixins/query_parameter_mixin.dart';
import 'package:movie_app/src/services/base_service.dart';

class PeopleService extends BaseService with QueryParameterMixin {
  /// fetches people details
  Future<dynamic> getPeopleDetails({required int personId}) async {
    try {
      final response = await request(
          method: Requests.get,
          path: '/3/person/$personId',
          queryParameter: setQueryParameters(
            query: {},
          ));
      // ignore: avoid_print
      print(response.statusCode);
      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

  /// fetches people Movie/tv credits , images , external ids
  Future<dynamic> getCreditsDetails(
      {required int personId, required String resultType}) async {
    try {
      final response = await request(
          method: Requests.get,
          path: '/3/person/$personId/$resultType',
          queryParameter: setQueryParameters(
            query: {},
          ));
      // ignore: avoid_print
      print(response.statusCode);
      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }
}
