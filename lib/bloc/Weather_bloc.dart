import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/Service/Api_service.dart';
import 'package:weather/bloc/weather_state.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/service_locator.dart';
import '../bloc/weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  // TODO: implement initialState
  WeatherState get initialState => WeatherLoadingFirstState();

  @override
  Stream<WeatherState> mapEventToState(event) async* {
    if (event is WeatherInputCityEvent) {
      yield WeatherIsLoadingState();
      try {
        final _api = locator<WeatherApi>();
        final WeatherFullModel weather = await _api.GetApi(event.cityName);
        yield WeatherIsLoadedState(weather: weather);
      } catch (e) {
        yield WeatherError();
      }
    } else if (event is WeatherErrorRetryEvent) {
      yield WeatherLoadingFirstState();
    }
  }
}
