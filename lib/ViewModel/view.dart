import 'package:flutter/foundation.dart';
import 'package:weather/Service/Api_service.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/service_locator.dart';

class WeatherViewModel extends ChangeNotifier {
  Weather _weather;

  num _temprature = null ?? 0;
  String _cityName = "";
  String _cloudStatus = null ?? '';
  num _setTempMax = null ?? 0;
  num _setTempMin = null ?? 0;

  get getcloudstatus => _cloudStatus;
  get Temprature => _temprature.toInt();
  get cityName => _cityName;
  get temMin => _weather.tempMin.toInt();
  get getTempMax => _setTempMax.toInt();
  get getTempMin => _setTempMin.round();
  final _api = locator<WeatherApi>();
  Weather get weather => _weather;
  Future getWeather(String location) async {
    var weatherApiREQ = await _api.GetApi(location);
    if (weatherApiREQ is String) {
      throw Exception("error try again");
    } else
      _weather = Weather.formJson(weatherApiREQ['main']);
    _cityName = weatherApiREQ['name'];
    _temprature = _weather.temprature;
    _setTempMax = _weather.temMax;
    _setTempMin = _weather.tempMin;
    _cloudStatus = weatherApiREQ['coord']['Ion'];
    notifyListeners();
  }
}
