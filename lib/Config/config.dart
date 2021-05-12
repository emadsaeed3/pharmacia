import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:pharma/components/authservice.dart';
import 'package:shared_preferences/shared_preferences.dart';


var auth = FirebaseAuth.instance.currentUser;


class PharmaciaApp
{
   static const String appName = 'pharmacia';
   static SharedPreferences sharedPreferences;
   static User user;
   static FirebaseFirestore firestore ;

   static String collectionUser = "users";
   static String collectionOrders = "orders";
   static String userCartList = 'userCart';
   static String subCollectionAddress = 'userAddress';
   static final String userName =  auth.displayName;
   static final String userEmail = auth.email;
   static final String userPhotoUrl = auth.photoURL;
   static final String userUID = auth.uid;
   static final String addressID = "";
   static final String totalAmount = 'totalAmount';
   static final String productID = 'productIDs';
   static final String paymentDetails ='paymentDetails';
   static final String orderTime ='orderTime';
   static final String isSuccess ='isSuccess';

}

