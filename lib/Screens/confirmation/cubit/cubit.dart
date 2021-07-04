import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma/Screens/confirmation/cubit/state.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(OrdersStateInitial());

  static OrdersCubit get(context) => BlocProvider.of(context);

  List orders = [];
  List ordersID = [];

  List ordersOrdersScreen = [];
  List ordersIDOrdersScreen = [];



  var user = FirebaseAuth.instance.currentUser ;

  showOrders(){
    emit(OrdersStateLoading());
    FirebaseFirestore.instance.collection('orders').get().then((value){
      print('$value');
      for(var doc in value.docs ) {
        if(doc['userId']==user.uid.toString()){
          orders.add(doc.data());
        }
      }
      for(var doc in value.docs ) {
        if(doc['userId']==user.uid.toString()){
          ordersID.add(doc.id);
        }
      }
      emit(OrdersStateSuccess());
    }).catchError((e){
      emit(OrdersStateError(e));
    });
  }
  showOrdersToOrdersScreen(){
    emit(OrdersStateLoading());
    FirebaseFirestore.instance.collection('orders').get().then((value){
      print('$value');
      for(var doc in value.docs ) {
        if(doc['userId']==user.uid.toString()){
          if(doc['canCancel'] == 'false'){
            ordersOrdersScreen.add(doc.data());
          }
        }
      }
      for(var doc in value.docs ) {
        if(doc['userId']==user.uid.toString()){
          if(doc['canCancel'] == 'false') {
            ordersIDOrdersScreen.add(doc.id);
          }
        }
      }
      emit(OrdersStateSuccess());
    }).catchError((e){
      emit(OrdersStateError(e));
    });
  }

  Future<void> deleteMeal({documentId,index}) async {
    return await FirebaseFirestore.instance.collection('orders')
        .doc(documentId[index].toString())
        .delete();
  }



}