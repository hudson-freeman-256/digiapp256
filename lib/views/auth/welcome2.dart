import 'package:digifarmer/views/auth/otp/register.dart';
import 'package:digifarmer/views/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../static/color.dart';
import 'login.dart';
class Welcome2 extends StatefulWidget {
  const Welcome2({Key? key}) : super(key: key);

  @override
  State<Welcome2> createState() => _Welcome2State();
}

class _Welcome2State extends State<Welcome2> {

  // bool userLogin = false;
  // var phone,password;
  //
  // Future<bool> saveUserInfo() async{
  //
  //
  //   SharedPreferences user = await SharedPreferences.getInstance();
  //
  //   var savePhone =    user.getString('savePhone');
  //   var savePassword =    user.getString('savePassword');
  //
  //   if(savePhone != null && savePassword != null){
  //     // print("user phone and password is there");
  //     phone = savePhone;
  //     password = savePassword;
  //
  //     return userLogin = true;
  //   }else{
  //     // print("user not there");
  //     return userLogin =  false;
  //   }
  //
  //
  // }


  @override
  void initState() {

    // print(userLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/welcome2.jpg"),
                    fit: BoxFit.cover)
            ),
          child: Column(
            children: [
              Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.6,

              ),
              Expanded(
                child: Container(
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
                      padding: const EdgeInsets.all(10.0),
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Welcome to \nDigital farming",style: GoogleFonts.poppins(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold) ,),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Column(
                                  children: [

                                    SizedBox(height: 10,)
                                    ,
                                    GestureDetector(
                                      onTap: (){
                                        Get.to(MyLogin());
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
                                            Text("Login",style: GoogleFonts.poppins(color: Colors.white),)
                                          ],
                                        ),
                                      ),
                                    ),
SizedBox(height: 5,),
                                    GestureDetector(
                                      onTap: (){
                                        // Get.to(MyRegister());
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
                                            Text("Register",style: GoogleFonts.poppins(color: Colors.white),)
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5,),

                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
