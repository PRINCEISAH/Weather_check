import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:weather/bloc/Weather_bloc.dart';
import 'package:weather/bloc/weather_event.dart';
import 'package:weather/bloc/weather_state.dart';
import '../ui/WeartherHomeScreen.dart';
import '../ui/LoadingScreen.dart';

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
          weatherData: state.weather,
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
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
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
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: 200,
                      child: TextField(
                        controller: citytext,
                        decoration: InputDecoration(
                            hintText: "City",
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
