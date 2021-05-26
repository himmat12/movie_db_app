import 'package:get_storage/get_storage.dart';
import 'package:movie_app/src/models/account_model.dart';

final box = GetStorage('auth');

class Auth {
  static bool get isLoggedIn => box.hasData('sessionId');

  static setSessionId(String sessionId) => box.write('sessionId', sessionId);
  static setAccount(String user) => box.write('account', user);

  static String get sessionId => box.read('sessionId');
  static String get account => box.read('account');

  static logout() => box.erase();
}
