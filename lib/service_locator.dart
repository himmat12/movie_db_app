import 'package:get_it/get_it.dart';
import 'package:movie_app/src/services/popular_movies_service.dart';

final sl = GetIt.instance;

void setUp() {
  sl.registerLazySingleton<PopularMoviesService>(() => PopularMoviesService());
}
