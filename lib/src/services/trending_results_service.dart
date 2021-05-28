import 'package:movie_app/src/mixins/query_parameter_mixin.dart';
import 'package:movie_app/src/services/base_service.dart';

class TrendingResultsService extends BaseService with QueryParameterMixin {
  // trending results service
  Future<dynamic> getTrendingResults({
    String page = "",
    required String mediaType,
    required String timeWindow,
  }) async {
    try {
      final response = await request(
        method: Requests.get,
        path: "/3/trending/$mediaType/$timeWindow",
        queryParameter: setQueryParameters(query: {"page": page}),
      );
      // ignore: avoid_print
      print('TRENDING $mediaType RESULTS STATUS => ${response.statusCode}');
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('PAGE => ${decodeResponse(response)['page']}');
        // ignore: avoid_print
        // print(decodeResponse(response)['results']);
        return decodeResponse(response)['results'];
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

//   // tv results service
//   Future<dynamic> getTrendingTvResults({
//     String page = "",
//     required String resultType,
//   }) async {
//     try {
//       final response = await request(
//         method: Requests.get,
//         // path: "/3/tv/$resultType",
//         path: "/3/trending/tv/$resultType",
//         queryParameter: setQueryParameters(query: {"page": page}),
//       );
//       // ignore: avoid_print
//       print('TRENDING TV RESULTS STATUS => ${response.statusCode}');
//       if (response.statusCode == 200) {
//         // ignore: avoid_print
//         // print('PAGE => ${decodeResponse(response)['page']}');
//         return decodeResponse(response)['results'];
//       } else {
//         return null;
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
}
