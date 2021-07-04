import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:pharma/components/dark_theme_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  ScrollController _scrollController;
  var top = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'User Information',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    userListTile('Name', '', 3, context),
                    userListTile('Email', '', 0, context),
                    userListTile('Phone number', '4555', 1, context),
                    userListTile('Address', "" , 2, context),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: userTitle('User settings'),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTileSwitch(
                      value: themeChange.darkTheme,
                      leading: Icon(CupertinoIcons.moon_circle_fill),
                      onChanged: (value) {
                        setState(() {
                          themeChange.darkTheme = value;
                        });
                      },
                      visualDensity: VisualDensity.comfortable,
                      switchType: SwitchType.cupertino,
                      switchActiveColor: Colors.green,
                      title: Text('Dark theme'),
                    ),
                    userListTile('Logout', '', 4, context),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }



  List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.location_on,
    Icons.person,
    Icons.exit_to_app_rounded
  ];

  Widget userListTile(
      String title, String subTitle, int index, BuildContext context) {
    return Material(
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: () {},
          title: Text(title),
          subtitle: Text(subTitle),
          leading: Icon(_userTileIcons[index]),
        ),
      ),
    );
  }

  Widget userTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }
}
