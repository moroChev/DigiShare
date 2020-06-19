import 'package:get_it/get_it.dart';

import 'core/repositories/agency_repo.dart';
import 'core/repositories/authentication_repo.dart';
import 'core/repositories/network_image_repo.dart';
import 'core/services/agency_service.dart';
import 'core/services/authentication_service.dart';
import 'core/services/map_service.dart';
import 'core/services/network_image_service.dart';
import 'core/viewmodels/login_model.dart';
import 'core/viewmodels/agency_model.dart';
import 'core/viewmodels/map_model.dart';
import 'core/viewmodels/network_image_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationRepo());
  locator.registerLazySingleton(() => AgencyRepo());
  locator.registerLazySingleton(() => NetworkImageRepo());

  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => AgencyService());
  locator.registerLazySingleton(() => NetworkImageService());
  locator.registerLazySingleton(() => MapService());

  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => AgencyModel());
  locator.registerFactory(() => NetworkImageModel());
  locator.registerFactory(() => MapModel());
}