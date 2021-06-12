import 'package:get/get.dart';
import 'package:movie_app/src/views/dashboard/dashboard.dart';
import 'package:movie_app/src/views/deatils/movie_deatils/movie_deatils.dart';
import 'package:movie_app/src/views/deatils/people_details/people_details.dart';
import 'package:movie_app/src/views/deatils/tv_details/tv_details.dart';
import 'package:movie_app/src/views/home/home_page.dart';

class Routes {
  static List<GetPage> getRoutes() {
    return [
      GetPage(name: '/', page: () => DashboardPage()),
      GetPage(name: '/movie_details', page: () => MoviesDetails()),
      GetPage(name: '/tv_details', page: () => TvDetails()),
      GetPage(name: '/people_details', page: () => PeopleDetails()),
    ];
  }
}
