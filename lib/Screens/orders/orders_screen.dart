import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma/Screens/confirmation/cubit/cubit.dart';
import 'package:pharma/Screens/confirmation/cubit/state.dart';

import '../../constants.dart';



class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: BlocProvider(
        create: (context) => OrdersCubit()..showOrdersToOrdersScreen(),
        child: BlocConsumer<OrdersCubit, OrdersStates>(
            listener: (context, state) {},
            builder: (context, state) {
              List orders = OrdersCubit.get(context).ordersOrdersScreen;
              List ordersID = OrdersCubit.get(context).ordersIDOrdersScreen;
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
