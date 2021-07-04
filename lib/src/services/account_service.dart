import 'dart:async';
import 'dart:io';

import 'package:movie_app/src/exceptions/app_exceptions.dart';
import 'package:movie_app/src/services/base_service.dart';

class AccountService extends BaseService {
  // get account details
  Future<dynamic> getAccountDetails() async {
    try {
      await request(
        method: Requests.get,
        path: '/3/account',
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

  // add to watchlist - movies/tv
  Future<dynamic> addToWatchlist(
      {required String mediaType, required int mediaId}) async {
    try {
      await request(
        method: Requests.post,
        path: '/3/account/{account_id}/watchlist',
        header: setHeaders(),
        queryParameter: setQueryParameters(),
        body: {
          "media_type": mediaType,
          "media_id": '$mediaId',
          "watchlist": true
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

  // get watchlist - movies/tv
  Future<dynamic> getMovieWatchList({required int accountId}) async {
    try {
      await request(
        method: Requests.get,
        path: '/3/account/$accountId/watchlist/movies',
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

  Future<dynamic> getTvWatchList({required int accountId}) async {
    try {
      await request(
        method: Requests.get,
        path: '/3/account/$accountId/watchlist/tv',
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

  // add to favorite
  Future<dynamic> addToFavorite(
      {required String mediaType, required int mediaId}) async {
    try {
      await request(
        method: Requests.post,
        path: '/3/account/{account_id}/favorite',
        header: setHeaders(),
        queryParameter: setQueryParameters(),
        body: {
          "media_type": mediaType,
          "media_id": '$mediaId',
          "favorite": true
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

  // get favorite list movies/tv
  Future<dynamic> getFavorteMovies({required int accountId}) async {
    try {
      await request(
        method: Requests.get,
        path: '/3/account/$accountId/favorite/movies',
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

  Future<dynamic> getFavorteTv({required int accountId}) async {
    try {
      await request(
        method: Requests.get,
        path: '/3/account/$accountId/favorite/tv',
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

  // create list
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
