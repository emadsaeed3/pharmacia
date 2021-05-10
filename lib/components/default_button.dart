import 'package:flutter/material.dart';
import 'package:pharma/size_config.dart';
import 'package:pharma/constants.dart';


class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key key,
     this.icon,
     this.text,
     this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(30),
    ),
    child: buildContent(),
    onPressed: onClicked,
  );

  Widget buildContent() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 28),
      SizedBox(width: 16),
      Text(
        text,
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    ],
  );
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      // ignore: deprecated_member_use
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: kPrimaryColor,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal *  18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

