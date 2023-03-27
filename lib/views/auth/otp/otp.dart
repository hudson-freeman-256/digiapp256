
import 'dart:convert';

import 'package:digifarmer/services/auth_service.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/auth/otp/register.dart';
import 'package:digifarmer/views/auth/otp/resendcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../static/static_values.dart';
import '../register.dart';


class Otp extends StatefulWidget {
  late SharedPreferences prefs;

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {









 var otp;




  @override
void initState()  {
    super.initState();






  }


 showAlertDialog(BuildContext context){
   AlertDialog alert=AlertDialog(
     content: Row(
       children: [
         const CircularProgressIndicator(color: CustomColors.barColor,),
         Container(margin: const EdgeInsets.only(left: 5),child:const Text("Loading" )),
       ],),
   );
   showDialog(barrierDismissible: false,
     context:context,
     builder:(BuildContext context){
       return alert;
     },
   );
 }






  checkOpt() async{


     SharedPreferences preferences = await SharedPreferences.getInstance();

    String? phoneNumber = preferences.getString("fullNumber");



   // StaticValues.successSnackBar(context, phoneNumber!);
   //   StaticValues.successSnackBar(context, otp);



   showAlertDialog(context);
   http.Response response = await AuthService.checkNumber(phoneNumber!, otp);

   Navigator.pop(context);

   Map  responseMap = jsonDecode(response.body);




     if(responseMap['success'] == true){

      Get.to(MyRegister(phone: phoneNumber,));

     }else{
       StaticValues.errorSnackBar(context,responseMap['success'] );
     }












  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => Register()));
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/illustration-3.png',
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: StaticValues.customFonts(Colors.black,22,FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 5,
              ),

              Text(
                "Enter your OTP code number",
                style: StaticValues.customFonts(Colors.grey,15,FontWeight.w800),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [

                        OtpTextField(
                          numberOfFields: 4,
                          borderColor: Color(0xFF512DA8),
                          //set to true to show as box or false to show as dash
                          showFieldAsBox: true,
                          //runs when a code is typed in
                          onCodeChanged: (String code) {
                            //handle validation or checks here
                          },
                          //runs when every textfield is filled
                          onSubmit: (String verificationCode){
                            showDialog(
                                context: context,
                                builder: (context){

                                  otp = verificationCode;
                                  return AlertDialog(
                                    title: Text("Verification Code",style: StaticValues.customFonts(Colors.grey,15,FontWeight.w400),),
                                    content: Text('Code entered is $verificationCode'),
                                  );
                                }
                            );
                          }, // end onSubmit


                        )
                ,
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {

                          checkOpt();
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: StaticValues.customFonts(Colors.grey,15,FontWeight.w800),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              // Text(
              //   "Resend New Code",
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.green,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              ResendCodeWidget(onResend: () async {

                SharedPreferences prefs = await SharedPreferences.getInstance();
               var phone =  prefs.getString('phoneNumber');



                showAlertDialog(context);
                http.Response response = await AuthService.sendNumber(phone!);

                Navigator.pop(context);

                 var  responseMap = jsonDecode(response.body);

                if(response.statusCode == 200){

                  if(responseMap['success'] == false){
                    StaticValues.errorSnackBar(context, responseMap['message']);
                  }else if(responseMap['success'] == true){
                    // Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => Otp()));
                    StaticValues.successSnackBar(context, responseMap['message']);
                  }

                }else{
                  StaticValues.errorSnackBar(context, responseMap['message']);
                }

              },)
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({required bool first, last}) {
    return
         OtpTextField(
          numberOfFields: 4,
          borderColor: Color(0xFF512DA8),
          //set to true to show as box or false to show as dash
          showFieldAsBox: true,
          //runs when a code is typed in
          onCodeChanged: (String code) {
            //handle validation or checks here
          },
          //runs when every textfield is filled
          onSubmit: (String verificationCode){

          }, // end onSubmit


    );
  }
}
