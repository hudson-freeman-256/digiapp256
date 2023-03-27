import 'package:digifarmer/models/task.dart';
import 'package:digifarmer/services/farm_service.dart';
import 'package:digifarmer/views/farm/task/addtask.dart';
import 'package:digifarmer/views/wigets/refreshWiget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/Farm.dart';
import '../../../static/color.dart';
import '../farmui/viewfarm.dart';
import 'editordelete.dart';

class ViewTask extends StatefulWidget {
  final String id;
  const ViewTask({Key? key, required this.id}) : super(key: key);

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {


  Future<List<Farm>>  farms()  {
    return FarmService.getFarms();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: CustomColors.barColor,
      //     child: Icon(Icons.add),
      //     onPressed: (){
      //        Get.to(AddTask());
      //     }
      //
      // ),
      appBar: AppBar(
        title: const Text("View Task"),
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
              Card(
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(21.0),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Task Name",style: GoogleFonts.actor(color: CustomColors.barColor,fontWeight: FontWeight.w900,fontSize: 15),),
                      // Text("Size",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 15),),
                      Text("Plot",style: GoogleFonts.actor(color: CustomColors.barColor,fontWeight: FontWeight.w900,fontSize: 15),),
                      Text("Date",style: GoogleFonts.actor(color: CustomColors.barColor,fontWeight: FontWeight.w900,fontSize: 15),),

                    ],
                  ),
                ),
              ),

              FutureBuilder<List<Task>>(
                future: FarmService.getTask(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                    print(snapshot.data);


                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {

                        // return Text('${snapshot.data![index]?.name.toString()}');

                        return  GestureDetector(
                          onTap: (){
                            print(snapshot.data![index]?.id);
                            Get.to(EditOrDeleteTask(id: snapshot.data![index].id!.toString(),name: snapshot.data![index].name!,plot: snapshot.data![index].plot!,date: snapshot.data![index].taskDate!,));
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
                                              snapshot.data![index].name.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),
                                            ),
                                          ),


                                          SizedBox( width: MediaQuery.of(context).size.width / 5.7,child: Text('${snapshot.data![index]?.plot}', style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),)),
                                          SizedBox( width: MediaQuery.of(context).size.width / 5.7,child: Text('${snapshot.data![index]?.taskDate}', style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),)),

                                          // SizedBox( child: Text(snapshot.data![index].name.toString(), style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 15,),overflow: TextOverflow.ellipsis, maxLines: 1) ),
                                          // Text('${snapshot.data![index]?.size}', style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),),
                                          // Text('${snapshot.data![index]?.farmId}', style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),),
                                          // Text('${snapshot.data![index]?.sizeUnit}', style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),),
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
                    return Column(
                      children: [
                        Text('No Task Found',style: GoogleFonts.poppins(color: Colors.redAccent),),
                        Row(
                          children: [
                            Text("Return to Farm to create a task ",style: GoogleFonts.poppins(),),
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Center(child: CircularProgressIndicator(color: CustomColors.barColor,)),
                  );
                },
              ),







            ],
          ),
        ),
      )),
    );
  }
}
