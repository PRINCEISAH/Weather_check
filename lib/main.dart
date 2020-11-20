import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather/bloc/Weather_bloc.dart';
import 'package:weather/bloc/weather_state.dart';
import 'package:weather/service_locator.dart';
import 'package:weather/ui/HomeScreen.dart';

void main() {
  setuplocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: MultiBlocProvider(providers: [
          BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(),
          ),
        ], child: MyHomeScreen()));
  }
}
