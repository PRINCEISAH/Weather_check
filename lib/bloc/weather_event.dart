import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {}

class WeatherInputCityEvent extends WeatherEvent {
  final String cityName;

  WeatherInputCityEvent(this.cityName);
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WeatherErrorRetryEvent extends WeatherEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EnterWeatherCityEvent extends WeatherEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
