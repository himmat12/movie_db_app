import 'package:get_storage/get_storage.dart';
import 'package:movie_app/src/models/account_model.dart';

final box = GetStorage('auth');

class Auth {
  static bool get isLoggedIn => box.hasData('sessionId');
  static bool get isGuestLoggedIn => box.hasData('guestSessionId');

  static setSessionId(String sessionId) => box.write('sessionId', sessionId);
  static setGuestSessionId(String sessionId) =>
      box.write('guestSessionId', sessionId);

  static setAccount(String user) => box.write('account', user);

  static String get sessionId => box.read('sessionId');
  static String get guestSessionId => box.read('guestSessionId');

  static String get account => box.read('account');

  static logout() => box.erase();
}
