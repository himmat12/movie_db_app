import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';

import '../exceptions/app_exceptions.dart';
import '../utils/auth.dart';
import 'base_service.dart';

class AuthV4Service extends BaseService {
// create request token [1]
  Future<dynamic> createV4RequestToken({Map<String, String>? header}) async {
    try {
      await request(
        method: Requests.post,
        path: '/4/auth/request_token',
        header: setHeaders(header: header),
      ).then((value) {
        Get.toNamed(
            '/authorization?url=https://www.themoviedb.org/auth/access?request_token=${decodeResponse(response)['request_token']}&requestToken=${decodeResponse(response)['request_token']}');
      });

      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

  // create access token [2]
  Future<dynamic> createV4AccessToken({
    required String requestToken,
    Map<String, String>? header,
  }) async {
    try {
      await request(
        method: Requests.post,
        path: '/4/auth/access_token',
        body: {"request_token": requestToken},
        header: setHeaders(header: {
          HttpHeaders.authorizationHeader:
              "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYTVlYmVmNThiMDhhZDgyNWYyNDU5MTg2MGIyNjk5MCIsInN1YiI6IjYwYTM1OTI2NzMxNGExMDA3OGZjZTRkOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VJG0GMDEpcYQBtm5VZlCHEmqTY5jH4kfIkYhosKqOA0"
        }),
        queryParameter: setQueryParameters(),
      ).then((value) {
        // print(
        //     '\n\n\n ACCESS TOKEN ==>> ${decodeResponse(response)['access_token']}');
        createV4Session(accessToken: decodeResponse(response)['access_token']);
      });

      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

// create session [3]
  Future<dynamic> createV4Session({required String accessToken}) async {
    try {
      await request(
        method: Requests.post,
        path: '/3/authentication/session/convert/4',
        body: {"access_token": accessToken},
        header: setHeaders(),
        queryParameter: setQueryParameters(),
      ).then((value) {
        Auth().setSessionId(decodeResponse(response)['session_id']);

        // print('\n\n\n SESSION REQUEST STATUS ==>> ${response.statusCode}');
        // print(
        //     '\n\n\n SESSION_ID ==>> ${decodeResponse(response)['session_id']}');

        Get.offAllNamed('/dashboard');
      });

      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }
}
