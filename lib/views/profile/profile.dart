import 'dart:convert';
import 'package:digifarmer/models/savedCrops.dart';
import 'package:digifarmer/services/auth_service.dart';
import 'package:digifarmer/services/profile_service.dart';
import 'package:digifarmer/views/auth/login.dart';
import 'package:digifarmer/views/profile/address/address.dart';
import 'package:digifarmer/views/profile/contact.dart';
import 'package:digifarmer/views/profile/faqs.dart';
import 'package:digifarmer/views/profile/task.dart';
import 'package:digifarmer/views/profile/terms.dart';
import 'package:digifarmer/views/profile/vendor/becomevendor.dart';
import 'package:digifarmer/views/profile/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../models/user.dart';
import '../../static/color.dart';
import '../../static/static_values.dart';
import '../auth/change_password.dart';
import '../market/view_saved_products.dart';
import 'myprofile.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();



}





class _ProfileState extends State<Profile> {

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


  @override
  void initState() {
    super.initState();


    getUserInfo();
  }




  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(color: CustomColors.barColor,),
          Container(margin: EdgeInsets.only(left: 5),child:Text("Logging you out Please wait..." ,style: GoogleFonts.poppins(fontSize: 13),)),
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
  Widget build(BuildContext context) {








    return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(

                children: [

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [





                          CircleAvatar(
                            radius: 55.0,
                            backgroundColor: Colors.grey.shade100,
                            child: ClipRRect(
                              child:   AuthService.photo.isEmpty ? Image.asset('assets/default.png') : FadeInImage(
                                placeholder: AssetImage('assets/LOADING_ANIMATION.gif'),
                                image: NetworkImage(StaticValues.mainApi+AuthService.photo),
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [



                              SizedBox(height: 10,),

                              Text(firstName.toUpperCase()+" "+lastName.toUpperCase(),style: StaticValues.customFonts(CustomColors.black, 17, FontWeight.w700),),
                              SizedBox(
                                height: 5,
                              ),
                              Text(email,style: StaticValues.customFonts(CustomColors.black , 15, FontWeight.w700),),
                              SizedBox(
                                height: 5,
                              ),
                               Text("+"+phone,style: StaticValues.customFonts(CustomColors.black, 15, FontWeight.w700),),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment:  CrossAxisAlignment.end,
                                children: [



                                  AuthService.is_verfiled == 1 ?  const Text(" Verified",style: TextStyle(color: Colors.green,fontSize: 15,fontWeight: FontWeight.bold,letterSpacing: 1

                                  ),) : Text("Not verified",style: StaticValues.customFonts(Colors.redAccent, 15, FontWeight.w700))

                                  ,SizedBox(
                                    width: 50,
                                  ),

                                  GestureDetector(
                                    onTap: () async{



                                      showAlertDialog(context);


                                    await AuthService.deleteUserData();
                                    Navigator.pop(context);



                                      Get.off(const MyLogin());
                                    },
                                      child: Text("Logout",style: StaticValues.customFonts(CustomColors.barColor, 15, FontWeight.w700)))

                                ],
                              ),

                            ],


                          )
                        ],
                      ),
                    ),
                  ),
SizedBox(height: 15,),
                  GestureDetector(
                    onTap: (){
                      Get.to(BecomeVendor());
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),

                      child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(child: Image.asset('assets/profile/13.png',height:60,)),
                                 Center(child: Text("Become a vendor",style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),)),
                                // Text("Do Tasks On Time",style: TextStyle(fontSize: 15),)
                              ],
                            ),
                          )

                      ),
                    ),
                  ),

                  SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      GestureDetector(
                        onTap: (){
                          Get.to(EditProfilePage());
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),

                              child: Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width/2.2,
                                  color: Colors.grey.shade200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(child: Image.asset('assets/profile/7.png',height:60,)),
                                        Center(child: Text("My Profile",style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),)),
                                        // Center(child: Text("Know me",style: TextStyle(fontSize: 10),))
                                      ],
                                    ),
                                  )

                              ),
                            )
                          ],
                        ),
                      ),
        GestureDetector(
        onTap: (){
      Get.to(Address());
    },
      child: Row(
      children: [
      ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),

      child: Container(
      height: 100,
      width: MediaQuery.of(context).size.width/2.2,
      color: Colors.grey.shade200,
      child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Center(child: Image.asset('assets/profile/3.png',height:60,)),
      Center(child: Text("Address",style:StaticValues.customFonts(Colors.black, 15, FontWeight.w700))),
      // Text("Save Address",style: TextStyle(fontSize: 15),)
      ],
      ),
      )





      ),
      )
      // ])))]))


      ]))


                    ],
                  ),

                  SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(Faqs());
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),

                              child: Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width/2.2,

                                  color: Colors.grey.shade200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(child: Image.asset('assets/profile/1.png',height:60,)),
                                        Center(child: Text("FAQs",style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),)),
                                        // Text("Quick   Answers",style: TextStyle(fontSize: 15),)
                                      ],
                                    ),
                                  )

                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(ContactUs());
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),

                              child: Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width/2.2,

                                  color: Colors.grey.shade200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(child: Image.asset('assets/profile/11.png',height:60,)),
                                        Center(child: Text("Contact Us",style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),)),
                                        // Text("Quick   Answers",style: TextStyle(fontSize: 15),)
                                      ],
                                    ),
                                  )

                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),

                  SizedBox(height: 15,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.to(ContactUs());
                        },
                        child: GestureDetector(
                          onTap: (){
                            Get.to(Terms());
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10)),

                                child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width/2.2,

                                    color: Colors.grey.shade200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(child: Image.asset('assets/profile/12.png',height:60,)),
                                          Center(child: Text("Terms & Con...",style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),)),
                                          // Text("Quick   Answers",style: TextStyle(fontSize: 15),)
                                        ],
                                      ),
                                    )

                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(ViewSaveProduct());
                        },
                        child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width/2.2,
                            color: Colors.grey.shade200,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(child: Image.asset('assets/profile/2.png',height:60,)),
                                  Center(child: Text("Saved",style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),)),
                                  // Text("Buyers and Vendors",style: TextStyle(fontSize: 15),)
                                ],
                              ),
                            )

                        ),
                      )

                ]),

                  SizedBox(height: 15,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(ContactUs());
                          },
                          child: GestureDetector(
                            onTap: (){
                            Get.to(ChangePassword());
                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),

                                  child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width/2.2,

                                      color: Colors.grey.shade200,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(child: Image.asset('assets/forget_password.png',height:60,)),
                                            Center(child: Text("Password",style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),)),
                                            // Text("Quick   Answers",style: TextStyle(fontSize: 15),)
                                          ],
                                        ),
                                      )

                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),


                      ]),

                ])))));
  }
}
