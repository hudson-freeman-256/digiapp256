import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleVendor extends StatefulWidget {
  const SingleVendor({Key? key}) : super(key: key);

  @override
  State<SingleVendor> createState() => _SingleVendorState();
}

class _SingleVendorState extends State<SingleVendor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
          child: Column(
          children: [

            Stack(
              children: [


                Container(
                  width:  MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/LOADING_ANIMATION.gif'),
                    image: NetworkImage('https://www.shutterstock.com/image-vector/car-rental-company-logo-rent-600w-356620781.jpg',),
                  ),

                ),
               Positioned(
                 top: 20,
                 left: 20,
                 child: GestureDetector(
                   onTap: (){
                     Get.back();
                   },
                   child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                 ),
               ),

Positioned(
    bottom: 10,
    left: 10,
    child:
Text("Car Rentor",style: GoogleFonts.poppins(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w600),
)
)
              ],
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Reviewed By :",style: GoogleFonts.poppins(fontSize: 15,)),
                      Text("2566" ,style: GoogleFonts.poppins(fontSize: 15,color: Colors.lightGreen))
                    ],
                  ),
                  Row(

                    children: [
                      Image.network("https://www.pngitem.com/pimgs/m/186-1864298_yellow-stars-png-yellow-star-with-black-background.png",height: 20,),
                      SizedBox(width: 5,),
                      Text("4.5",style: GoogleFonts.poppins(fontSize: 15,color: Colors.lightGreen),),

                    ],
                  ),


                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Price",style: GoogleFonts.poppins(fontSize: 17),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("25800000 ",style: GoogleFonts.poppins(fontSize: 20,color: Colors.lightGreen)),
                      Text("UGX")
                    ],
                  )
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi u aliquip ex ea commodo consequatDuis aute irure dolor in reprehenderit in voluptate velit esse cillum",style: GoogleFonts.poppins(fontSize: 15),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [

                      Icon(Icons.chat,color: Colors.blue,size: 40,),
                      Text("Message"),
                    ],
                  ),
                  Row(
                    children: [

                      Icon(Icons.call,color: Colors.green,size: 40,),
                      Text("Call"),
                    ],
                  )
                ],
              ),
            ),
          ],

    ),
    ),
        ),
    ),
    ));
  }
}
