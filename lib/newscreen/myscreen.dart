import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weather/ViewModel/view.dart';

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  void initState() {
    super.initState();
  }

  var cityname = null ?? "lagos";
  @override
  Widget build(BuildContext context) {
    final weatherprovider = Provider.of<WeatherViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return Material(
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
                            decoration: InputDecoration(
                                hintText: "Location",
                                enabledBorder: OutlineInputBorder()),
                            onChanged: (value) {
                              setState(() {
                                cityname = value;
                              });
                            },
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            weatherprovider.GetApi(cityname);
                            print("check");
                          },
                          child: Text("check"),
                        )
                      ],
                    ),
                  ),
                  weatherprovider.iisloading == false
                      ? Container()
                      : CircularProgressIndicator()
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
                      Container(
                        height: 48,
                        width: 154,
                        decoration: BoxDecoration(
                            color: Color(0xff0D9FEA),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                topRight: Radius.circular(40))),
                        child:
                            Center(child: Text('${weatherprovider.CityyName}')),
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
                          "${weatherprovider.temp}°C",
                          style: TextStyle(
                            fontSize: 64,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[Text('35°C'), Text('27°C')],
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
