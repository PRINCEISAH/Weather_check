import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:weather/model/weather.dart';

class WeatherViewModel extends ChangeNotifier {
  Weather _weather;
  get Weathertemprature => _weather.temprature;

  bool isloading = false;
  get CityyName => _cityname;

  var _cityname;
  void GetApi(String location) async {
    isloading = true;
    var city;
    var url =
        'http://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&APPID=0c1b6d71bec35b22e23b31daa3645823';
    var data;
    var responds = await http.get(url);
    if (responds.statusCode == 200) {
      isloading = false;
      print("succesfully fetch");
      data = jsonDecode(responds.body);
      print(data['main']);
    }
    _cityname = data['name'];

    _weather = Weather.formJson(data['main']);
    notifyListeners();
  }
}
