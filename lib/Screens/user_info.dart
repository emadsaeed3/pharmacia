import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    super.initState();
    _scrollController =ScrollController();
    _scrollController.addListener(() {setState(() {

    });});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Information', style: TextStyle(color: Colors.white),),
        backgroundColor: kPrimaryColor,),
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
                    userListTile('Name', '', 0, context),
                    userListTile('Email', 'Email sub', 1, context),
                    userListTile('Phone number', '4555', 2, context),
                    Divider(thickness: 1, color: Colors.grey,),
                    userListTile('Logout', '', 3, context),],),)],),
          _buildFab()],),);}


  Widget _buildFab() {
    final double defaultTopMargin = 200.0 - 4.0;
    final double scaleStart = 160.0;
    final double scaleEnd = scaleStart / 2;
    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        scale = 0.0;
      }
    }

    return  Positioned(
      top: top,
      right: 16.0,
      child:  Transform(
        transform:  Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
      ),
    );
  }

  List<IconData> _userTileIcons = [
    Icons.person_outline,
    Icons.mail,
    Icons.phone,
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


abstract class AllUsersStates {}
class AllUsersStateInitial extends AllUsersStates {}
class AllUsersStateLoading extends AllUsersStates {}
class AllUsersStateSuccess extends AllUsersStates {}
class AllUsersStateError extends AllUsersStates
{final error;
AllUsersStateError(this.error);}
class CheckIndexState extends AllUsersStates {}

class AllUsersCubit extends Cubit<AllUsersStates> {
  AllUsersCubit() : super(AllUsersStateInitial());

  static AllUsersCubit get(context) => BlocProvider.of(context);
  int checkIndex = 0 ;
  List users = [];
  List userID = [];

  allUsers() {
    emit(AllUsersStateLoading());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      emit(AllUsersStateSuccess());
      print('------------${users}-------------');
      users = value.docs;
      for (var doc in value.docs) {
        var data = doc.data();
        userID.add(doc.id);
      }
    }).catchError((e) {
      emit(AllUsersStateError(e));
    });
  }

  changeIndex(index){
    checkIndex = index ;
    emit(CheckIndexState());
  }
}