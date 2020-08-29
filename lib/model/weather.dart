class Weather {
  final num temprature;
  final num pressure;
  final num humidity;
  final num temMax;
  final num tempMin;

  Weather(
      {this.temprature,
      this.pressure,
      this.humidity,
      this.temMax,
      this.tempMin});

  factory Weather.formJson(Map<String, dynamic> json) {
    return Weather(
      temprature: json['temp'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      temMax: json['temp_max'],
      tempMin: json['temp_min'],
    );
  }
}
