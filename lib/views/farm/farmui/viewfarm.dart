import 'dart:async';
import 'dart:math';

import 'package:digifarmer/models/Farm.dart';
import 'package:digifarmer/services/farm_service.dart';
import 'package:digifarmer/static/static_values.dart';
import 'package:digifarmer/views/farm/farmui/addfarm.dart';
import 'package:digifarmer/views/farm/farmui/editordelete.dart';
import 'package:digifarmer/views/wigets/refreshWiget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:textfields/textfields.dart';

import '../../../static/color.dart';
import '../../profile/addTask.dart';

class ViewFarm extends StatefulWidget {
  const ViewFarm({Key? key}) : super(key: key);

  @override
  State<ViewFarm> createState() => _ViewFarmState();
}

class _ViewFarmState extends State<ViewFarm> {





  @override
  void initState() {
          print(FarmService.getFarms());
  }

  @override
  Widget build(BuildContext context) {








    return  Scaffold(
       floatingActionButton: FloatingActionButton(
           backgroundColor: CustomColors.barColor,
           child: const Icon(Icons.add),
           onPressed: (){
              Get.to(const AddFarm());
           }
       ),

       appBar: AppBar(
         title: Text("Farm",style: StaticValues.customFonts(CustomColors.white, 20, FontWeight.w900),),
         backgroundColor: CustomColors.barColor,

       ),

      body:Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: RefreshIndicator(

              onRefresh: () async {
                setState(() {

                });
              },
              child: Column(
                children: [

                  Card(
                    color: Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(21.0),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Farm Name",style: StaticValues.customFonts(CustomColors.barColor, 15, FontWeight.w900),),
                          Text("Field Area",style: StaticValues.customFonts(CustomColors.barColor, 15, FontWeight.w900),),
                          // Text("Address",style: GoogleFonts.actor(color: CustomColors.barColor,fontWeight: FontWeight.w900,fontSize: 15),),
                          // Text("District",style: GoogleFonts.actor(color: CustomColors.barColor,fontWeight: FontWeight.w900,fontSize: 15),),

                        ],
                      ),
                    ),
                  ),

                  FutureBuilder<List<Farm>>(
                    future: FarmService.getFarms(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {

                        // print(snapshot.data?.length);


                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {

                            // return Text('${snapshot.data![index]?.name.toString()}');

                            return  GestureDetector(
                              onTap: (){
                                print(snapshot.data![index]?.id);
                                Get.to(EditOrDelete(id:snapshot.data![index]?.id.toString(),name:snapshot.data![index]?.name ,location: snapshot.data![index].address?.districtName!, ));
                              },
                              child: Card(
                                color: Colors.grey.shade300,
                                child: Padding(
                                  padding: const EdgeInsets.all(19.0),
                                  child: Container(
                                    child: Table(
                                      children:  [
                                        TableRow(children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width / 2,
                                                child: Text(
                                                  snapshot.data![index].name.toString(),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),
                                                ),
                                              ),



                                              // SizedBox( child: Text(snapshot.data![index].name.toString(), style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 15,),overflow: TextOverflow.ellipsis, maxLines: 1) ),
                                              Text('${snapshot.data![index]?.fieldArea.toString()} '+snapshot.data![index].sizeUnit!, style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),),
                                              // Text('${snapshot.data![index]?.addressId}', style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),),
                                              // Text('${snapshot.data![index]?.address?.addressName}', style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),),
                                            ],
                                          )
                                        ]),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );

                          },
                        );
                      } else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [



                              Center(child: Text("Sorry, You don't have any farms",style: StaticValues.customFonts(Colors.redAccent.shade400, 15, FontWeight.w500),))
                            ],
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(child: CircularProgressIndicator(color: CustomColors.barColor,)),
                      );
                    },
                  )

                  // SizedBox(height: 20,),









                ],
              ),
            ),
          )),
     );
  }
}
