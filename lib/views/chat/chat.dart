import 'package:digifarmer/views/wigets/top_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textfields/textfields.dart';

import '../../static/color.dart';
import '../../static/static_values.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TopMenu(title: "My Inbox", onTap: (){
Get.back();
              }),

              //other chat
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(child: Text("M",style:StaticValues.customFonts(Colors.white, 15, FontWeight.w700))),
                    SizedBox(width: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  Text("Adieus except say barton put feebly favour him. Entreaties unpleasant sufficient few pianoforte discovered uncommonly ask. Morning cousins amongst in mr weather do neither. Warmth object matter course active law spring six. Pursuit showing tedious unknown",
                          style: StaticValues.customFonts(Colors.grey.shade700, 12, FontWeight.w500),),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight:Radius.circular(15)  )
                      ),
                    )
                  ],
                ),




              ),
             //yourChat
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.3,

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  Text("Adieus except say barton put feebly favour him.  cousins amongst in mr weather do neither. Warmth object matter course active law spring six. Pursuit showing tedious unknown",
                      style: StaticValues.customFonts(Colors.grey.shade700, 12, FontWeight.w500),),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.yellow.shade50,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight:Radius.circular(15)  )
                  ),
                ),
              ),







            ],
          ),
        ),
      ),
    );
  }
}


class ExpandableInput extends StatefulWidget {
  final TextEditingController controller;
  final double collapsedHeight;
  final double expandedHeight;

  ExpandableInput({
    required this.controller,
    required this.collapsedHeight,
    required this.expandedHeight,
  });

  @override
  _ExpandableInputState createState() => _ExpandableInputState();
}

class _ExpandableInputState extends State<ExpandableInput> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: isExpanded ? widget.expandedHeight : widget.collapsedHeight,
        child: TextFormField(
          controller: widget.controller,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: 'Type something...',
          ),
        ),
      ),
    );
  }
}

