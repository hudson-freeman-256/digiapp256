import 'package:digifarmer/models/cropharvest.dart';
import 'package:digifarmer/models/expense.dart';
import 'package:digifarmer/views/farm/expenseui/addexpense.dart';
import 'package:digifarmer/views/farm/expenseui/editordelete.dart';
import 'package:digifarmer/views/farm/harvest/addharvest.dart';
import 'package:digifarmer/views/wigets/refreshWiget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/Farm.dart';
import '../../../services/farm_service.dart';
import '../../../static/color.dart';
import '../farmui/viewfarm.dart';
import 'editordelete.dart';

class ViewHarvest extends StatefulWidget {
  final String id;
  const ViewHarvest({Key? key, required this.id}) : super(key: key);

  @override
  State<ViewHarvest> createState() => _ViewHarvestState();
}

class _ViewHarvestState extends State<ViewHarvest> {

  Map<String,dynamic>? harvest_data  ;





  Future<List<Farm>>  farms()  {
    return FarmService.getFarms();
  }

  final List<String> items = [
    'Kampala Farm',

    'B_Item4',
  ];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: CustomColors.barColor,
      //     child: Icon(Icons.add),
      //     onPressed: (){
      //       Get.to(AddHarvest());
      //     }
      //
      // ),
      appBar: AppBar(
        title: const Text("View Crop Harvest"),
        backgroundColor: CustomColors.barColor,

      ),
      body: RefreshWidget(
        refresh: farms,
        widget: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    setState(() {

                    });
                  },
                    child: const Icon(Icons.refresh)),
                Card(
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(21.0),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Plot",style: GoogleFonts.actor(color: CustomColors.barColor,fontWeight: FontWeight.w900,fontSize: 15),),
                        Text("Quantity",style: GoogleFonts.actor(color: CustomColors.barColor,fontWeight: FontWeight.w900,fontSize: 15),),
                        // Text("Total Quantity",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 15),),
                        // Text("Plot",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 15),),
                        // Text("Size Unit",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 15),),

                      ],
                    ),
                  ),
                ),

                FutureBuilder<List<CropHarvests>>(
                  future: FarmService.getHarvest(widget.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {




                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {

                              // return Text('${snapshot.data![index]?.name.toString()}');

                              return  GestureDetector(
                                onTap: (){


                                  
                                  // Get.to(EditOrDeleteHarvest(id: snapshot.data![index].id.toString(),name: snapshot.data![index].plot!,));

                                  // Get.to(EditOrDeleteExpense(id: snapshot.data![index]!.id.toString(),name: snapshot.data![index]!.expenseCategory!,));
                                },
                                child: Column(
                                  children: [
                                    Card(
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
                                                        width: MediaQuery.of(context).size.width / 4,
                                                        child: Text(
                                                            snapshot.data![index].plot!),
                                                        // maxLines: 1,
                                                        // overflow: TextOverflow.ellipsis,
                                                        // softWrap: false,
                                                        // style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(context).size.width / 5.7,
                                                        child: Text(
                                                            snapshot.data![index].quantity!),
                                                        // maxLines: 1,
                                                        // overflow: TextOverflow.ellipsis,
                                                        // softWrap: false,
                                                        // style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),
                                                      ),

                                                    ]
                                                )
                                              ]),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              );

                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Row(),

                                  Row(
                                    children: [

                                      Text("Total: ",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w600),),
SizedBox(width: 5,),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 35.0),
                                        child: Text(FarmService.totalHarvest!,style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400),),
                                      )
                                    ],
                                  )

                                ]
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Column(
                        children: [
                          Text('No Crop Harvest Found',style: GoogleFonts.poppins(color: Colors.redAccent),),
                          Row(
                            children: [
                              Text("Return to Farm to create a crop harvest ",style: GoogleFonts.poppins(),),
                              GestureDetector(
                                child: Text("Farm",style: GoogleFonts.poppins(color: CustomColors.barColor),),
                                onTap: (){
                                  Get.to(ViewFarm());
                                },
                              )
                            ],
                          )
                        ],
                      );
                    }
                    return const Center(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(color: CustomColors.barColor,),
                    ));
                  },
                ),







              ],
            ),
          ),
        ),),
    );
  }
}
