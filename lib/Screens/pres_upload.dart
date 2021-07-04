import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma/Screens/Home/cubit/cubit.dart';
import 'package:pharma/Screens/Home/cubit/state.dart';
import 'package:pharma/Screens/address/address_screen.dart';
import 'package:pharma/components/defultButton.dart';
import 'package:pharma/components/navigations.dart';
import 'package:pharma/components/ratingWidget.dart';
import 'package:pharma/components/showToast.dart';
import 'package:pharma/constants.dart';

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
  @override
  _PreUploadState createState() => _PreUploadState();
}

class _PreUploadState extends State<PreUpload> {
  File imageGallery;
  String imageLinkGallery = '';

  File imageCamera;
  String imageLinkCamera = '';

  List<File> imageFiles = [];

  List<String> imageLinks = [];

  final picker = ImagePicker();

  getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imageGallery = File(pickedFile.path);
        imageLinkGallery = '${pickedFile.path}';

        imageFiles.add(File(pickedFile.path));
        imageLinks.add('${pickedFile.path}');
      } else {
        showToast(text: 'No image selected.', error: true);
      }
    });
  }

  getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        imageCamera = File(pickedFile.path);
        imageLinkCamera = '${pickedFile.path}';
        imageFiles.add(File(pickedFile.path));
        imageLinks.add('${pickedFile.path}');
      } else {
        showToast(text: 'No image selected.', error: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Upload Prescription',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: BlocProvider(
        create: (context) => AllPharmaciesCubit()..allPharmacies(),
        child: BlocConsumer<AllPharmaciesCubit, AllPharmaciesStates>(
          listener: (context, state) {},
          builder: (context, state) {
            List pharmacies = AllPharmaciesCubit.get(context).pharmacies;
            int checkIndex = AllPharmaciesCubit.get(context).checkIndex;
            return ConditionalBuilder(
              condition: pharmacies.length != 0,
              builder: (context) => ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 4,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(32),
                              bottomLeft: Radius.circular(32),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 32, right: 32, top: 8, bottom: 18),
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey[200], width: 1),
                            ),
                            child: Center(
                              child: imageLinks.length != 0
                                  ? Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: ListView.separated(
                                        itemBuilder: (context, index) => Stack(
                                          alignment:
                                              AlignmentDirectional.bottomCenter,
                                          children: [
                                            Container(
                                              height: 120,
                                              width: 100,
                                              child: Image.file(
                                                File(imageLinks[index]),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .bottomCenter,
                                              child: IconButton(
                                                icon: Icon(Icons.delete),
                                                color: Colors.red,
                                                onPressed: () {
                                                  setState(() {
                                                    imageLinks.removeAt(index);
                                                  });
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          width: 8,
                                        ),
                                        itemCount: imageLinks.length,
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'images/prescription.png'),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Upload Prescription",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            defaultButton(
                                function: () {
                                  getImageGallery();
                                },
                                text: 'Gallary',
                                icon: Icons.photo,
                                width: MediaQuery.of(context).size.width / 2.5),
                            defaultButton(
                                function: () {
                                  getImageCamera();
                                },
                                text: 'Camera',
                                icon: Icons.camera_alt_outlined,
                                width: MediaQuery.of(context).size.width / 2.5)
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 12 ,top: 23),
                      //   child: Text('Available Stores',style: TextStyle(fontWeight: FontWeight.bold),),
                      // ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      DefaultTabController(
                        length: 2,
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TabBar(
                              labelColor: kPrimaryColor,
                              unselectedLabelColor: Colors.black,
                              tabs: [
                                Tab(text: 'Argent'),
                                Tab(text: 'Padding'),
                              ],
                            ),
                            SizedBox(height: 18,),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/1.5,
                              child: TabBarView(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          '${pharmacies[0]['imageLink']}'),
                                                    )),
                                              ),
                                           //   SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${pharmacies[0]['title']}',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: kPrimaryColor),
                                                  ),
                                                  RatingWidget(
                                                    rating: double.parse('${pharmacies[1]['rate']}'),
                                                    color: Colors.orange,
                                                    size: 20.0,
                                                  ),
                                                  Text(
                                                      'Live traking - Contactless delivery',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: kPrimaryColor)),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  AllPharmaciesCubit.get(context)
                                                      .changeIndex(0);
                                                },
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            60.0)),
                                                    color: checkIndex == 0
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
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Divider(
                                              color: Colors.grey,
                                              endIndent: 50,
                                              height: 0.5,
                                              indent: 50),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          '${pharmacies[1]['imageLink']}'),
                                                    )),
                                              ),
                                           //   SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${pharmacies[1]['title']}',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: kPrimaryColor),
                                                  ),
                                                  RatingWidget(
                                                    rating: double.parse('${pharmacies[1]['rate']}'),
                                                    color: Colors.orange,
                                                    size: 20.0,
                                                  ),
                                                  Text(
                                                      'Live traking - Contactless delivery',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: kPrimaryColor)),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  AllPharmaciesCubit.get(context)
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
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Divider(
                                              color: Colors.grey,
                                              endIndent: 50,
                                              height: 0.5,
                                              indent: 50),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          '${pharmacies[2]['imageLink']}'),
                                                    )),
                                              ),
                                           //   SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${pharmacies[2]['title']}',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: kPrimaryColor),
                                                  ),
                                                  RatingWidget(
                                                    rating: double.parse('${pharmacies[2]['rate']}'),
                                                    color: Colors.orange,
                                                    size: 20.0,
                                                  ),
                                                  Text(
                                                      'Live traking - Contactless delivery',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: kPrimaryColor)),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  AllPharmaciesCubit.get(context)
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
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Divider(
                                              color: Colors.grey,
                                              endIndent: 50,
                                              height: 0.5,
                                              indent: 50),
                                          SizedBox(height: 60),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                                            child: defaultButtonWithOutIcon(
                                              function: () {
                                                navigateTo(context, AddressScreen(
                                                  '${pharmacies[checkIndex]['title']}',
                                                   'Argent',
                                                ));
                                              },
                                              text: 'Process To Checkout',
                                              width: MediaQuery.of(context).size.width,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          '${pharmacies[0]['imageLink']}'),
                                                    )),
                                              ),
                                             // SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${pharmacies[0]['title']}',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: kPrimaryColor),
                                                  ),
                                                  RatingWidget(
                                                    rating: double.parse('${pharmacies[0]['rate']}'),
                                                    color: Colors.orange,
                                                    size: 20.0,
                                                  ),
                                                  Text(
                                                      'Live traking - Contactless delivery',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: kPrimaryColor)),
                                                ],
                                              ),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          60.0)),
                                                  color: kPrimaryColor,
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
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Divider(
                                              color: Colors.grey,
                                              endIndent: 50,
                                              height: 0.5,
                                              indent: 50),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          '${pharmacies[1]['imageLink']}'),
                                                    )),
                                              ),
                                             // SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${pharmacies[1]['title']}',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: kPrimaryColor),
                                                  ),
                                                  RatingWidget(
                                                    rating: double.parse('${pharmacies[1]['rate']}'),
                                                    color: Colors.orange,
                                                    size: 20.0,
                                                  ),
                                                  Text(
                                                      'Live traking - Contactless delivery',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: kPrimaryColor)),
                                                ],
                                              ),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          60.0)),
                                                  color:  kPrimaryColor,
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
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Divider(
                                              color: Colors.grey,
                                              endIndent: 50,
                                              height: 0.5,
                                              indent: 50),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          '${pharmacies[2]['imageLink']}'),
                                                    )),
                                              ),
                                          //    SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${pharmacies[2]['title']}',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: kPrimaryColor),
                                                  ),
                                                  RatingWidget(
                                                    rating: double.parse('${pharmacies[2]['rate']}'),
                                                    color: Colors.orange,
                                                    size: 20.0,
                                                  ),
                                                  Text(
                                                      'Live traking - Contactless delivery',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: kPrimaryColor)),
                                                ],
                                              ),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          60.0)),
                                                  color:  kPrimaryColor,
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
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Divider(
                                              color: Colors.grey,
                                              endIndent: 50,
                                              height: 0.5,
                                              indent: 50),
                                          SizedBox(height: 60),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
                                            child: defaultButtonWithOutIcon(
                                              function: () {
                                                String pharmaciesName = '${pharmacies[0]['title']} , ${pharmacies[1]['title']} , ${pharmacies[2]['title']}';
                                                navigateTo(context, AddressScreen(
                                                  '${pharmaciesName.toString()}',
                                                  'Padding',
                                                ));
                                              },
                                              text: 'Process To Checkout',
                                              width: MediaQuery.of(context).size.width,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                ],
              ),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
//
// child:  Expanded(
// child: DefaultTabController(
// length: 2, // length of tabs
// initialIndex: 0,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: <Widget>[
// Container(
// child: TabBar(
// labelColor: kPrimaryColor,
// unselectedLabelColor: Colors.black,
// tabs: [
// Tab(text: 'Argent'),
// Tab(text: 'Padding'),
// ],
// ),
// ),
// Container(
// height: double.infinity,
// child: TabBarView(children: <Widget>[
// InkWell(
// onTap: () {},
// child: Padding(
// padding: const EdgeInsets.only(left: 16,right: 16),
// child: Column(
// children: [
// Row(
// children: [
// Container(
// height: 100,
// width: 100,
// decoration: BoxDecoration(
// image: DecorationImage(
// image: NetworkImage('${pharmacies[0]['imageLink']}'),
// )),
// ),
// SizedBox(width: 10),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// '${pharmacies[0]['title']}',
// style:
// TextStyle(fontSize: 18, color: kPrimaryColor),
// ),
// Row(
// children: [
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// ],
// ),
// Text('Live traking - Contactless delivery',
// style: TextStyle(
// fontSize: 12, color: kPrimaryColor)),
// ],
// ),
// GestureDetector(
// onTap: (){
// AllPharmaciesCubit.get(context).changeIndex(1);
// },
// child: Container(
// width: 30,
// height: 30,
// decoration:
// BoxDecoration(
// borderRadius:
// BorderRadius.all(Radius.circular(60.0)),
// color: checkIndex == 1 ? kPrimaryColor : Colors.white,
// border: Border.all(
// color: kPrimaryColor,
// width: 2.0,
// ),
// ),
// child: ClipOval(
// child: Center(
// child: Icon(
// Icons.check,
// color: Colors.white,
// size: 15,
// )),
// ),
// ),
// ),
// ],
// ),
// SizedBox(height: 10),
// Divider(
// color: Colors.grey,
// endIndent: 50,
// height: 0.5,
// indent: 50),
// SizedBox(height: 10),
// Row(
// children: [
// Container(
// height: 100,
// width: 100,
// decoration: BoxDecoration(
// image: DecorationImage(
// image: NetworkImage('${pharmacies[1]['imageLink']}'),
// )),
// ),
// SizedBox(width: 10),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// '${pharmacies[1]['title']}',
// style:
// TextStyle(fontSize: 18, color: kPrimaryColor),
// ),
// Row(
// children: [
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// ],
// ),
// Text('Live traking - Contactless delivery',
// style: TextStyle(
// fontSize: 12, color: kPrimaryColor)),
// ],
// ),
// GestureDetector(
// onTap: (){
// AllPharmaciesCubit.get(context).changeIndex(2);
// },
// child: Container(
// width: 30,
// height: 30,
// decoration:
// BoxDecoration(
// borderRadius:
// BorderRadius.all(Radius.circular(60.0)),
// color: checkIndex == 2
// ? kPrimaryColor : Colors.white,
// border: Border.all(
// color: kPrimaryColor,
// width: 2.0,
// ),
// ),
// child: ClipOval(
// child: Center(
// child: Icon(
// Icons.check,
// color: Colors.white,
// size: 15,
// )),
// ),
// ),
// ),
// ],
// ),
// SizedBox(height: 10),
// Divider(
// color: Colors.grey,
// endIndent: 50,
// height: 0.5,
// indent: 50),
// SizedBox(height: 10),
// Row(
// children: [
// Container(
// height: 100,
// width: 100,
// decoration: BoxDecoration(
// image: DecorationImage(
// image: NetworkImage('${pharmacies[2]['imageLink']}'),
// )),
// ),
// SizedBox(width: 10),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// '${pharmacies[2]['title']}',
// style:
// TextStyle(fontSize: 18, color: kPrimaryColor),
// ),
// Row(
// children: [
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// Icon(
// Icons.star,
// size: 20,
// color: Colors.orange,
// ),
// ],
// ),
// Text('Live traking - Contactless delivery',
// style: TextStyle(
// fontSize: 12, color: kPrimaryColor)),
// ],
// ),
// GestureDetector(
// onTap: (){
// AllPharmaciesCubit.get(context).changeIndex(3);
// },
// child: Container(
// width: 30,
// height: 30,
// decoration:
// BoxDecoration(
// borderRadius:
// BorderRadius.all(Radius.circular(60.0)),
// color: checkIndex == 3
// ? kPrimaryColor : Colors.white,
// border: Border.all(
// color: kPrimaryColor,
// width: 2.0,
// ),
// ),
// child: ClipOval(
// child: Center(
// child: Icon(
// Icons.check,
// color: Colors.white,
// size: 15,
// )),
// ),
// ),
// ),
// ],
// ),
// SizedBox(height: 10),
// Divider(
// color: Colors.grey,
// endIndent: 50,
// height: 0.5,
// indent: 50),
// SizedBox(height: 10),
// ],
// ),
// ),
// ),
// InkWell(
// onTap: () {},
// child: Container(child: Center(child: Text('Padding'),),),
// ),
// ],
// ),
// ),
// ],
// ),
// ),
// ),
