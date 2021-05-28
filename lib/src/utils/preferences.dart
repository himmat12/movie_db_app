import 'package:get_storage/get_storage.dart';

final prefs = GetStorage('prefs');

class Prefs {
  static setMoveiIstodayState(bool data) => prefs.write('movieIsToday', data);
  static setTvIstodayState(bool data) => prefs.write('tvIsToday', data);

  static bool get movieIsTodayState => prefs.read('movieIsToday') ?? true;
  static bool get tvIsTodayState => prefs.read('tvIsToday') ?? true;
}
