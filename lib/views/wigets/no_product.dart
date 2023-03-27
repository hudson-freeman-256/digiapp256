import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../static/color.dart';

class ProductError extends StatefulWidget {
  final String name;
  const ProductError({Key? key, required this.name}) : super(key: key);

  @override
  State<ProductError> createState() => _ProductErrorState();
}

class _ProductErrorState extends State<ProductError> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.credit_card_off_sharp,size: 50,color: CustomColors.gary,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your ${widget.name} looks to be Empty",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.grey),),
            Icon(Icons.mood_bad,color: Colors.grey,)
          ],
        ),
      ],
    );
  }
}
