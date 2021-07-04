import 'package:flutter/material.dart';

Widget defaultTextBox({
  String title,
  String hint = ' ',
  bool isPassword = false,
  @required TextEditingController controller,
  @required TextInputType type,
}) => Container(
  padding: EdgeInsetsDirectional.only(
    start: 15,
    end: 10,
    top: 10,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    color: Colors.grey[200],
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 4,
        offset: Offset(4, 8), // Shadow position
      ),
    ],
  ),
  width: double.infinity,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != null) detailsText(title),
      TextFormField(
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
        controller: controller,
        keyboardType: type,
      ),
    ],
  ),
);

Widget headText(String text) => Text(
  text,
  style: TextStyle(
    fontSize: 25,
  ),
);

Widget captionText(String text) => Text(
  text,
  style: TextStyle(
    fontSize: 16,
  ),
);

Widget detailsText(String text) => Text(
  text,
  style: TextStyle(
    fontSize: 14,
  ),
);