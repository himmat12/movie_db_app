import 'dart:async';
import 'dart:io';

import 'package:movie_app/src/exceptions/app_exceptions.dart';
import 'package:movie_app/src/mixins/query_parameter_mixin.dart';
import 'package:movie_app/src/services/base_service.dart';

class DetailsService extends BaseService with QueryParameterMixin {
  // only movie basic details
  Future<dynamic> getDetails(
      {required String resultType, required String id}) async {
    try {
      final response = await request(
          method: Requests.get,
          path: "/3/$resultType/$id",
          queryParameter: setQueryParameters(query: {}));

      // ignore: avoid_print
      // print('$resultType DETAILS STATUS => ${response.statusCode}');
      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

// other movies details like (images,videos,credits,account_states,similar,recommendations,reviews,external_ids)
  Future<dynamic> getOtherDetails({
    required String resultType,
    required String id,
    required String appendTo,
  }) async {
    try {
      final response = await request(
          method: Requests.get,
          path: "/3/$resultType/$id/$appendTo",
          queryParameter: setQueryParameters(query: {}));

      // ignore: avoid_print
      // print('$resultType OTHER DETAILS STATUS => ${response.statusCode}');
      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }
}
