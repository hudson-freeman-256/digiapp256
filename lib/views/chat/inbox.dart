import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../static/static_values.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: CustomColors.gary,
                  height: 50,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("My Inbox",style: StaticValues.customFonts(Colors.black, 20, FontWeight.w700),),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 10,),
                // ListTile(
                //   onTap: (){
                //     Get.to(ChatScreen());
                //   },
                //   leading: CircleAvatar(child: Text("M",style: StaticValues.customFonts(Colors.white, 15, FontWeight.w700),),backgroundColor: CustomColors.barColor,radius: 20.0),
                //   title: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text("Mwanika Hudson",style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),),
                //       Text("Bro I have a 500 million ugx ",style: StaticValues.customFonts(Colors.grey, 13, FontWeight.w700),)
                //     ],
                //   ),
                //   subtitle: Padding(
                //     padding: const EdgeInsets.only(top: 5),
                //     child:  Text("12:00 pm",style: StaticValues.customFonts(Colors.grey, 10, FontWeight.w700),),
                //   ),
                //
                //
                // ),
                SizedBox(height: 10,),

                 Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Icon(Icons.error_outline,size: 40,color: Colors.red.shade300,),
                     Text("Your Inbox is empty",style: StaticValues.customFonts(Colors.grey, 15, FontWeight.w700))
                   ],
                 ),




              ],
            ),
          ),
        ),
    );
  }
}
