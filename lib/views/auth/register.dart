import 'dart:convert';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_text_field/password_text_field.dart';
import 'package:passwordfield/passwordfield.dart';
import '../../services/auth_service.dart';
import '../../static/color.dart';
import '../../static/static_values.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
class MyRegister extends StatefulWidget {
  final String phone;
  const MyRegister({Key? key, required this.phone}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();







  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
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


 //  getPhoneNumber()  async{
 //
 //
 //    SharedPreferences preferences = await SharedPreferences.getInstance();
 //    //
 // phoneNumber =   preferences.getString("PhoneNumber");
 //
 // print(phoneNumber);
 //  }

  registerUser() async{

    if(firstname.text.isEmpty){
        StaticValues.errorSnackBar(context, "First Name is Required");
    }else if(lastname.text.isEmpty){
      StaticValues.errorSnackBar(context, "Last Name is Required");
    }else if(email.text.isEmpty){
      StaticValues.errorSnackBar(context, "Email is Required");
    }else if(password .text.isEmpty){
      StaticValues.errorSnackBar(context, "password  is Required");
    }else if(password .text.isEmpty){
      StaticValues.errorSnackBar(context, "Confirm Password  is Required");
    }
    else{


       if(password.text != confirmPassword.text){
         StaticValues.errorSnackBar(context, " Passwords  don't match!!");

       }

       if(firstname.text.isNotEmpty && lastname.text.isNotEmpty && email.text.isNotEmpty && password.text.isNotEmpty && confirmPassword.text.isNotEmpty){




         showAlertDialog(context);



         http.Response response = await AuthService.registerUser(firstname.text, lastname.text,email.text , confirmPassword.text, widget.phone);

         Navigator.pop(context);
         Map  responseMap = jsonDecode(response.body);

         if(response.statusCode == 200){

           if(responseMap['success'] == false){


             StaticValues.errorSnackBar(context, responseMap['message']);
           }


           if(responseMap['success'] == true){

             StaticValues.successSnackBar(context, responseMap['message']+"Login your Phone and password here ");
             Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => MyLogin()));
           }



         }else{


           StaticValues.errorSnackBar(context, responseMap['message']);
         }
       }

    }


  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/login.png"),
                  fit: BoxFit.cover)
          ),
          child: SingleChildScrollView(

            child: Column(
              children: [


                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/4,

                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration:
                  BoxDecoration(
                      border: Border.all(
                          color: Colors.transparent,
                          width: 2
                      ),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)
                      ),
                      color: Colors.white
                  )
                  ,
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding:  EdgeInsets.all(10.0),
                      child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Padding(
                              padding: const EdgeInsets.only(left:13.0),
                              child: Text("Finish What \n you started.",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w700,letterSpacing: 0.5,color: CustomColors.barColor),),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextField(
                               controller: firstname,

                                decoration: InputDecoration(
                                  focusedBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  filled: true,
                                  hintText: 'First Name',
                                  hintStyle: TextStyle(
                                      color: Colors.grey
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextField(
                               controller: lastname,

                                decoration: InputDecoration(
                                  focusedBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  filled: true,
                                  hintText: 'Last Name',
                                  hintStyle: TextStyle(
                                      color: Colors.grey
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextField(
                                controller: email,
                                decoration: InputDecoration(
                                  focusedBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  filled: true,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      color: Colors.grey
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),

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
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  filled: false,
                                  hintText: 'Password',
                                  counter: Container(),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: PasswordTextField(

                                controller: confirmPassword,

                                decoration: InputDecoration(

                                  focusedBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  filled: false,
                                  hintText: 'Confirm Password',
                                  counter: Container(),
                                  hintStyle: TextStyle(
                                      color: Colors.grey
                                  ),

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
                                          registerUser();
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 1.2,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: CustomColors.barColor,
                                            borderRadius: BorderRadius.circular(15)
                                          ),

                                          child: Center(child: Text("Register",style: GoogleFonts.poppins(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                    ]))]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}