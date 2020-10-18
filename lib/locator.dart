


import 'package:eventapp/services/auth.dart';
import 'package:eventapp/services/cloud_storage_service.dart';
import 'package:eventapp/services/database.dart';
import 'package:eventapp/services/dialog_service.dart';
import 'package:eventapp/services/navigation_service.dart';
import 'package:eventapp/utils/image_selector.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator(){

  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());

}