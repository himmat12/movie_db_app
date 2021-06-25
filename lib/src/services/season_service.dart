import 'dart:async';
import 'dart:io';

import 'package:movie_app/src/exceptions/app_exceptions.dart';
import 'package:movie_app/src/mixins/query_parameter_mixin.dart';
import 'package:movie_app/src/services/base_service.dart';

class SeasonService extends BaseService with QueryParameterMixin {
  /// *** SEASON DETAILS ***

  // season details
  Future<dynamic> getSeasonDetails({
    required String tvId,
    required String seasonNo,
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: '/3/tv/$tvId/season/$seasonNo',
        queryParameter:
            setQueryParameters(query: {"append_to_response": "credits"}),
      );
      // print(Credits.fromJson(decodeResponse(response)['credits']).cast!.length);
      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

  // season account state
  Future<dynamic> getSeasonAccountState({
    required String tvId,
    required String seasonNo,
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: '/3/tv/$tvId/season/$seasonNo/account_states',
        queryParameter: setQueryParameters(query: {}),
      );
      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

  /// *** EPISODE DETAILS ***

// episode detail
  Future<dynamic> getEpisodeDetails({
    required String tvId,
    required String seasonNo,
    required String episodeNo,
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: '/3/tv/$tvId/season/$seasonNo/episode/$episodeNo',
        queryParameter: setQueryParameters(
            query: {"append_to_response": "account_states,images"}),
      );
      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

  // episode account state
  Future<dynamic> getEpisodeAccountState({
    required String tvId,
    required String seasonNo,
    required String episodeNo,
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: '/3/tv/$tvId/season/$seasonNo/episode/$episodeNo/account_states',
        queryParameter: setQueryParameters(query: {}),
      );
      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

  // rate tv episode
  Future<dynamic> rateTvEpisode({
    required String tvId,
    required String seasonNo,
    required String episodeNo,
    required double ratingValue,
  }) async {
    try {
      final response = await request(
        method: Requests.post,
        path: '/3/tv/$tvId/season/$seasonNo/episode/$episodeNo/rating',
        queryParameter: setQueryParameters(query: {}),
        body: {"value": ratingValue},
      );
      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

  // delete tv episode ratings
  Future<dynamic> deleteTvEpisodeRating({
    required String tvId,
    required String seasonNo,
    required String episodeNo,
    required double ratingValue,
  }) async {
    try {
      final response = await request(
        method: Requests.delete,
        path: '/3/tv/$tvId/season/$seasonNo/episode/$episodeNo/rating',
        queryParameter: setQueryParameters(query: {}),
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
