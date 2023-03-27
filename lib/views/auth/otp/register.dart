import 'dart:convert';
import 'package:digifarmer/services/auth_service.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/auth/otp/otp.dart';
import 'package:digifarmer/views/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../static/static_values.dart';
import '../login.dart';
import 'package:http/http.dart' as http;


class Register extends StatefulWidget {


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController phone = TextEditingController();

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



  storeNumber() async{

    if(phone.text.isEmpty){

     StaticValues.errorSnackBar(context, "Phone Number  can't empty");
    }




    if(phone.text.isNotEmpty){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('phoneNumber', "256"+phone.text);

      showAlertDialog(context);
      http.Response response = await AuthService.sendNumber("256"+phone.text);

      Navigator.pop(context);

     var  responseMap = jsonDecode(response.body);



      print(response);


      if(response.statusCode == 200){

        if(responseMap['success'] == false){
                StaticValues.errorSnackBar(context, responseMap['message']);
              }else if(responseMap['success'] == true){
          Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => Otp()));

        }

      }else{
        StaticValues.errorSnackBar(context, responseMap['message']);
      }
    }

    //   if(response.statusCode == 200){
    //
    //     if(responseMap['success'] == false){
    //
    //
    //       StaticValues.errorSnackBar(context, responseMap['message']);
    //     }
    //
    //
    //     if(responseMap['success'] == true){
    //
    //       // Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) =>  Otp()));
    //
    //     }
    //
    //
    //
    //   }
    //
    //   Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => Otp()));
    //
    // }




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => MyLogin()));

                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(
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
                  'assets/images/illustration-2.png',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Registration',
                style: StaticValues.customFonts(Colors.black,25,FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Add your phone number. we'll send you a verification code so we know you're real",
                style: StaticValues.customFonts(Colors.grey,15,FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Text("Enter Your Mobile Phone Number ",style: StaticValues.customFonts(Colors.grey,15,FontWeight.w400),),
                    TextFormField(

                      controller: phone,
                      keyboardType: TextInputType.number,
                      maxLength: 9,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        prefix: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),

                          child: Text(
                            '+256',

                            style: TextStyle(

                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        suffixIcon: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                           storeNumber();

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
                        child:  Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Send',
                            style: StaticValues.customFonts(Colors.white,18,FontWeight.w700),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
