import 'package:get_it/get_it.dart';
import 'package:zomato_api/DataLayer/auth/local_authentication_service.dart';
import 'package:zomato_api/DataLayer/connection_service.dart';

import '../shared_pref_service.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => LocalAuthenticationService());
  locator.registerLazySingleton(() => SharedPrefService());
  locator.registerLazySingleton(() => ConnectionService());
}
