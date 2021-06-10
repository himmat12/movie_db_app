import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/mixins/query_parameter_mixin.dart';
import 'package:movie_app/src/services/base_service.dart';

//  queryParameter: setQueryParameters(query: {
//             "append_to_response":
//                 "images,videos,credits,account_states,similar,recommendations,reviews,external_ids"
//           })

class DetailsService extends BaseService with QueryParameterMixin {
  // only movie basic details
  Future<dynamic> getDetails(
      {required String resultType, required int id}) async {
    try {
      final response = await request(
          method: Requests.get,
          path: "/3/$resultType/$id",
          queryParameter: setQueryParameters(query: {}));

      // ignore: avoid_print
      print('$resultType DETAILS STATUS => ${response.statusCode}');
      if (response.statusCode == 200) {
        return decodeResponse(response);
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

// other movies details like (images,videos,credits,account_states,similar,recommendations,reviews,external_ids)
  Future<dynamic> getOtherDetails({
    required String resultType,
    required int id,
    required String appendTo,
  }) async {
    try {
      final response = await request(
          method: Requests.get,
          path: "/3/$resultType/$id/$appendTo",
          queryParameter: setQueryParameters(query: {}));

      // ignore: avoid_print
      print('$resultType OTHER DETAILS STATUS => ${response.statusCode}');
      if (response.statusCode == 200) {
        return decodeResponse(response);
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
