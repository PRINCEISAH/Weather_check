import 'package:get_it/get_it.dart';
import 'package:weather/Service/Api_service.dart';

GetIt locator = GetIt.instance;

void setuplocator() {
  locator.registerLazySingleton(() => WeatherApi());
}
