import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        color: Colors.white10,
        borderRadius: BorderRadius.circular(29.5),
        border: Border.all(
            color: Colors.grey,
            style: BorderStyle.solid,
            width: 1.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          icon: SvgPicture.asset("icons/Search Icon.svg"),
          border: InputBorder.none,
        ),
      ),
    );
  }
}