import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma/Screens/Home/home_screen.dart';
import 'package:pharma/Screens/Home/menu_dashboard_layout.dart';
import 'package:pharma/Screens/confirmation/cubit/cubit.dart';
import 'package:pharma/Screens/confirmation/cubit/state.dart';
import 'package:pharma/components/defultButton.dart';
import 'package:pharma/components/navigations.dart';
import 'package:pharma/constants.dart';

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirmation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            navigateAndFinish(context, MainScreen());
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => OrdersCubit()..showOrders(),
        child: BlocConsumer<OrdersCubit, OrdersStates>(
            listener: (context, state) {},
            builder: (context, state) {
              List orders = OrdersCubit.get(context).orders;
              List mealsId = OrdersCubit.get(context).ordersID;
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Address: ${orders[index]['userAddress']}',
                                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'orderType: ${orders[index]['orderType']}',
                                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Pharmacies Name: ${orders[index]['pharmaciesName']}',
                                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                if(orders[index]['canCancel']=='true')
                                  Center(child: defaultButtonWithOutIcon(function: (){
                                    OrdersCubit.get(context).deleteMeal(documentId:mealsId,index: index);
                                    navigateAndFinish(context, ConfirmationScreen());

                                  },
                                      text: 'Cancel order',
                                      background: Colors.red,width: 200,

                                  )
                                  ),
                              ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: orders.length,
                ),
              );
            }),
      ),
    );
  }
}
