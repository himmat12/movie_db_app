import 'package:get_storage/get_storage.dart';

final box = GetStorage('auth');

class Auth {
  bool get isLoggedIn => box.hasData('sessionId');
  bool get isGuestLoggedIn => box.hasData('guestSessionId');

  void setSessionId(String sessionId) => box.write('sessionId', sessionId);
  void setGuestSessionId(String sessionId) =>
      box.write('guestSessionId', sessionId);

  void setAccount(String user) => box.write('account', user);

  String get sessionId => box.read('sessionId');
  String get guestSessionId => box.read('guestSessionId');

  String get account => box.read('account');

  void logout() => box.erase();
}
