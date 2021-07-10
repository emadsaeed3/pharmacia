import 'package:flutter/material.dart';
import 'package:pharma/constants.dart';


class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact US',
          style: TextStyle(color: Colors.white),),
        centerTitle: true,
          backgroundColor: kPrimaryColor
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: 15,
            ),
            Card(
              color: kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  leading: Icon(Icons.call, color: Colors.white),
                  title: Text('Phones',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  subtitle: Text('+20 22222222 / +20 23333333',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Card(
              color: kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  leading: Icon(Icons.wb_cloudy_outlined, color: Colors.white),
                  title: Text('WebSite',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  subtitle: Text('Pharmacia.com',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Card(
              color: kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(Icons.map_outlined, color: Colors.white),
                  title: Text('Location',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Card(
              color: kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ListTile(
                  leading: Icon(Icons.email_outlined, color: Colors.white),
                  title: Text('Email',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  subtitle: Text('contact@pharmacia.com',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.facebook,
                          color: kPrimaryColor,
                          size: 40,
                        ),
                        onPressed: () {}),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.facebook,
                        color: kPrimaryColor,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.facebook,
                        color: kPrimaryColor,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.language_rounded,
                        color: kPrimaryColor,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
