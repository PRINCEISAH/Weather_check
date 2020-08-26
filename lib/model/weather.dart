class Weather {
  final String temprature;
  final String pressure;
  final String humidity;
  final String temhight;
  final String tempLow;

  Weather(
      {this.temprature,
      this.pressure,
      this.humidity,
      this.temhight,
      this.tempLow});

  factory Weather.formJson(Map<String, dynamic> json) {
    return Weather(
      temprature: json['temp'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      temhight: json['tem_min'],
      tempLow: json['tem_max'],
    );
  }
}
