import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../size_config.dart';

class SocalCard extends StatelessWidget {
  const SocalCard({
    Key key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin:
        EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon, height: 14
          ),
      ),
    );
  }
}
