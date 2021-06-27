import 'package:get/get.dart';
import 'package:movie_app/src/views/auth/components/request_authorization_webview.dart';
import 'package:movie_app/src/views/dashboard/dashboard.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/movie_deatils.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/about/components/movie_crew_page.dart';
import 'package:movie_app/src/views/deatils/people_details/people_details.dart';
import 'package:movie_app/src/views/deatils/season_details/season_details.dart';
import 'package:movie_app/src/views/deatils/tv_details/tabs/about/components/tv_crew_page.dart';
import 'package:movie_app/src/views/deatils/tv_details/tv_details.dart';
import 'package:movie_app/src/views/home/lists/tv/tv_result_list.dart';

import 'src/views/deatils/episode_details/episode_crew/episode_crew_page.dart';
import 'src/views/deatils/episode_details/episode_details.dart';
import 'src/views/deatils/episode_details/guest_casts/episode_guest_stars_list.dart';
import 'src/views/home/lists/movies/movie_result_list.dart';
import 'src/views/home/lists/movies/trending_movie_list.dart';
import 'src/views/home/lists/tv/trending_tv_list.dart';

class Routes {
  static List<GetPage> getRoutes() {
    return [
      GetPage(name: '/dashboard', page: () => DashboardPage()),
      GetPage(
          name: '/movie_details/',
          page: () => MoviesDetails(movieId: Get.parameters['movieId'] ?? "")),
      GetPage(name: '/tv_details', page: () => TvDetails()),
      GetPage(name: '/people_details', page: () => PeopleDetails()),
      GetPage(name: '/season_details', page: () => SeasonDetails()),
      GetPage(name: '/episode_details', page: () => EpisodeDetails()),
      GetPage(name: '/episode_crew', page: () => EpisodeCrewPage()),
      GetPage(name: '/tv_crew', page: () => TvCrewPage()),
      GetPage(name: '/movie_crew', page: () => MovieCrewPage()),
      GetPage(name: '/guest_stars', page: () => GuestStarsList()),
      GetPage(
          name: '/trending_movie_list',
          page: () => HomeTrendingMovieList(
                title: Get.arguments['title'],
                toggleOption: Get.arguments['toggleOption'],
              )),
      GetPage(
          name: '/movie_results_list',
          page: () => HomeMovieresultsList(
              state: Get.arguments['state'],
              title: Get.arguments['title'],
              resultType: Get.arguments['resultType'] ?? '')),
      GetPage(
          name: '/trending_tv_list',
          page: () => HomeTrendingTvList(
                title: Get.arguments['title'],
                toggleOption: Get.arguments['toggleOption'],
              )),
      GetPage(
          name: '/tv_results_list',
          page: () => HomeTvResultList(
              state: Get.arguments['state'],
              title: Get.arguments['title'],
              resultType: Get.arguments['resultType'] ?? '')),
      GetPage(
          name: '/authorization', page: () => const AuthorizeRequestToken()),
    ];
  }
}
