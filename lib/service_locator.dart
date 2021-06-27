import 'package:get_it/get_it.dart';
import 'package:movie_app/src/services/auth_service.dart';
import 'package:movie_app/src/services/configuration_service.dart';
import 'package:movie_app/src/services/details_service.dart';
import 'package:movie_app/src/services/people_service.dart';
import 'package:movie_app/src/services/results_service.dart';
import 'package:movie_app/src/services/season_service.dart';

import 'src/services/trending_results_service.dart';

final sl = GetIt.instance;

void setUp() {
  sl.registerLazySingleton<ConfigurationService>(() => ConfigurationService());
  sl.registerLazySingleton<ResultsService>(() => ResultsService());
  sl.registerLazySingleton<TrendingResultsService>(
      () => TrendingResultsService());
  sl.registerLazySingleton<DetailsService>(() => DetailsService());
  sl.registerLazySingleton<PeopleService>(() => PeopleService());
  sl.registerLazySingleton<SeasonService>(() => SeasonService());
  sl.registerLazySingleton<AuthService>(() => AuthService());
}
