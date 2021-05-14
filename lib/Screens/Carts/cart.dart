import 'package:pharma/Screens/Carts/cart_empty.dart';
import 'package:pharma/Screens/Carts/cart_full.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List products =[];
    return !products.isEmpty? Scaffold(
      body:  CartEmpty()
    ): Scaffold(
        bottomSheet: checkoutSection(context),
        appBar: AppBar(
        title: Text('Cart Items Count'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          )
        ],
      ),
        body: Container(
          margin: EdgeInsets.only(bottom: 60),
          child: ListView.builder(itemCount: 5,itemBuilder: (BuildContext ctx, int index){
            return CartFull();
          }),
        ));
  }
  Widget checkoutSection (BuildContext ctx){
    return Container(
        decoration: BoxDecoration(
        border: Border(
        top: BorderSide(color: Colors.grey, width: 0.5),),
    ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
        Expanded(
          flex: 2,
          child: Material(
            borderRadius: BorderRadius.circular(30),
            color: kPrimaryColor,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: (){},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
              child: Text("Check Out",textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(ctx).textSelectionTheme.selectionColor, fontSize: 18, fontWeight: FontWeight.w600),),
            ),
    ),
          ),
        ),
        Spacer(),
        Text("Total: ",
          style: TextStyle(color: Theme.of(ctx).textSelectionTheme.selectionColor, fontSize: 18, fontWeight: FontWeight.w600),),
        Text( '31.50	EGP',
          style: TextStyle(color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.w500),),
      ],),
    ),
    );
  }
}