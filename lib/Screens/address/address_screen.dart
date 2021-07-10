import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma/Screens/address/cubit/cubit.dart';
import 'package:pharma/Screens/address/cubit/state.dart';
import 'package:pharma/Screens/payment/payment_screen.dart';
import 'package:pharma/components/build_progress.dart';
import 'package:pharma/components/defultButton.dart';
import 'package:pharma/components/navigations.dart';
import 'package:pharma/constants.dart';

class AddressScreen extends StatelessWidget {
  var pharmacies;
  String orderType ;

  AddressScreen(this.pharmacies,this.orderType);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> AddressCubit()..getAddress(),
      child: BlocConsumer<AddressCubit,AddressStates>(
        listener: (context,state){

          if(state is AddAddressStateLoading){
            return
           buildProgress(
             context: context,
             text: 'Loading....',);}

          if(state is AddAddressStateSuccess){
            Navigator.pop(context);
            Navigator.pop(context);
            navigateTo(context, AddressScreen(pharmacies,'$orderType'));
          }

          if(state is DeleteAddressStateSuccess){
            Navigator.pop(context);
            Navigator.pop(context);
            navigateTo(context, AddressScreen(pharmacies,'$orderType'));
          }

          if(state is DeleteAddressStateLoading){
            return
              buildProgress(
                context: context,
                text: 'Loading....',);}},
        builder: (context,state){
          List address = AddressCubit.get(context).address;
          List addressId = AddressCubit.get(context).addressID;
          int checkIndex = AddressCubit.get(context).checkIndex;

          return Scaffold(
            appBar: AppBar(
              title: Text('Confirm Your Address',style: TextStyle(color: Colors.white),),
              backgroundColor: kPrimaryColor,
            ),
            body: Column(
              children: [
                ConditionalBuilder(
                  condition: address.length != 0,
                  builder: (context)=> Container(
                    height: MediaQuery.of(context).size.height/2,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 16.0,
                        child: ListView.separated(
                          itemBuilder: (context,index)=> Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined,size: 40,color: kPrimaryColor),
                                    SizedBox(width: 12,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Home',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                          SizedBox(height: 8,),
                                          Text('${address[index]['Address']}' ,
                                            maxLines: 3, softWrap: true, overflow: TextOverflow.ellipsis,),],),),
                                    SizedBox(width: 16,),
                                    GestureDetector(
                                      onTap: () {AddressCubit.get(context).changeIndex(index);},
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(60.0)),
                                          color: checkIndex == index
                                              ? kPrimaryColor
                                              : Colors.white,
                                          border: Border.all(
                                            color: kPrimaryColor,
                                            width: 2.0,),),
                                        child: ClipOval(
                                          child: Center(
                                              child: Icon(Icons.check, color: Colors.white, size: 22,)),),),),],),
                                SizedBox(height: 10,),
                                TextButton(onPressed: (){
                                  AddressCubit.get(context).deleteAddress(
                                    documentIdList: addressId,
                                    index: index,);}, child: Text('Delete Address',style: TextStyle(color: Colors.red),)),],),) ,
                          separatorBuilder: (context,index)=> Column(
                            children: [Divider(height: 2, color: Colors.grey,),],),
                          itemCount: address.length,),),),),
                  fallback: (context)=> SizedBox(height: 1,),),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: (){AddressCubit.get(context).addAddress();},
                    child: Row(
                      children: [
                        Icon(Icons.add,color:kPrimaryColor,size:40,),
                        SizedBox(width: 20,),
                        Text('Add New Address',style: TextStyle(color: kPrimaryColor ,fontWeight: FontWeight.bold,fontSize: 20),)],),),),
                SizedBox(height: 80,),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: defaultButtonWithOutIcon(
                        width: MediaQuery.of(context).size.width,
                        function: (){
                          navigateTo(context, PaymentScreen(
                              '$pharmacies',
                              '$orderType',
                             '${address[checkIndex]['Address']}',));}, text: 'Confirm Address',),),),],),);},),);}}
