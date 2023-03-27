import 'package:digifarmer/views/vendors/agronomist/add_schedules.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../static/color.dart';
import '../vendors_in_details.dart';
class AgronomistSchedulesBooking extends StatefulWidget {
  final int id;
  final String name;
  const AgronomistSchedulesBooking({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  State<AgronomistSchedulesBooking> createState() => _AgronomistSchedulesBookingState();
}

class _AgronomistSchedulesBookingState extends State<AgronomistSchedulesBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.barColor,
        title: Text("Add Schedules or view Booking",style: GoogleFonts.poppins(),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0,right: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width /2.5,
                        decoration: BoxDecoration(
                            color: CustomColors.barColor,
                            borderRadius: BorderRadius.circular(15)

                        ),
                        child: Center(child: Row(
                          children: [
                            SizedBox(width: 2,),
                            Icon(Icons.timer,color: Colors.white,),
                            SizedBox(width: 5,),
                            Text("Add Schedules", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),

                            ),

                          ],
                        )),
                      ),
                      onTap: (){
                        
                        Get.to(AddSchedules(id: widget.id));
                      },
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width /2.5,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(15)

                      ),
                      child: Center(child: Row(
                        children: [
                          SizedBox(width: 2,),
                          Icon(Icons.book,color: Colors.white,),
                          SizedBox(width: 5,),
                          Text("View Bookings", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),

                          ),

                        ],
                      )),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 18.0,right: 18),
                child: GestureDetector(
                  onTap: (){
                    Get.to(ViewUserVendorsInDetails(url: "vendors/agronomist_vendor_services/",id: widget.id,isCart: false,cartApi: "",));

                  },
                  child: Container(
                    color: CustomColors.gary,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Continue ",style: GoogleFonts.poppins(fontSize: 15,color: Colors.blueAccent),),
                        Text(widget.name,style: GoogleFonts.poppins(fontSize: 15,color: Colors.grey.shade600),)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),),
        ),
      ),
    );
  }
}
