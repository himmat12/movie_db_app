import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/mixins/query_parameter_mixin.dart';
import 'package:movie_app/src/services/base_service.dart';

class DetailsService extends BaseService with QueryParameterMixin {
  Future<dynamic> getDetails(
      {required String resultType, required int id}) async {
    try {
      final response = await request(
          method: Requests.get,
          path: "/3/$resultType/$id",
          queryParameter: setQueryParameters(query: {
            "append_to_response":
                "images,videos,credits,account_states,similar,recommendations,reviews,external_ids"
          }));

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
}
