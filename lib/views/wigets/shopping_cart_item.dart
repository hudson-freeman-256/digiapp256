import 'package:digifarmer/static/static_values.dart';
import 'package:digifarmer/views/home/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../static/color.dart';

class ShoppingCartItem extends StatefulWidget {

  final String image,title,description;

  final  int amount;
  final int totalCourt;

  final String type;
  final  void Function() onDelete;
  final  void Function() onIncrease;
  final  void Function() onDecrease;
  const ShoppingCartItem({Key? key, required
  this.image,
    required this.title,
    required this.description,
    required this.amount,
    required this.totalCourt,
    required this.onDelete,
    required this.type,
    required this.onIncrease,
    required this.onDecrease}) : super(key: key);

  @override
  State<ShoppingCartItem> createState() => _ShoppingCartItemState();
}



int currentValue = 1;
int currentAmount = 0 ;

bool isRent = false;
class _ShoppingCartItemState extends State<ShoppingCartItem> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    if(widget.type.contains("rent")){
      isRent = true;
    }




    currentAmount = widget.amount;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            child: FadeInImage(

                placeholder: const AssetImage('assets/LOADING_ANIMATION.gif'),
                image: NetworkImage(widget.image!),

                imageErrorBuilder:
                    (context, error, StackTrace) {
                  return const Image(
                      width: 50,
                      height: 50,
                      image:
                      AssetImage("assets/no_image.jpg"));
                }


            ),
          ),
          SizedBox(width: 5,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.9,
                child: Text(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 15),
                ),
              ),
              SizedBox(height: 2,),
              Text(widget.description,style: GoogleFonts.poppins(fontSize: 10,color: CustomColors.gary),),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text(StaticValues.formatter.format(currentAmount),style: GoogleFonts.poppins(fontSize: 15,color: CustomColors.barColor)),

                ],
              )

            ],
          ),
          SizedBox(width: 10,),


            Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Container(height: 20,child: Text(""),),

               Container(
                 height: 25,
                 child: Row(
                   children: [

                     GestureDetector(
                       onTap: widget.onIncrease,
                       child: Container(
                         child: Center(child: Text("+",style: GoogleFonts.poppins(fontSize: 20,color: Colors.grey),)),
                         color: Colors.blue.shade50,
                         width: 25,
                         height: 25,

                       ),
                     ),
                     SizedBox(width: 5,),
                     // Text(currentCount.toString()),
                     SizedBox(width: 5,),
                     GestureDetector(
                       onTap: widget.onDecrease,
                       child: Container(
                         child: Center(child: Text("-",style: GoogleFonts.poppins(fontSize: 20,color: Colors.grey),)),
                         color: Colors.blue.shade50,
                         width: 25,
                         height: 25,

                       ),
                     ),

                   ],
                 ),
               ),
               SizedBox(height: 15,),
               Container(
                 height: 20,
                 child: GestureDetector(
                     onTap : widget.onDelete,


                     child: Text("Remove",style: GoogleFonts.poppins(color: CustomColors.gary),)),
               )
             ],
           )
        ],

      ),
    );
  }
}