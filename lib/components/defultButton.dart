

import 'package:flutter/material.dart';
import 'package:pharma/constants.dart';

Widget defaultButton({
  Color background = Colors.white,
  double radius = 25.0,
  @required double width ,
  @required Function function,
  @required String text,
  bool toUpper = true,
  @required IconData icon ,
}) => Container(
  width: width,
  height: 40.0,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
  child: FlatButton(
    onPressed: function,
    child: Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: Colors.green),
          SizedBox(width: 6,),
          Text(
            toUpper ? text.toUpperCase() : text,
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ],
      ),
    ),
  ),
);

Widget defaultButtonWithOutIcon({
  Color background = kPrimaryColor,
  Color textColor = Colors.white,
  double radius = 12.0,
  double fontSize = 14.0,
  double width ,
  double height,
  @required function,
  @required text,
  bool toUpper = true,
  context,
}) =>
    Container(
      height: height != null ? height : 40.0,
      width: width != null ? width : 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: function,
        child: Text(
          toUpper ? text.toUpperCase() : text,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ),
    );