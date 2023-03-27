import 'dart:convert';

import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../services/auth_service.dart';
import '../../static/static_values.dart';
import 'package:http/http.dart' as http;



class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();


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

  editUser() async{









        showAlertDialog(context);



         if(firstname.text.isEmpty || lastname.text.isEmpty || email.text.isEmpty || phoneNumber.text.isEmpty){
           http.Response response = await AuthService.editUser(
               firstname.text.isEmpty ? AuthService.firstName : firstname.text,
               lastname.text.isEmpty ? AuthService.lastName : lastname.text,
               email.text.isEmpty ? AuthService.email : email.text ,
               phoneNumber.text.isNotEmpty  ? AuthService.phoneNumber : phoneNumber.text
           );


           Navigator.pop(context);
           Map  responseMap = jsonDecode(response.body);

           if(response.statusCode == 200){

             if(responseMap['success'] == false){


               StaticValues.errorSnackBar(context, responseMap['message']);
             }


             if(responseMap['success'] == true){
               StaticValues.successSnackBar(context, responseMap['message']);
               // Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => OnBoardScreen()));
             }

           }else{


             StaticValues.errorSnackBar(context, responseMap.toString());
           }

           }






    }




  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: CustomColors.barColor,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                StaticValues.mainApi+AuthService.photo,
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              buildTextField("FirstName", AuthService.firstName, false,firstname),
              buildTextField("LastName", AuthService.lastName, false,lastname),
              buildTextField("E-mail", AuthService.email, false,email),
              buildTextField("Phone Number", AuthService.phoneNumber, false,phoneNumber),
              // buildTextField("Password", "********", true),
              // buildTextField("Location", "TLV, Israel", false),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red)
                      ),
                      onPressed: (){

                  }, child:const Text("CANCEL",style: TextStyle(color: Colors.white,fontSize: 14,letterSpacing: 2.2,),)
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                      ),
                      onPressed: (){
                    editUser();
                  }, child:Text("SAVE",style: TextStyle(color: Colors.white,fontSize: 14,letterSpacing: 2.2,),

                  )
                  ),


                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField,TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}