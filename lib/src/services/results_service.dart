import 'package:movie_app/src/mixins/query_parameter_mixin.dart';
import 'package:movie_app/src/services/base_service.dart';

class ResultsService extends BaseService with QueryParameterMixin {
  // movie results service
  Future<dynamic> getMovieResults({
    String page = "",
    String region = "",
    required String resultType,
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: "/3/movie/$resultType",
        queryParameter: setQueryParameters(query: {"page": page}),
      );
      // ignore: avoid_print
      print('MOVIE RESULTS STATUS => ${response.statusCode}');
      if (response.statusCode == 200) {
        // ignore: avoid_print
        // print('PAGE => ${decodeResponse(response)['page']}');
        return decodeResponse(response)['results'];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  // tv results service
  Future<dynamic> getTvResults({
    String page = "",
    required String resultType,
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: "/3/tv/$resultType",
        queryParameter: setQueryParameters(query: {"page": page}),
      );
      // ignore: avoid_print
      print('TV RESULTS STATUS => ${response.statusCode}');
      if (response.statusCode == 200) {
        // ignore: avoid_print
        // print('PAGE => ${decodeResponse(response)['page']}');
        return decodeResponse(response)['results'];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
