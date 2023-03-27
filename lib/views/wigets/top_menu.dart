import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../static/color.dart';


class TopMenu extends StatefulWidget {
  final String? title;
  final Function()  onTap;

  const TopMenu({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  State<TopMenu> createState() => _TopMenuState();
}

class _TopMenuState extends State<TopMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.barColor,
      height: 50,
      child: Row(
        children: [
          SizedBox(width: 10,),
          GestureDetector(
              onTap: widget.onTap ,
              child: Icon(Icons.arrow_back_ios,color: CustomColors.aBackground,)),
          SizedBox(width: 30,),
          Text(widget.title!,style: GoogleFonts.poppins(color: Colors.white),)

        ],
      ),
    );
  }
}
