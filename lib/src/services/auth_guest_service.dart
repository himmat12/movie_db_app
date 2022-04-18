import 'dart:async';
import 'dart:io';

import '../exceptions/app_exceptions.dart';
import 'base_service.dart';

class AuthGuestService extends BaseService {
  // create guest session
  Future<dynamic> createGuestSession() async {
    try {
      await request(
        method: Requests.get,
        path: '/3/authentication/guest_session/new',
        queryParameter: setQueryParameters(),
      );

      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }
}
