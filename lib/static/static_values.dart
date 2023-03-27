
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:digifarmer/static/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../services/auth_service.dart';

class StaticValues{

  const StaticValues._();


  static const mainApiUrl = 'https://digifarmer.agrosahas.co/farmerapp/public/api/v1/';
  static const mainApi = 'https://digifarmer.agrosahas.co/farmerapp/public/';
  // static  String bearerToken = AuthService.token;

  static const Map<String,String> headers = {"Content-Type": "application/json"};

  static  int totalCartItems = 0;

  static var formatter = new NumberFormat("#,##0", "en_US");

static const List<String> size = [
  'Acres',
  ];

  static const List<String> days = [
    'Per Day',
    'Per Week',
    'Per Month',
  ];


  static const List<int> countriesList = [
    256,
    254,
    255,
    250,
    257,
    252,
    211
  ];



  // headers: {
  // 'Authorization': 'Bearer $bearerToken',
  // },

  static  customFonts(Color color,double size,FontWeight fontWeight){

    return TextStyle(

        fontFamily: 'poppins',
        color: color,
        fontWeight:fontWeight ,
        fontSize: size
    );

  }



 static void errorSnackBar(BuildContext context, String text) {

   final materialBanner = MaterialBanner(
     /// need to set following properties for best effect of awesome_snackbar_content
     elevation: 0,
     backgroundColor: Colors.transparent,
     forceActionsBelow: true,
     content: AwesomeSnackbarContent(
       title: 'Oh No!!',
       message:
       text,

       contentType: ContentType.failure,
       // to configure for material banner
       inMaterialBanner: true,
     ),
     actions: const [SizedBox.shrink()],
   );

   ScaffoldMessenger.of(context)
     ..hideCurrentMaterialBanner()
     ..showMaterialBanner(materialBanner);
   // ScaffoldMessenger.of(context).showSnackBar(
   //   SnackBar(
   //     backgroundColor: Colors.redAccent,
   //     behavior: SnackBarBehavior.floating,
   //     content: Text(
   //       text,
   //       style: TextStyle(
   //         color: Colors.white,
   //       ),
   //     ),
   //     duration: const Duration(seconds: 5),
   //
   //   ),
   // );
 }

 static void successSnackBar(BuildContext context, String text) {

   final materialBanner = MaterialBanner(
     /// need to set following properties for best effect of awesome_snackbar_content
     elevation: 0,
     backgroundColor: Colors.transparent,
     forceActionsBelow: true,
     content: AwesomeSnackbarContent(
       title: 'Congratulations!',
       message:
       text,

       contentType: ContentType.success,
       // to configure for material banner
       inMaterialBanner: true,
     ),
     actions: const [SizedBox.shrink()],
   );

   ScaffoldMessenger.of(context)
     ..hideCurrentMaterialBanner()
     ..showMaterialBanner(materialBanner);
  }





}