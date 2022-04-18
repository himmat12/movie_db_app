import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/preferences.dart';
import 'base_controller.dart';

class UtilityController extends BaseController {
  @override
  void onInit() {
    resetBottomNavState();
    resetHideShowState();
    resetImgSliderIndex();
    resetTabbarState();
    resetPeopleTabbarState();
    resetSeasonTabbarState();
    resetEpisodeTabbarState();
    resetSearchTabbarState();
    super.onInit();
  }

  // set orientation to landscape/portrait
  void setLandscapeOrientation() => SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  void setDefaultOrientation() =>
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

// share medias
  void shareIt(String? text) {
    Share.share(text ?? 'Hello world');
  }

// DASHBOARD bottom navigation state
  final _navCurrentIndex = 0.obs;

  int get navCurrentIndex => _navCurrentIndex.value;

  void setBottomNavIndex(int newIndex) {
    _navCurrentIndex.value = newIndex;
  }

  void resetBottomNavState() => _navCurrentIndex.value = 0;

  // launch url
  void loadUrl({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

// hide/show (tv/movie) details btn state
  final showText = false.obs;

  // bool get showText => _showText.value;

  void toggleHideShowBtn() {
    showText.value = !showText.value;
  }

  void resetHideShowState() => showText.value = false;

// details tabbar navigation state
  final _tabbarCurrentIndex = 0.obs;
  final _peopleTabbarCurrentIndex = 0.obs;
  final _seasonTabbarCurrentIndex = 0.obs;
  final _episodeTabbarCurrentIndex = 0.obs;
  final _searchTabbarCurrentIndex = 0.obs;
  final _watchlistTabbarCurrentIndex = 0.obs;
  final _discoverTabbarCurrentIndex = 0.obs;

  int get tabbarCurrentIndex => _tabbarCurrentIndex.value;
  int get peopleTabbarCurrentIndex => _peopleTabbarCurrentIndex.value;
  int get seasonTabbarCurrentIndex => _seasonTabbarCurrentIndex.value;
  int get episodeTabbarCurrentIndex => _episodeTabbarCurrentIndex.value;
  int get searchTabbarCurrentIndex => _searchTabbarCurrentIndex.value;
  int get wacthlistTabbarCurrentIndex => _watchlistTabbarCurrentIndex.value;
  int get discoverTabbarCurrentIndex => _discoverTabbarCurrentIndex.value;

  void setWatchlistTabbarIndex(int newIndex) {
    _watchlistTabbarCurrentIndex.value = newIndex;
    update(['watchlistTabBar', 'watchlistTabs']);
  }

  // void setDiscoverTabbarIndex(int newIndex) {
  //   _discoverTabbarCurrentIndex.value = newIndex;
  //   update(['discoverTabBar', 'discoverTabs']);
  // }

  void setSearchTabbarIndex(int newIndex) {
    _searchTabbarCurrentIndex.value = newIndex;
    update(['searchTabBar', 'searchTabs']);
  }

  void setTabbarIndex(int newIndex) {
    _tabbarCurrentIndex.value = newIndex;
    update(['bottomTabBar', 'tabs']);
  }

  void setPeopleTabbarIndex(int newIndex) {
    _peopleTabbarCurrentIndex.value = newIndex;
    update(['peopleBottomTabBar', 'peopleTabs']);
  }

  void setSeasonTabbarIndex(int newIndex) {
    _seasonTabbarCurrentIndex.value = newIndex;
    update(['seasonBottomTabBar', 'seasonTabs']);
  }

  void setEpisodeTabbarIndex(int newIndex) {
    _episodeTabbarCurrentIndex.value = newIndex;
    update(['episodeBottomTabBar', 'episodeTabs']);
  }

  void resetTabbarState() => _tabbarCurrentIndex.value = 0;
  void resetPeopleTabbarState() => _peopleTabbarCurrentIndex.value = 0;
  void resetSeasonTabbarState() => _seasonTabbarCurrentIndex.value = 0;
  void resetEpisodeTabbarState() => _episodeTabbarCurrentIndex.value = 0;
  void resetSearchTabbarState() => _searchTabbarCurrentIndex.value = 0;
  void resetWatchlistTabbarState() => _watchlistTabbarCurrentIndex.value = 0;
  void resetDiscoverTabbarState() => _discoverTabbarCurrentIndex.value = 0;

  // toggle movie/tv details title to show / hide title
  final _titlevisiblity = false.obs;

  bool get titlevisiblity => _titlevisiblity.value;

  void toggleTitleVisibility() {
    _titlevisiblity.value = !_titlevisiblity.value;
  }

  // trending movies/tv switch btn state
  final _isMovieToday = Prefs().movieIsTodayState.obs;
  final _isTvToday = Prefs().tvIsTodayState.obs;

  final _isMovieNowPlaying = Prefs().isMovieNowPlayingState.obs;
  final _isTvAiringToday = Prefs().isTvAiringTodayState.obs;

  bool get isMovieNowPlaying => _isMovieNowPlaying.value;
  bool get isTvAiringToday => _isTvAiringToday.value;

  bool get isMovieToday => _isMovieToday.value;
  bool get isTvToday => _isTvToday.value;

  void toggleIsMovieNowPlayingSwitch() {
    _isMovieNowPlaying.value = !_isMovieNowPlaying.value;
    Prefs().setMovieNowPlayingState(_isMovieNowPlaying.value);
  }

  void toggleIsTvAiringTodaySwitch() {
    _isTvAiringToday.value = !_isTvAiringToday.value;
    Prefs().setTvAiringTodayState(_isTvAiringToday.value);
  }

  void toggleTrendingMovieSwitch() {
    _isMovieToday.value = !_isMovieToday.value;
    Prefs().setMoveiIstodayState(_isMovieToday.value);
  }

  void toggleTrendingTvSwitch() {
    _isTvToday.value = !_isTvToday.value;
    Prefs().setTvIstodayState(_isTvToday.value);
  }

  ///

  /// [ img slider pageview state ]
  final _imgSliderIndex = 0.obs;
  final _controller = PageController(keepPage: true).obs;

  int get imgSliderIndex => _imgSliderIndex.value;
  PageController get controller => _controller.value;

  void setSliderIndex(int index) {
    _imgSliderIndex.value = index;
    update(['imageSlider']);
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
