import 'dart:convert';

import 'package:digifarmer/services/auth_service.dart';
import 'package:digifarmer/services/contactus.dart';
import 'package:digifarmer/static/static_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:textfields/textfields.dart';

import '../../static/color.dart';


class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();


  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
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



  sendContact() async {

    if(subject.text.isEmpty || message.text.isEmpty){
      StaticValues.errorSnackBar(context, "Subject or Message can't empty");

       // print(AuthService.token);
    }




    showAlertDialog(context);


    http.Response response = await  ContactUsService.createContact(subject.text, message.text);

    Navigator.pop(context);

    Map  responseMap = jsonDecode(response.body);


    if(response.statusCode == 200){

      if(responseMap['success'] == false){


        StaticValues.errorSnackBar(context, responseMap['message']);
      }


      if(responseMap['success'] == true){

        StaticValues.successSnackBar(context, responseMap['message'] );

        Get.back();

      }else{
        StaticValues.errorSnackBar(context, responseMap['message'] );
      }



    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
        backgroundColor: CustomColors.barColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height! / 1.3,
          child: SizedBox(
            height: 15,
            child: SingleChildScrollView(
              child: Card(
                color: Colors.grey.shade100,
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.asset("assets/contact.png",height: 150,),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextField(
                            controller: subject,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Subject',
                              hintText: 'Enter Your Subject',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child:   MultiLineTextField(
                            controller: message,
                            label: "Message",
                            maxLines: 5,
                            bordercolor: Colors.grey,
                          ),
                        ),

                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width /1.5,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                              ),
                              child: Text("Send"),
                              onPressed: (){
                               sendContact();
                              },
                            ),
                          ),
                        )
                      ],
                    )
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}

