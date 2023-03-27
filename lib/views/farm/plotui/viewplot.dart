import 'package:digifarmer/services/farm_service.dart';
import 'package:digifarmer/views/farm/plotui/editordelete.dart';
import 'package:digifarmer/views/wigets/refreshWiget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/Farm.dart';
import '../../../models/Plot.dart';
import '../../../static/color.dart';
import '../../../static/static_values.dart';
import '../expenseui/addexpense.dart';
import 'addplot.dart';


class ViewPlot extends StatefulWidget {
  final String id;
  final String name;
  const ViewPlot({Key? key,required this.id,required this.name}) : super(key: key);

  @override
  State<ViewPlot> createState() => _ViewPlotState();
}

class _ViewPlotState extends State<ViewPlot> {


  Future<List<Plot>>  farms()  {
    return FarmService.getPlots(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: CustomColors.barColor,
      //     child: Icon(Icons.add),
      //     onPressed: (){
      //        Get.to(AddPlot());
      //     }
      //
      // ),
      appBar: AppBar(
        title: const Text("Plot"),
        backgroundColor:  CustomColors.barColor,

      ),
      body: RefreshWidget(
        refresh: farms,
        widget: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [


              SizedBox(height: 20,),

              Card(
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(21.0),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Plot Name",style: StaticValues.customFonts(CustomColors.barColor, 17, FontWeight.w700),),
                      Text("Size",style: StaticValues.customFonts(CustomColors.barColor, 17, FontWeight.w700),),
                      // Text("Farm",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 15),),
                      // Text("Size Unit",style: GoogleFonts.actor(color: CustomColors.barColor,fontWeight: FontWeight.w900,fontSize: 15),),

                    ],
                  ),
                ),
              ),

              FutureBuilder<List<Plot>>(
                future: FarmService.getPlots(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                    print(snapshot.data);


                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {

                        // return Text('${snapshot.data![index]?.name.toString()}');

                        return  GestureDetector(
                          onTap: (){
                           Get.to(EditOrDeletePlot(id: snapshot.data![index].id.toString(),name: snapshot.data![index].name!,acres: snapshot.data![index].size.toString()!,),);
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
                                            width: MediaQuery.of(context).size.width / 5.7,
                                            child: Text(
                                              snapshot.data![index].name! ?? "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),
                                            ),
                                          ),


                                          SizedBox( width: MediaQuery.of(context).size.width / 5.7,child: Text('${snapshot.data![index].size! } ' + snapshot.data![index].sizeUnit!, style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),)),
                                          // SizedBox( width: MediaQuery.of(context).size.width / 5.7,child: Text('${snapshot.data![index].farm! ?? ""}', style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),)),
                                          // SizedBox( width: MediaQuery.of(context).size.width / 5.7,child: Text('${snapshot.data![index].! ?? ""}', style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),))
                                          //
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
                    return Center(
                      child: Column(
                        children: [
                          Icon(Icons.error,color: Colors.red,size: 50,),
                          Text("No Plots Found",style: StaticValues.customFonts(Colors.red, 17, FontWeight.w700),),
                        ],
                      ),
                    );
                  }
                  return const Center(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(color: CustomColors.barColor,),
                  ));
                },
              )







            ],
          ),
        ),
      ),),
    );
  }
}

