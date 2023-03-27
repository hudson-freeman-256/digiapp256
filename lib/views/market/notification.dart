import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../wigets/top_menu.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);



  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  bool clearData = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopMenu(title: "My Notification", onTap: (){
                Get.back();
              }),

              SizedBox(height: 20,),




              Column(children: [
                ListTile(
                  leading: Image.asset("assets/erase.png"),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("You received a Request  of Apple for UGX 50,000."),
                      SizedBox(height: 5,),
                      Text("12-02-2023"),
                    ],
                  ),
                ),


              ],),
              SizedBox(height: 5,),
              Column(children: [
                ListTile(
                  leading: Image.asset("assets/erase.png"),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("You received a Request  of Apple for UGX 50,000."),
                      SizedBox(height: 5,),
                      Text("12-02-2023"),
                    ],
                  ),
                ),


              ],),






            ],
          ),
        ),
      ),
    );
  }
}
