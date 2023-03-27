import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../static/color.dart';
class ShoppingCartWidget extends StatefulWidget {
  final int total;
  const ShoppingCartWidget({Key? key, required this.total,}) : super(key: key);

  @override
  State<ShoppingCartWidget> createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(Icons.shopping_cart,color: CustomColors.gary,size: 40,),
        Positioned(
            top: 1,
            left: 20,
            child:
            SizedBox(
              width: 20,
              height: 20,
              child: CircleAvatar(
                child: Text( widget.total > 99 ? "99+" : widget.total.toString(),style: GoogleFonts.poppins(color: Colors.white,fontSize:10,fontWeight: FontWeight.w700),),
                backgroundColor: Colors.redAccent,

              ),
            )
        )

      ],

    );
  }
}