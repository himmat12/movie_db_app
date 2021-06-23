import 'package:get/get.dart';
import 'package:movie_app/src/views/dashboard/dashboard.dart';
import 'package:movie_app/src/views/deatils/episode_details/components/episode_crew_page.dart';
import 'package:movie_app/src/views/deatils/episode_details/components/episode_guest_stars_list.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/movie_deatils.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/tabs/about/components/movie_crew_page.dart';
import 'package:movie_app/src/views/deatils/people_details/people_details.dart';
import 'package:movie_app/src/views/deatils/season_details/season_details.dart';
import 'package:movie_app/src/views/deatils/tv_details/tabs/about/components/tv_crew_page.dart';
import 'package:movie_app/src/views/deatils/tv_details/tv_details.dart';

import 'src/views/deatils/episode_details/episode_details.dart';

class Routes {
  static List<GetPage> getRoutes() {
    return [
      GetPage(name: '/', page: () => DashboardPage()),
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
    ];
  }
}
