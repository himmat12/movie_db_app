import 'package:get_storage/get_storage.dart';

final box = GetStorage('auth');

class Auth {
  bool get isLoggedIn => box.hasData('sessionId');
  bool get isGuestLoggedIn => box.hasData('guestSessionId');

  void setSessionId(String sessionId) => box.write('sessionId', sessionId);
  void setGuestSessionId(String sessionId) =>
      box.write('guestSessionId', sessionId);

  void setUsername({String? usename}) => box.write('username', usename);
  void setUserAvatar({String? url}) => box.write('user_avatar', url);
  void setUserGrvatar({String? url}) => box.write('user_gravatar', url);

  void setSearchHistory(List<String> history) => box.write('history', history);

  String get sessionId => box.read('sessionId');
  String get guestSessionId => box.read('guestSessionId');

  String? get username => box.read('username');
  String? get userAvatar => box.read('user_avatar');
  String? get userGravatar => box.read('user_gravatar');

  List<String> get searchHistory => box.read('history');

  void logout() => box.erase();
}
