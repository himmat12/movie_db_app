import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';

class DetailsController extends BaseController {
  getDetails({required String resultType}) async {
    switch (resultType) {
      case MOVIE_STRING:
        break;
      case TV_STRING:
        break;
      default:
        break;
    }
  }
}
