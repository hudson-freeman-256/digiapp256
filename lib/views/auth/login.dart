import 'dart:convert';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:country_list_pick/support/code_country.dart';
import 'package:digifarmer/services/auth_service.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/static/static_values.dart';
import 'package:digifarmer/views/auth/otp/register.dart';
import 'package:digifarmer/views/auth/register.dart';
import 'package:digifarmer/views/auth/welcome2.dart';
import 'package:digifarmer/views/bottommenu/bottom_menu.dart';
import 'package:digifarmer/views/onboardscreen.dart';
import 'package:enhanced_drop_down/enhanced_drop_down.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:password_text_field/password_text_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:textfields/textfields.dart';
import 'package:passwordfield/passwordfield.dart';

import '../../ConnectivityService.dart';
import '../../enums/connectivity_status.dart';
import '../../models/FirebaseUser.dart';
import 'forget_password.dart';


class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);






  @override
  _MyLoginState createState() => _MyLoginState();
}

class Country {
  String name;
  String dialingCode;

  Country(this.name, this.dialingCode);
}


class _MyLoginState extends State<MyLogin> {



  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email'
      ]
  );




  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }



  var _passwordVisible;








  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(color: CustomColors.barColor,),
          Container(margin: EdgeInsets.only(left: 5),child:Text("Loading" )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }









  loginUserPressed() async {

    if(email.text.isEmpty || password.text.isEmpty){
      StaticValues.errorSnackBar(context, "Phone or Password can't be empty");
      return;
    }

    try {
      showAlertDialog(context);
      http.Response response = await AuthService.loginUser("256" + email.text, password.text);
      Navigator.pop(context);

      Map responseMap = jsonDecode(response.body);

      if(response.statusCode == 200){
        if(responseMap['success'] == false){
          StaticValues.errorSnackBar(context, responseMap['message']);
        } else if(responseMap['success'] == true){
          SharedPreferences isLogged = await SharedPreferences.getInstance();
          isLogged.setString("userLogged", email.text);
          await AuthService.saveUserData(responseMap);
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>  BottomMenuScreen()));
        }
      } else if(response.statusCode == 400){
        StaticValues.errorSnackBar(context, responseMap['message']);
      }
    } catch(e){
      Navigator.pop(context);
      StaticValues.errorSnackBar(context, e.toString());
    }
  }












  @override
  Widget build(BuildContext context) {






    GoogleSignInAccount? _currentUser;




    @override
    void initState() {
      _passwordVisible = false;

      print(_currentUser?.email);




    }







    return  Scaffold(
      body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  SizedBox(height: 20,),

                  Image.asset("assets/farmer101.png"),

                  Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(

                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.all(15.0),
                            //   child: TextField(
                            //     controller: email,
                            //     keyboardType: TextInputType.number,
                            //     decoration: InputDecoration(
                            //       focusedBorder:OutlineInputBorder(
                            //         borderSide: const BorderSide(color: Colors.white, width: 2.0),
                            //         borderRadius: BorderRadius.circular(25.0),
                            //       ),
                            //       filled: true,
                            //       hintText: '7* *** ****',
                            //       hintStyle:
                            //       StaticValues.customFonts(Colors.grey,15,FontWeight.normal),
                            //
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: TextFormField(
                                controller: email,
                                 keyboardType: TextInputType.number,


                                maxLength: 9,
                                style: StaticValues.customFonts(Colors.grey,18,FontWeight.normal),
                                decoration: InputDecoration(
                                  hintText: "Phone Number",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefix: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),

                                    child: Text(
                                      '+256',

                                      style: StaticValues.customFonts(Colors.grey,18,FontWeight.normal),
                                    ),
                                  ),
                                  suffixIcon: const Icon(
                                    Icons.phone_iphone,
                                    color: Colors.blue,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),



                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: PasswordTextField(

                                controller: password,

                                decoration: InputDecoration(

                                  focusedBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: false,
                                  hintText: 'Password',
                                  counter: Container(),
                                  hintStyle:  StaticValues.customFonts(Colors.grey,18,FontWeight.normal),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                ),
                              ),
                            ),




                            SizedBox(height: 25,),
                            Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          loginUserPressed();
                                        },
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

                                              Text("Login",style: StaticValues.customFonts(Colors.white,18,FontWeight.w700),)
                                            ],
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      GestureDetector(
                                        onTap: (){
                                          Get.to(Register());
                                        },
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

                                              Text("Register",style: StaticValues.customFonts(Colors.white,18,FontWeight.w700),)
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      GestureDetector(
                                          onTap: (){
                                            Get.to(ForgetPasswordScreen());
                                          },
                                          child: Text(" Forgot Password?",style: StaticValues.customFonts(Colors.blue,15,FontWeight.w400),))
                                    ]))]),
                    ),
                  ),
                ],
              ),
            ),

          ),

    );
  }
}


