import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:pharma/Config/config.dart';
import 'package:pharma/components/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool _value = false;
  ScrollController _scrollController;
  var top = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController =ScrollController();
    _scrollController.addListener(() {setState(() {

    });});
  }
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 4,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      top = constraints.biggest.height;
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFF73B865),
                                Color(0xFFF3F9F1),
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          centerTitle: true,
                          title: Row(
                            //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 300),
                                opacity: top <= 110.0 ? 1.0 : 0,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      height: kToolbarHeight / 2,
                                      width: kToolbarHeight / 2,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              "https://graph.facebook.com/v9.0/4370052006338772/picture?height=100&width=100&migration_overrides=%7Boctober_2012%3Atrue%7D&access_token=EABDynRYpkygBAJo7BM2ZBnvGIs1plOqMF5Vjf370CoQ3DgW7qYDk0DZBRUsZAo9AqxAs0oCGBYHwZAxpczsJPZCsCZCdZBeZCsdFZArpZC06GB3Y1FfbE9qL1GOV2w9Tgr5ZAqyNI8Y3BlvmuemBTxZB9KRanKWqophuUx8WzfV9ZBZAD055GeeZARNYDgU9aZAMDRncEzel4aQVlQw7C7cDgDcN26Yf8HzYQfZAYFNkhuaTrjSNAQLs5dcxJrLsE"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      // 'top.toString()',
                                      '${auth.displayName}',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          background: Image(
                            image: NetworkImage(
                              "https://graph.facebook.com/v9.0/4370052006338772/picture?height=100&width=100&migration_overrides=%7Boctober_2012%3Atrue%7D&access_token=EABDynRYpkygBAJo7BM2ZBnvGIs1plOqMF5Vjf370CoQ3DgW7qYDk0DZBRUsZAo9AqxAs0oCGBYHwZAxpczsJPZCsCZCdZBeZCsdFZArpZC06GB3Y1FfbE9qL1GOV2w9Tgr5ZAqyNI8Y3BlvmuemBTxZB9KRanKWqophuUx8WzfV9ZBZAD055GeeZARNYDgU9aZAMDRncEzel4aQVlQw7C7cDgDcN26Yf8HzYQfZAYFNkhuaTrjSNAQLs5dcxJrLsE"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    }),
              ),
              SliverToBoxAdapter(

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle('User Information')),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    userListTile('Email', '${auth.email}', 0, context),
                    userListTile('Email', 'Email sub', 0, context),
                    userListTile('Email', 'Email sub', 0, context),
                    userListTile('Email', 'Email sub', 0, context),
                    userListTile('Email', 'Email sub', 0, context),
                    userListTile('Phone number', '4555', 0, context),
                    userListTile('Shipping address', '', 0, context),
                    userListTile('joined date', 'date', 0, context),
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
          _buildFab()
        ],
      ),
    );
  }


  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return  Positioned(
      top: top,
      right: 16.0,
      child:  Transform(
        transform:  Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child:  FloatingActionButton(
          heroTag: "btn1",
          onPressed: (){},
          child:  Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
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
