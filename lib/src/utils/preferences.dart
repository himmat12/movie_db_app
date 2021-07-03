import 'package:get_storage/get_storage.dart';

final prefs = GetStorage('prefs');

class Prefs {
  void setMoveiIstodayState(bool data) => prefs.write('movieIsToday', data);
  void setTvIstodayState(bool data) => prefs.write('tvIsToday', data);

  void setMovieNowPlayingState(bool data) =>
      prefs.write('isMovieNowPlaying', data);
  void setTvAiringTodayState(bool data) => prefs.write('isTvAiringToday', data);

  bool get isMovieNowPlayingState => prefs.read('isMovieNowPlaying') ?? true;
  bool get isTvAiringTodayState => prefs.read('isTvAiringToday') ?? true;

  bool get movieIsTodayState => prefs.read('movieIsToday') ?? true;
  bool get tvIsTodayState => prefs.read('tvIsToday') ?? true;
}
