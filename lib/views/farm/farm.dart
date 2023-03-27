import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:digifarmer/models/user.dart';
import 'package:digifarmer/services/auth_service.dart';
import 'package:digifarmer/views/farm/animalui/addanimal.dart';
import 'package:digifarmer/views/farm/animalui/viewanimal.dart';
import 'package:digifarmer/views/farm/farmui/viewfarm.dart';
import 'package:digifarmer/views/farm/harvest/addharvest.dart';
import 'package:digifarmer/views/farm/plotui/viewplot.dart';
import 'package:digifarmer/views/farm/task/viewtask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';



import '../../static/color.dart';
import '../../utils.dart';
import 'expenseui/viewexpense.dart';

class Farm extends StatefulWidget {
  const Farm({Key? key}) : super(key: key);

  @override
  State<Farm> createState() => _FarmState();
}

class _FarmState extends State<Farm> {








  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        color: CustomColors.white,
        child: Column(
          children: [

            Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text("Hello,",style: GoogleFonts.abel(fontSize: 20),),



                       Text(AuthService.firstName.toUpperCase() + " " +AuthService.lastName.toUpperCase(),style: GoogleFonts.abel(fontSize: 20,color: CustomColors.barColor,fontWeight: FontWeight.bold),)
                        ],
                      ),

                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text("My Farm",style: GoogleFonts.abel(fontSize: 30,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(''
    "Welcome to the farm screen To get started, you can create a new farm by going to the 'Farms' clicking on 'Shaking Farm Icon'. Once you've created a farm, you can add plots, expenses, animals, tasks, and harvest records to keep track of everything on your farm",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: CustomColors.gary),),
              ),

            Expanded(
              child: Center(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5
                  ),
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){

                        Get.to(const ViewFarm());
                      },
                      child:          Container(
                        width: MediaQuery.of(context).size.width,

                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/farm/3.png",height: 300,),
                            // Text(AuthService.firstName.toUpperCase()+"'s Farm",style: GoogleFonts.abel(fontSize: 25,fontWeight: FontWeight.bold,color: CustomColors.barColor))
                          ],
                        ),
                      ) ,
                    ),

                  ],
                ),
              ),
            ),










          ],
        ),
      ),
    );




  }
}
