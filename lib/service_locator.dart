import 'package:get_it/get_it.dart';
import 'package:movie_app/src/services/configuration_service.dart';
import 'package:movie_app/src/services/results_service.dart';

final sl = GetIt.instance;

void setUp() {
  sl.registerLazySingleton<ResultsService>(() => ResultsService());
  sl.registerLazySingleton<ConfigurationService>(() => ConfigurationService());
}
