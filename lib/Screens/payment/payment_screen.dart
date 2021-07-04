import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma/Screens/confirmation/confirmation_screen.dart';
import 'package:pharma/Screens/payment/cubit/cubit.dart';
import 'package:pharma/Screens/payment/cubit/state.dart';
import 'package:pharma/components/build_progress.dart';
import 'package:pharma/components/defaultTextFormField.dart';
import 'package:pharma/components/defultButton.dart';
import 'package:pharma/components/navigations.dart';
import 'package:pharma/constants.dart';

class PaymentScreen extends StatelessWidget {
  var pharmacies;
  String orderType ;
  var address;


  PaymentScreen(this.pharmacies, this.orderType, this.address);

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment',style: TextStyle(color: Colors.white),),
        backgroundColor: kPrimaryColor,
      ),
      body: BlocProvider(
        create: (context)=> PaymentCubit(),
        child: BlocConsumer<PaymentCubit,PaymentStates>(
          listener: (context,state){
            if(state is OrderStateLoading){
              return
                buildProgress(
                  context: context,
                  text: 'Loading....',
                );
            }
            if(state is OrderStateSuccess){
              navigateAndFinish(context, ConfirmationScreen());

            }
          },
          builder: (context,state){
            int checkIndex = PaymentCubit.get(context).checkIndex;
            return  ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 10.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              SizedBox(height: 16,),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      PaymentCubit.get(context)
                                          .changeIndex(1);
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(
                                                60.0)),
                                        color: checkIndex == 1
                                            ? kPrimaryColor
                                            : Colors.white,
                                        border: Border.all(
                                          color: kPrimaryColor,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: Center(
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 15,
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 24,),
                                  Icon(Icons.monetization_on_sharp,color: Colors.blueAccent,size: 30,),
                                  SizedBox(width: 6,),
                                  Text('Cash on delivery',style: TextStyle(fontSize: 16),),
                                ],
                              ),
                              SizedBox(height: 16,),
                              Divider(height: 1,color: Colors.grey,),
                              SizedBox(height: 16,),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      PaymentCubit.get(context)
                                          .changeIndex(2);
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(
                                                60.0)),
                                        color: checkIndex == 2
                                            ? kPrimaryColor
                                            : Colors.white,
                                        border: Border.all(
                                          color: kPrimaryColor,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: Center(
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 15,
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 24,),
                                  Icon(Icons.credit_card_rounded,color: Colors.blueAccent,size: 30,),
                                  SizedBox(width: 6,),
                                  Text('Credit Card',style: TextStyle(fontSize: 16),),
                                ],
                              ),
                              SizedBox(height: 16,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ConditionalBuilder(
                      condition: checkIndex == 2,
                      builder: (context)=> Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height/1.6,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),

                              elevation: 16.0,
                              child: Column(
                                children: [
                                  SizedBox(height: 6,),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: defaultTextBox(
                                      title: 'Card Number',
                                      hint: '1234 7843 1237 1279',
                                      type: TextInputType.number,
                                      controller: cardNumberController,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: defaultTextBox(
                                      title: 'Expiry Date',
                                      hint: '19/08/2020',
                                      type: TextInputType.number,
                                      controller: expiryDateController,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: defaultTextBox(
                                      title: 'CVV',
                                      hint: '6584',
                                      type: TextInputType.number,
                                      controller: expiryDateController,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: defaultTextBox(
                                      title: 'Card Owner Name',
                                      hint: 'Emad Saaed',
                                      type: TextInputType.text,
                                      controller: expiryDateController,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      fallback: (context)=> SizedBox(height: 1,),
                    ),
                    SizedBox(height: 30,),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: defaultButtonWithOutIcon(
                          width: MediaQuery.of(context).size.width,
                          function: (){
                            PaymentCubit.get(context).makeOrder(
                              address: '${address.toString()}',
                              orderType: '${orderType.toString()}',
                              pharmaciesName: '${pharmacies.toString()}',
                            );
                          },
                          text: 'Confirm Payment',
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                  ],
                ),
              ],
            );
          },

        ),
      ),
    );
  }
}
