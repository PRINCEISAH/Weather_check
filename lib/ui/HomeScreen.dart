import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weather/ViewModel/view.dart';
import 'package:weather/bloc/Weather_bloc.dart';
import 'package:weather/bloc/weather_event.dart';
import 'package:weather/bloc/weather_state.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/model/weather_model.dart';

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(child: Container(child:
        BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherLoadingFirstState) {
        return FirstState();
      } else if (state is WeatherIsLoadingState) {
        return Loading();
      } else if (state is WeatherError) {
        return Errorstate();
      } else if (state is WeatherIsLoadedState) {
        return IsLoadedScreen(
          weather: state.weather,
        );
      }
    })));
  }

  Widget WeatherIsLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class Errorstate extends StatelessWidget {
  const Errorstate({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = Provider.of<WeatherBloc>(context);
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("error in loading"),
            RaisedButton(
              onPressed: () {
                weatherBloc.add(WeatherErrorRetryEvent());
              },
              child: Text("Retry"),
            )
          ],
        ),
      ),
    );
  }
}

class IsLoadedScreen extends StatelessWidget {
  final WeatherFullModel weather;

  const IsLoadedScreen({Key key, this.weather}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = Provider.of<WeatherBloc>(context);
    TextEditingController CityText = TextEditingController();
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/image.png'), fit: BoxFit.cover)),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.white,
                        width: 200,
                        child: TextField(
                          controller: CityText,
                          decoration: InputDecoration(
                              hintText: "Location",
                              enabledBorder: OutlineInputBorder()),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          weatherBloc.add(WeatherInputCityEvent(CityText.text));
                        },
                        child: Text("check"),
                      )
                    ],
                  ),
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
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Sunday 19 May 2019",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff999999)),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 48,
                        width: 154,
                        decoration: BoxDecoration(
                            color: Color(0xff0D9FEA),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: Center(child: Text("${weather.name}")),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SvgPicture.asset("images/cloud.svg"),
                          Text(""),
                        ],
                      ),
                      Text(
                        "${weather.main.temp ?? 0}°C",
                        style: TextStyle(
                          fontSize: 64,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('${weather.main.tempMax}°C'),
                              Text('${weather.main.tempMin}°C')
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Tempcard(
                        imgurl: "images/humidity.svg",
                        type: "Humidity",
                        valuee: "humidity",
                      ),
                      Tempcard(
                        imgurl: "images/presure.svg",
                        type: "pressure",
                        valuee: "1,007",
                      ),
                      Tempcard(
                        imgurl: 'images/wind.svg',
                        type: "wind",
                        valuee: "23",
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

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class FirstState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController citytext = TextEditingController();
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/image.png'), fit: BoxFit.cover)),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.white,
                        width: 200,
                        child: TextField(
                          controller: citytext,
                          decoration: InputDecoration(
                              hintText: "Location",
                              enabledBorder: OutlineInputBorder()),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          weatherBloc.add(WeatherInputCityEvent(citytext.text));
                        },
                        child: Text("check"),
                      )
                    ],
                  ),
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
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Sunday 19 May 2019",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff999999)),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 48,
                        width: 154,
                        decoration: BoxDecoration(
                            color: Color(0xff0D9FEA),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child: Center(child: Text("")),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SvgPicture.asset("images/cloud.svg"),
                          Text(""),
                        ],
                      ),
                      Text(
                        "enter city°C",
                        style: TextStyle(
                          fontSize: 64,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('°C'),
                              Text('°C'),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Tempcard(
                        imgurl: "images/humidity.svg",
                        type: "Humidity",
                        valuee: "humidity",
                      ),
                      Tempcard(
                        imgurl: "images/presure.svg",
                        type: "pressure",
                        valuee: "1,007",
                      ),
                      Tempcard(
                        imgurl: 'images/wind.svg',
                        type: "wind",
                        valuee: "23",
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

class Tempcard extends StatelessWidget {
  final String imgurl;
  final String valuee;
  final String type;

  const Tempcard({Key key, this.imgurl, this.valuee, this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SvgPicture.asset(imgurl),
          Text(
            valuee,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            type,
            style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: Color(0xff999999)),
          )
        ],
      ),
    );
  }
}
