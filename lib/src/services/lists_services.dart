import 'dart:async';
import 'dart:io';

import 'package:movie_app/src/exceptions/app_exceptions.dart';
import 'package:movie_app/src/services/base_service.dart';

class ListService extends BaseService {
  /// create list [createList] method creates a new list of collection in a session
  Future<dynamic> createList(
      {required String name, required String description}) async {
    try {
      await request(
        method: Requests.post,
        path: '/3/list',
        header: setHeaders(),
        queryParameter: setQueryParameters(),
        body: {
          "name": "John1241 first list",
          "description": "Namaste everyone im John1241 , your host",
          "language": "en"
        },
      );

      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

  // get created lists
  Future<dynamic> getLists({required int accountId}) async {
    try {
      await request(
        method: Requests.get,
        path: '/3/account/$accountId/lists',
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

  //  get list details
  Future<dynamic> getListDetails({required int listId}) async {
    try {
      await request(
        method: Requests.get,
        path: '/3/list/$listId',
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

  // add movie to list
  Future<dynamic> addMovieToList(
      {required int listId, required int movieId}) async {
    try {
      await request(
        method: Requests.post,
        path: '/3/list/$listId/add_item',
        header: setHeaders(),
        queryParameter: setQueryParameters(),
        body: {"media_id": movieId},
      );

      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

  // remove movie from list
  Future<dynamic> removeMovieFromList(
      {required int listId, required int movieId}) async {
    try {
      await request(
        method: Requests.post,
        path: '/3/list/$listId/remove_item',
        header: setHeaders(),
        queryParameter: setQueryParameters(),
        body: {"media_id": movieId},
      );

      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

  // clear list - empty
  Future<dynamic> clearList({required int listId}) async {
    try {
      await request(
        method: Requests.post,
        path: '/3/list/$listId/clear',
        header: setHeaders(),
        queryParameter: setQueryParameters(query: {"confirm": "true"}),
      );

      return decodeResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw ServiceNotRespondingException(
          'Service not responding in time please check your Internet Connection');
    }
  }

  // clear list - empty
  Future<dynamic> deleteList({required int listId}) async {
    try {
      await request(
        method: Requests.delete,
        path: '/3/list/$listId',
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

//
}
