import 'package:get_storage/get_storage.dart';

final box = GetStorage('auth');

class Auth {
  bool get isLoggedIn => box.hasData('sessionId');
  bool get isGuestLoggedIn => box.hasData('guestSessionId');

  void setSessionId(String sessionId) async =>
      await box.write('sessionId', sessionId);
  void setGuestSessionId(String sessionId) async =>
      await box.write('guestSessionId', sessionId);

  void setUsername({String? usename}) async =>
      await box.write('username', usename);
  void setFullname({String? fullname}) async =>
      await box.write('fullname', fullname);
  void setUserAvatar({String? url}) async =>
      await box.write('user_avatar', url);
  void setUserGrvatar({String? url}) async =>
      await box.write('user_gravatar', url);

  void setSearchHistoryMovie(List history) async =>
      await box.write('history_movie', history);

  void setSearchHistoryTv(List history) async =>
      await box.write('history_tv', history);

  String get sessionId => box.read('sessionId');
  String get guestSessionId => box.read('guestSessionId');

  String? get username => box.read('username');
  String? get fullname => box.read('fullname');
  String? get userAvatar => box.read('user_avatar');
  String? get userGravatar => box.read('user_gravatar');

  List get searchHistoryMovie => box.read('history_movie') ?? [];
  List get searchHistoryTv => box.read('history_tv') ?? [];

  void logout() => box.erase();
}
