import 'package:flutter/material.dart';
import 'package:pharma/Screens/Welcome/components/background.dart';
import 'package:pharma/size_config.dart';
import 'package:pharma/constants.dart';
import 'complete_profile_form.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Background(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                Text("Complete Profile", style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.safeBlockHorizontal * 40,
                  fontWeight: FontWeight.bold,
                ),
                ),
                Text(
                  "Complete your details or continue  \nwith social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                CompleteProfileForm(),
                SizedBox(height: SizeConfig.safeBlockVertical  * 30),
                Text(
                  "By continuing your confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
