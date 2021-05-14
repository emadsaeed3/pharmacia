import 'package:flutter/material.dart';


class CartFull extends StatefulWidget {
  const CartFull({Key key}) : super(key: key);

  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  @override
  Widget build(BuildContext context) {
    return Container(

      height: 135,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
        bottomRight: const Radius.circular(16.0),
        topRight: const Radius.circular(16.0),
        ),
          color: Theme.of(context).backgroundColor,
        ),
       child: Row(
         children: [
           SizedBox(width: 10),
           Container(
             width: 130,
             decoration: BoxDecoration(image: DecorationImage(
               image: NetworkImage("https://www.pngfind.com/pngs/b/191-1919403_retard-png.png"),
               fit: BoxFit.contain,
             ),),),
           SizedBox(width: 10),
           Flexible(
             child: Column(children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Flexible(child:
                   Text("BRUFEN 600MG 30/TAB",
                     maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                     style: TextStyle(
                     fontWeight: FontWeight.w600, fontSize: 15
                   ),),),
                   Material(
                     color: Colors.transparent,
                     child: InkWell(
                       borderRadius: BorderRadius.circular(32.0),
                       onTap: () {},
                       child: Container(
                         height: 50,
                         width: 50,
                         child: Icon(
                           Icons.delete,
                           color: Colors.red,
                           size: 22,
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
               Row(
                 children: [
                   Text('Price:'),
                   SizedBox(
                     width: 5,
                   ),
                   Text(
                     '31.50	EGP',
                     style:
                     TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                   ),
                 ],
               ),
               Row(
                 children: [
                   Text('Sub Total:'),
                   SizedBox(
                     width: 5,
                   ),
                   Text(
                     '31.50	EGP',
                     style: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.w600,
                         color:
                         Theme.of(context).accentColor),
                   ),
                 ],
               ),
               Row(
                 children: [
                   Text(
                     "Ships Free",style: TextStyle(
                   color: Theme.of(context).accentColor),
                   ),
                   Spacer(),
                   Material(
                     color: Colors.transparent,
                     child: InkWell(
                       borderRadius: BorderRadius.circular(4.0),
                       onTap: () {},
                       child: Container(
                         child: Padding(padding: const EdgeInsets.all(5.0),
                         child: Icon(
                           Icons.remove,
                           color: Colors.red,
                           size: 22,
                         ),
                       ),
                       ),
                     ),
                   ),
                   Card(
                     elevation: 12,
                     child: Container(
                       width: MediaQuery.of(context).size.width * 0.12,
                       padding: const EdgeInsets.all(8.0),
                       child: Text('1', textAlign: TextAlign.center,),
                     ),
                   ),
                   Material(
                     color: Colors.transparent,
                     child: InkWell(
                       borderRadius: BorderRadius.circular(4.0),
                       onTap: () {},
                       child: Container(
                         child: Padding(padding: const EdgeInsets.all(5.0),
                           child: Icon(
                             Icons.add,
                             color: Colors.red,
                             size: 22,
                           ),
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             ],),
           )
         ],
       ),
    );
  }
}
