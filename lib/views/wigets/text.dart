

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextUi extends StatelessWidget{

 final String name;

  TextUi(
      { required this.name}) {

  }






  @override
  Widget build(BuildContext context) {


    return  SizedBox(
      width: MediaQuery.of(context).size.width / 5.7,
      child: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),
      ),
    );
  }


}