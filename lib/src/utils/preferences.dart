import 'package:get_storage/get_storage.dart';

final prefs = GetStorage('prefs');

class Prefs {
  static setMoveiIstodayState(bool data) => prefs.write('movieIsToday', data);
  static setTvIstodayState(bool data) => prefs.write('tvIsToday', data);

  static setMovieNowPlayingState(bool data) =>
      prefs.write('isMovieNowPlaying', data);
  static setTvAiringTodayState(bool data) =>
      prefs.write('isTvAiringToday', data);

  static bool get isMovieNowPlayingState =>
      prefs.read('isMovieNowPlaying') ?? true;
  static bool get isTvAiringTodayState => prefs.read('isTvAiringToday') ?? true;

  static bool get movieIsTodayState => prefs.read('movieIsToday') ?? true;
  static bool get tvIsTodayState => prefs.read('tvIsToday') ?? true;
}
