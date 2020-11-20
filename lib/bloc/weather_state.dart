import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:weather/model/weather_model.dart';

abstract class WeatherState extends Equatable {}

class WeatherLoadingFirstState extends WeatherState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class WeatherFirstState extends WeatherState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class WeatherIsLoadingState extends WeatherState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WeatherIsLoadedState extends WeatherState {
  final WeatherFullModel weather;

  WeatherIsLoadedState({@required this.weather});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class WeatherError extends WeatherState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
