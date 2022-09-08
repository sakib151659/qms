import 'package:flutter/cupertino.dart';
import '../../utils/colors_for_app.dart';
import '../../utils/texts_for_app.dart';

class MyTextStyle{
  static regularStyle({Color fontColor = MyColors.primaryTextColor, double fontSize = 14}){
    return TextStyle(
      color: fontColor,
      fontSize: fontSize,
    );
  }
  static regularStyle2({Color fontColor = MyColors.primaryTextColor, double fontSize = 14}){
    return TextStyle(
      color: fontColor,
      fontSize: fontSize,
    );
  }

  static regularStyle3({Color fontColor = MyColors.primaryTextColor, double fontSize = 14}){
    return TextStyle(
      color: fontColor,
      fontSize: fontSize,
    );
  }

  static regularStyle4({Color fontColor = MyColors.primaryTextColor, double fontSize = 14, FontWeight fontWeight = FontWeight.bold}){
    return TextStyle(
      color: fontColor,
      fontSize: fontSize,
      fontWeight: fontWeight
    );
  }
}