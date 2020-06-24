import 'package:MyApp/core/services/chat_users_service.dart';
import 'package:get_it/get_it.dart';

import 'core/repositories/agency_repo.dart';
import 'core/repositories/authentication_repo.dart';
import 'core/repositories/chat_repo.dart';
import 'core/repositories/employee_repo.dart';
import 'core/repositories/network_image_repo.dart';
import 'core/services/agency_service.dart';
import 'core/services/authentication_service.dart';
import 'core/services/chat_service.dart';
import 'core/services/map_service.dart';
import 'core/services/messages_service.dart';
import 'core/services/network_image_service.dart';
import 'core/services/socket_service.dart';
import 'core/viewmodels/chat_model.dart';
import 'core/viewmodels/chat_users_model.dart';
import 'core/viewmodels/login_model.dart';
import 'core/viewmodels/agency_model.dart';
import 'core/viewmodels/map_model.dart';
import 'core/viewmodels/messages_model.dart';
import 'core/viewmodels/network_image_model.dart';
import 'core/models/socket.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Socket());

  locator.registerLazySingleton(() => AuthenticationRepo());
  locator.registerLazySingleton(() => AgencyRepo());
  locator.registerLazySingleton(() => NetworkImageRepo());
  locator.registerLazySingleton(() => EmployeeRepo());
  locator.registerLazySingleton(() => ChatRepo());

  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => AgencyService());
  locator.registerLazySingleton(() => NetworkImageService());
  locator.registerLazySingleton(() => MapService());
  locator.registerLazySingleton(() => ChatUsersService());
  locator.registerLazySingleton(() => SocketService());
  locator.registerLazySingleton(() => ChatService());
  locator.registerLazySingleton(() => MessagesService());

  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => AgencyModel());
  locator.registerFactory(() => NetworkImageModel());
  locator.registerFactory(() => MapModel());
  locator.registerFactory(() => ChatUsersModel());
  locator.registerFactory(() => ChatModel());
  locator.registerFactory(() => MessagesModel());

}