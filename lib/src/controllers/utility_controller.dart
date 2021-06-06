import 'package:flutter/material.dart';
import 'package:movie_app/src/configs/strings.dart';
import 'package:movie_app/src/controllers/base_controller.dart';
import 'package:get/get.dart';
import 'package:movie_app/src/utils/preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilityController extends BaseController {
// bottom navigation state
  var _navCurrentIndex = 0.obs;

  int get navCurrentIndex => _navCurrentIndex.value;

  setBottomNavIndex(int newIndex) {
    _navCurrentIndex.value = newIndex;
  }

  // launch url
  void loadUrl({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

// hide/show (tv/movie) details btn state
  var _showText = false.obs;

  bool get showText => _showText.value;

  void toggleHideShowBtn() {
    _showText.value = !_showText.value;
  }

  void resetHideShowState() => _showText.value = false;

// details tabbar navigation state
  var _tabbarCurrentIndex = 0.obs;

  int get tabbarCurrentIndex => _tabbarCurrentIndex.value;

  void setTabbarIndex(int newIndex) {
    _tabbarCurrentIndex.value = newIndex;
  }

  void resetTabbarState() => _tabbarCurrentIndex.value = 0;

  // toggle movie/tv details title to show / hide title
  var _titlevisiblity = false.obs;

  bool get titlevisiblity => _titlevisiblity.value;

  void toggleTitleVisibility() {
    _titlevisiblity.value = !_titlevisiblity.value;
  }

  // trending movies/tv switch btn state
  var _isMovieToday = Prefs.movieIsTodayState.obs;
  var _isTvToday = Prefs.tvIsTodayState.obs;

  var _isMovieNowPlaying = Prefs.isMovieNowPlayingState.obs;
  var _isTvAiringToday = Prefs.isTvAiringTodayState.obs;

  bool get isMovieNowPlaying => _isMovieNowPlaying.value;
  bool get isTvAiringToday => _isTvAiringToday.value;

  bool get isMovieToday => _isMovieToday.value;
  bool get isTvToday => _isTvToday.value;

  void toggleIsMovieNowPlayingSwitch() {
    _isMovieNowPlaying.value = !_isMovieNowPlaying.value;
    Prefs.setMovieNowPlayingState(_isMovieNowPlaying.value);
  }

  void toggleIsTvAiringTodaySwitch() {
    _isTvAiringToday.value = !_isTvAiringToday.value;
    Prefs.setTvAiringTodayState(_isTvAiringToday.value);
  }

  void toggleTrendingMovieSwitch() {
    _isMovieToday.value = !_isMovieToday.value;
    Prefs.setMoveiIstodayState(_isMovieToday.value);
  }

  void toggleTrendingTvSwitch() {
    _isTvToday.value = !_isTvToday.value;
    Prefs.setTvIstodayState(_isTvToday.value);
  }

  ///

  /// [ img slider pageview state ]
  var _imgSliderIndex = 0.obs;
  final _controller = PageController(keepPage: true).obs;

  int get imgSliderIndex => _imgSliderIndex.value;
  PageController get controller => _controller.value;

  void setSliderIndex(int index) {
    _imgSliderIndex.value = index;
  }

  void resetImgSliderIndex() {
    _imgSliderIndex.value = 0;
  }

  void forward(int currentIndex, int length) {
    if (currentIndex != (length - 1) && currentIndex < (length - 1)) {
      _imgSliderIndex.value += 1;
      // ignore: avoid_print
      // print(_imgSliderIndex.value);
    }
  }

  void backward(int currentIndex, int length) {
    if (currentIndex != (length + 1) && currentIndex > 0) {
      _imgSliderIndex.value -= 1;
      // ignore: avoid_print
      // print(_imgSliderIndex.value);
    }
  }

  void toggleImgSlider({
    required ImgSliderEvents toggleEvent,
    required int currentIndex,
    required int length,
  }) {
    switch (toggleEvent) {
      case ImgSliderEvents.forward:
        forward(currentIndex, length);
        break;
      case ImgSliderEvents.backward:
        backward(currentIndex, length);
        break;
      default:
        break;
    }

    _controller.value.animateToPage(
      _imgSliderIndex.value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}

enum ImgSliderEvents { forward, backward } // img slider btn events
