import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaqueryData;
  static double screenheight;
  static double screenWidth;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaqueryData = MediaQuery.of(context);
    screenheight = _mediaqueryData.size.height;
    screenWidth = _mediaqueryData.size.width;
    orientation = _mediaqueryData.orientation;
  }
}

double Getproprateheight(double height) {
  double screenheight = SizeConfig.screenheight;
  return (height / 812.0) * screenheight;
}

double Getpropratewidth(double width) {
  double screenwidth = SizeConfig.screenWidth;
  return (width / 375.0) * screenwidth.toDouble();
}
