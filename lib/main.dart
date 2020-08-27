import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather/ViewModel/view.dart';
import 'package:weather/newscreen/myscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: Screen(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherprovider = Provider.of<WeatherViewModel>(context);

    return SafeArea(
      child: Scaffold(
        body: Screen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var temphigh;
  var temprature;
  var humidity;
  var wind;
  var url;
  var respons;
  var data;
  var city;
  bool isLoading = false;

  weather(String location) async {
    setState(() {
      isLoading = true;
    });

    url =
        'http://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&APPID=0c1b6d71bec35b22e23b31daa3645823';

    respons = await http.get(url);
    Timer(Duration(seconds: 5), () {
      setState(() {
        if (respons.statusCode == 200) {
          data = json.decode(respons.body);
          isLoading = false;
          setState(() {
            temphigh = data['main']['temp_max'];
            humidity = data['main']['humidity'];
            city = data['name'];
            temprature = data['main']['temp'].toString();
            wind = data['wind']['speed'];
          });
        } else {
          weather('lokoja');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/image.png'),
                      fit: BoxFit.cover)),
              child: Center(
                child: Container(
                  color: Colors.white,
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Location",
                        enabledBorder: OutlineInputBorder()),
                    onSubmitted: (value) {
                      weather(value);
                    },
                  ),
                ),
              ),
            ),
            if (isLoading) CircularProgressIndicator(),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                      Container(
                        height: 48,
                        width: 154,
                        decoration: BoxDecoration(
                            color: Color(0xfff0D9FEA),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                            )),
                        child: Center(child: Text('$city')),
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
                            Text("Sunny")
                          ],
                        ),
                        Text(
                          "$temprature°C",
                          style: TextStyle(
                            fontSize: 64,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text('$temphigh°C'),
                                Text('27°C')
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
                          valuee: "$humidity",
                        ),
                        Tempcard(
                          imgurl: "images/presure.svg",
                          type: "pressure",
                          valuee: "1,007",
                        ),
                        Tempcard(
                          imgurl: 'images/wind.svg',
                          type: "wind",
                          valuee: "$wind",
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
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
