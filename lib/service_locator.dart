import 'package:get_it/get_it.dart';

import 'src/services/account_service.dart';
import 'src/services/auth_v3_service.dart';
import 'src/services/auth_v4_service.dart';
import 'src/services/configuration_service.dart';
import 'src/services/details_service.dart';
import 'src/services/download_service.dart';
import 'src/services/lists_services.dart';
import 'src/services/people_service.dart';
import 'src/services/results_service.dart';
import 'src/services/search_service.dart';
import 'src/services/season_service.dart';
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
  sl.registerLazySingleton<AuthV4Service>(() => AuthV4Service());
  sl.registerLazySingleton<AuthV3Service>(() => AuthV3Service());
  sl.registerLazySingleton<AccountService>(() => AccountService());
  sl.registerLazySingleton<ListService>(() => ListService());
  sl.registerLazySingleton<DownloadService>(() => DownloadService());
  sl.registerLazySingleton<SearchService>(() => SearchService());
}
