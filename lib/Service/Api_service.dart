import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/model/weather.dart';
import 'package:weather/model/weather_model.dart';

class WeatherApi {
  GetApi(String location) async {
    var url =
        'http://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&APPID=0c1b6d71bec35b22e23b31daa3645823';
    var data;
    var weatherData;
    var responds = await http.get(url);
    if (responds.statusCode == 200) {
      print("succesfully fetch");
      data = jsonDecode(responds.body);
      print(data);
      weatherData = data['main'];
    } else {
      throw Exception("city not found");
    }
    return WeatherFullModel.fromJson(data);
  }
}
