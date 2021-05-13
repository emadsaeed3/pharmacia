import 'package:flutter/material.dart';
import '../constants.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(29.5),
      ),
      child: TextField(
        onChanged: (value) => print(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15),
          hintText: "Search",
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
            prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}