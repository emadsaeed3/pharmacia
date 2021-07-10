import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharma/constants.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us',style: TextStyle(color: Colors.white),),
        centerTitle: true,
          backgroundColor: kPrimaryColor
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/launch_icon.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('Pharmacia',style: TextStyle(color: kPrimaryColor,fontSize: 20),),
                      ],
                    ),
                  ),
                ),
                Text('Who We are ?',style: TextStyle(color: kPrimaryColor,fontSize: 18),),
                SizedBox(height: 12,),
                Text('The largest electronic application that aims to serve the field of medicine in Egypt by providing medicine online to customers through the nearest pharmacies to them for free without additional fees and also providing services to them.'),
                SizedBox(height: 20,),
                Text('Request medication by uploading a picture of the prescription: We provide our customers with ordering medication by uploading the picture of the prescription or the picture of the medication, where the customer\'s request is reviewed by a pharmacist on a special page for the customer to ensure confidentiality.'),
                SizedBox(height: 20,),
                Text('Fast delivery and available medicines: Do not worry if the medicine is not available in the pharmacy near you, as we offer pharmacies that have all the required medicines available. Pharmacia will bring out the nearest pharmacies to you via GPS technology'),
                SizedBox(height: 20,),
                Text('Easily buy medicine and pay on delivery: Easy purchase steps where the customer can finish the purchase process in three steps and in less than two minutes'),
                SizedBox(height: 20,),
                Text('Our goal is to provide you with an excellent medical service and we thank you for giving us the confidence to serve you.',textAlign: TextAlign.center,style: TextStyle(color: kPrimaryColor,fontSize: 20,fontWeight: FontWeight.bold)),
                SizedBox(height: 20,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
