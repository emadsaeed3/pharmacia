import 'package:flutter/material.dart';

import '../../constants.dart';


class CartEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final themeChange = Provider.of<DarkThemeProvider>(context); // you can watch the dark/light theme tutorial to add it to ur project
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('images/emptycart.png'),
              ),
            ),
          ),
          Text(
            'Your Cart Is Empty',
            textAlign: TextAlign.center,
            style: TextStyle(
                // ignore: deprecated_member_use
                color: Theme.of(context).textSelectionColor,
                fontSize: 36,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Looks Like You didn\'t add anything to your cart yet',
            textAlign: TextAlign.center,
            style: TextStyle(
                color:
                // themeChange.darkTheme
                //?
                //Theme.of(context).disabledColor
                //:
                Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.06,
            // ignore: deprecated_member_use
            child: RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: kPrimaryColor,
              child: Text(
                'shop now'.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    // ignore: deprecated_member_use
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}