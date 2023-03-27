import 'dart:convert';

import 'package:digifarmer/services/auth_service.dart';
import 'package:digifarmer/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../static/color.dart';
import '../../static/static_values.dart';
import '../home/shopping_cart.dart';
import '../market/daily_fresh.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_outlined)),
              ),
SizedBox(height: 100,),
            Center(child:   Image.asset("assets/forget_password.png",height: 100,),),

              SizedBox(height: 15,),

              Center(child: Text("Reset Your Password",
                // style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.w400),
              style: StaticValues.customFonts(Colors.black,24,FontWeight.w400),
              )),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(15),
                child:  Text("Lost your password? Please enter your email. you will receive a link to create a new password via email"
                  ,style: StaticValues.customFonts(Colors.grey,15,FontWeight.w400),),
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                   controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    focusedBorder:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    filled: true,
                    hintText: 'Enter Your Email Address',
                    hintStyle: StaticValues.customFonts(Colors.grey,15,FontWeight.w400),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              GestureDetector(
                onTap: () async {




                  // forgotPasswordEmailSend


                  if(email.text.isEmpty ){
                    StaticValues.errorSnackBar(context, "Email can't be empty");
                    return;
                  }

                  try {
                    showAlertDialog(context);
                    http.Response response = await AuthService.forgotPasswordEmailSend(email.text);
                    Navigator.pop(context);

                    Map responseMap = jsonDecode(response.body);


                    StaticValues.successSnackBar(context, responseMap['message']);

                    // if(response.statusCode == 200){
                    //   if(responseMap['success'] == false){
                    //     StaticValues.errorSnackBar(context, responseMap.toString());
                    //   } else if(responseMap['success'] == true){
                    //
                    //     await AuthService.saveUserData(responseMap);
                    //     Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>  MyLogin()));
                    //   }
                    // } else if(response.statusCode == 400){
                    //   StaticValues.errorSnackBar(context, responseMap.toString());
                    // }
                  } catch(e){
                    Navigator.pop(context);
                    StaticValues.errorSnackBar(context, e.toString());
                  }

                },
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 50,
                    decoration: BoxDecoration(
                        color: CustomColors.barColor,
                        borderRadius: BorderRadius.circular(15)
                    ),


                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Text("Send Password Reset",style: StaticValues.customFonts(Colors.white,18,FontWeight.w700),)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
