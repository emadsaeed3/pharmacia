import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma/Screens/Home/cubit/state.dart';

class AllPharmaciesCubit extends Cubit<AllPharmaciesStates> {
  AllPharmaciesCubit() : super(AllPharmaciesStateInitial());

  static AllPharmaciesCubit get(context) => BlocProvider.of(context);
  int checkIndex = 0 ;
  List pharmacies = [];
  List pharmaciesID = [];

  allPharmacies() {
    emit(AllPharmaciesStateLoading());
    FirebaseFirestore.instance.collection('pharmacies').get().then((value) {
      emit(AllPharmaciesStateSuccess());
      print('------------${pharmacies}-------------');
      pharmacies = value.docs;
      for (var doc in value.docs) {
        var data = doc.data();
        pharmaciesID.add(doc.id);
      }
    }).catchError((e) {
      emit(AllPharmaciesStateError(e));
    });
  }

  changeIndex(index){
    checkIndex = index ;
    emit(CheckIndexState());
  }
}

