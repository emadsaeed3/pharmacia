

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pharma/Screens/address/cubit/state.dart';

class AddressCubit extends Cubit<AddressStates> {
  AddressCubit() : super(AddressStateInitial());

  static AddressCubit get(context) => BlocProvider.of(context);
  int checkIndex = 0 ;
  List address = [];
  List addressID = [];

  var currentPosition ;
  var currentAddress ;
  String area ;
  String subArea ;
  String country ;
  String street ;

  var user = FirebaseAuth.instance.currentUser ;

  getAddress() {
    emit(ShowAddressStateLoading());
    FirebaseFirestore.instance.collection('address').get().then((value) {
      emit(ShowAddressStateSuccess());
      print('------------${address}-------------');
      for (var doc in value.docs) {
        if(doc['userId']==user.uid.toString()){
          address.add(doc.data());
          addressID.add(doc.id);
        }
      }
    }).catchError((e) {
      emit(ShowAddressStateError(e));
    });
  }

  addAddress(){
    emit(AddAddressStateLoading());
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true)
        .then((Position position) async{
          print('$position');
          currentPosition = position;
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = placeMarks[0];
        currentAddress =
        "${place.street} , ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";

        area =  "${place.subAdministrativeArea}";
        subArea = " ${place.administrativeArea}";
        country = "${place.country}";
        street =  "${place.street}";
    }).catchError((e) {
      print(e);
    }).then((value){
      FirebaseFirestore.instance.collection('address').add({
        'Address': '${currentAddress.toString()}',
        'userId': '${user.uid}',
      }).then((value) async{
        emit(AddAddressStateSuccess());

      }).catchError((e){
        emit(AddAddressStateError(e.toString()));
      });
    });
  }

  Future<void> deleteAddress({documentIdList,index}) async {
    emit(DeleteAddressStateLoading());
    return await FirebaseFirestore.instance.collection('address')
        .doc(documentIdList[index].toString())
        .delete().then((value) {
      emit(DeleteAddressStateSuccess());
    }).catchError((e){
      emit(DeleteAddressStateError(e.toString()));
    });
  }


  changeIndex(index){
    checkIndex = index ;
    emit(CheckIndexState());
  }


}