
import 'package:flutterilkdeneme/services/analytics_services.dart';
import 'package:get_it/get_it.dart';

GetIt  locator = GetIt.instance;

void setUpLoactor(){
  locator.registerLazySingleton(() => AnalysticServices());
}

