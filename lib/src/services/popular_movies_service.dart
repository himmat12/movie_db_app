import 'package:movie_app/src/mixins/query_parameter_mixin.dart';
import 'package:movie_app/src/services/base_service.dart';

class PopularMoviesService extends BaseService with QueryParameterMixin {
  Future<dynamic> getPopularMovies({
    String? page,
    String? region,
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: "/3/movie/popular",
        queryParameter: setQueryParameters(
            query: {"page": page ?? "1", "region": region ?? "us"}),
      );
      // ignore: avoid_print
      print('STATUS => ${response.statusCode}');
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('PAGE => ${decodeResponse(response)['page']}');
        return decodeResponse(response)['results'];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }
}
