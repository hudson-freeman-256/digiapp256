import 'dart:convert';

import 'package:digifarmer/views/auth/login.dart';
import 'package:digifarmer/views/auth/welcome2.dart';
import 'package:digifarmer/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../services/auth_service.dart';
import '../../static/static_values.dart';
import '../bottommenu/bottom_menu.dart';
import '../onboardscreen.dart';
class WelcomeScreen extends StatefulWidget {


  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  var phoneAuth;

  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 5),child:Text("Loading" )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }









  @override
  void initState()  {
    super.initState();
 // phoneAuth);


  }







  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body:  Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/welcome.jpg"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 30,),
                  Center(child: Text("Welcome to \n Digi Farmer",style: GoogleFonts.poppins(color: Colors.white,fontSize: 40,fontWeight: FontWeight.w900),)),
                ],
              ),
              Column(
                children: [




                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.lightGreen)
                    ),
                      onPressed: (){


                          Get.off(Welcome2());



                      },
                      child: const Text("Get Started")),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
