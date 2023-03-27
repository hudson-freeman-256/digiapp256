import 'dart:async';
import 'dart:io';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digifarmer/static/static_values.dart';
import 'package:digifarmer/views/Error.dart';
import 'package:digifarmer/views/auth/welcome_screen.dart';
import 'package:digifarmer/views/bottommenu/bottom_menu.dart';
import 'package:digifarmer/views/home/home.dart';
import 'package:digifarmer/views/onboardscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth_service.dart';
import '../../static/ConnectInternet.dart';
import '../auth/login.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;
  bool isLoggedin = false;


  String firstName = "",lastName ="",email ="",phone ="" ,token = "";

  getUserInfo() async {

    firstName = await AuthService.getFirstname();
    lastName = await AuthService.getLastname();
    email = await AuthService.getEmail();
    phone = await AuthService.getPhone();
    token = await AuthService.getToken();

    setState(() {
      firstName;
      lastName;
      email;
      phone;
      token;
    });
  }



  Future<bool> checkInternet() async {
    bool status = false;
    try {
      final result = await InternetAddress.lookup('https://www.google.com/');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        status = true;
      }
    } on SocketException catch (_) {
      status = false;
    }

    return status;
  }


 Future<bool> checkUserHasData() async {
    bool isConnected = false;
    try{
      final result = await InternetAddress.lookup("www.google.com");
       if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){

         isConnected = true;
       }

    } on SocketException catch (_){
      isConnected = false;
    }

    return isConnected;
 }


  goToView() {


    getUserInfo();

    _connectivity.initialise();

    _connectivity.myStream.listen((source) async {

      setState(() => _source = source);
      setState(() =>  isLoggedin);

      String string ;

      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          string = 'Mobile: Online';

          break;
        case ConnectivityResult.wifi:
          string = 'wifioffline';
          break;
        case ConnectivityResult.none:
        default:
          string = 'Offline';
      }

      SharedPreferences isLogged = await SharedPreferences.getInstance();

    var  phoneAuth = isLogged.getString("userLogged");



      if(string == "Offline"){
        Get.to(ErrorPage());
      }else if(phoneAuth != null){


        if(await checkUserHasData()){
          Get.off( const BottomMenuScreen());
        }else{
          Get.to(ErrorPage());
        }

      }
      else{


        if(await checkUserHasData()){

          Timer(const Duration(seconds: 1),
                  ()=>Get.off( const MyLogin()));
        }else{
          Get.to(ErrorPage());
        }


      }


    }
    );




  }







    @override
  void initState()  {
    super.initState();


    goToView();




  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
          body: Center(
            child: Image.asset('assets/logo/logo.png'),
          ),
    );
  }
}
