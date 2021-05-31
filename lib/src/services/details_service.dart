import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/mixins/query_parameter_mixin.dart';
import 'package:movie_app/src/services/base_service.dart';

class DetailsService extends BaseService with QueryParameterMixin {
  Future<dynamic> getDetails(
      {required String resultType, required int id}) async {
    switch (resultType) {
      case MOVIE_STRING:
        await request(
            method: Requests.get,
            path: "/3/movie/$id",
            queryParameter: setQueryParameters(query: {
              "append_to_response":
                  "images,videos,credits,account_states,similar,recommendations,reviews,external_ids"
            }));
        break;
      case TV_STRING:
        break;
      default:
        break;
    }
  }
}
