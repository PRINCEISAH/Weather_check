import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/SizeConfig/sizeConfig.dart';
import 'package:weather/bloc/Weather_bloc.dart';
import 'package:weather/bloc/weather_event.dart';
import 'package:weather/main.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/ui/HomeScreen.dart';

class IsLoadedScreen extends StatelessWidget {
  final WeatherFullModel weatherData;

  const IsLoadedScreen({Key key, this.weatherData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    TextEditingController CityText = TextEditingController();

    return Container(
      height: SizeConfig.screenheight,
      width: SizeConfig.screenWidth,
      child: Column(
        children: <Widget>[
          Container(
            height: Getproprateheight(300),
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/image.png'), fit: BoxFit.cover)),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
//                  color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
            ),
            child: Column(
              children: <Widget>[
                Date_location(weather: weatherData),
                SizedBox(
                  height: Getproprateheight(37),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SvgPicture.asset("images/cloud.svg"),
                          Text(
                              "${weatherData.weather.elementAt(0).description}"),
                        ],
                      ),
                      Text(
                        "${weatherData.main.temp.toInt()}°C",
                        style: TextStyle(
                          fontSize: 64,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  Text('${weatherData.main.tempMax.toInt()}°C'),
                                  SvgPicture.asset('images/arrow.svg')
                                ],
                              ),
                              Row(
                                children: [
                                  Text('${weatherData.main.tempMin.toInt()}°C'),
                                  SvgPicture.asset('images/arrowdown.svg')
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Getproprateheight(40),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45, right: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Tempcard(
                        imgurl: "images/humidity.svg",
                        type: "Humidity",
                        valuee: "${weatherData.main.humidity.toInt()}",
                      ),
                      Tempcard(
                        imgurl: "images/presure.svg",
                        type: "pressure",
                        valuee: "${weatherData.main.pressure}",
                      ),
                      Tempcard(
                        imgurl: 'images/wind.svg',
                        type: "wind",
                        valuee: "${weatherData.wind.deg}km/h",
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Date_location extends StatelessWidget {
  const Date_location({
    Key key,
    @required this.weather,
  }) : super(key: key);

  final WeatherFullModel weather;

  @override
  Widget build(BuildContext context) {
    WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(
            "Sunday 19 May 2019",
            style: TextStyle(fontSize: 14, color: Color(0xff999999)),
          ),
        ),
        Spacer(),
        InkWell(
          onTap: () {
            weatherBloc.add(EnterWeatherCityEvent());
          },
          child: Container(
            height: 48,
            width: 154,
            decoration: BoxDecoration(
                color: Color(0xffecf7fd),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${weather.name}, ${weather.sys.country}",
                  style: TextStyle(color: Color(0xff0DA0EA), fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: SvgPicture.asset("images/location.svg"),
                )
              ],
            )),
          ),
        )
      ],
    );
  }
}

class Entercity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
