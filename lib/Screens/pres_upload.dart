import 'package:flutter/material.dart';


// class PreUpload extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           height: 135,
//           margin: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               bottomRight: const Radius.circular(16.0),
//               topRight: const Radius.circular(16.0),
//             ),
//             color: Theme.of(context).backgroundColor,
//           ),
//           // margin: const EdgeInsets.symmetric(vertical: 40,horizontal: 200),
//
//           child: Text('Easy Process',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)
//       ),
//     );
//   }
// }


class PreUpload extends StatefulWidget {
  const PreUpload({Key key}) : super(key: key);

  @override
  _PreUploadState createState() => _PreUploadState();
}

class _PreUploadState extends State<PreUpload> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 150.0),
          Container(
            height: 60.0,
            decoration: BoxDecoration(image: DecorationImage(
              image: NetworkImage("https://i.ibb.co/KNFqC2D/prescription.png"),
              fit: BoxFit.contain,
            ),),
          ),
          Text("data"),

        ],
      ),
      );
  }
}
