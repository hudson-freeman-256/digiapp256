import 'package:digifarmer/models/animal.dart';
import 'package:digifarmer/views/farm/animalui/addanimal.dart';
import 'package:digifarmer/views/farm/farmui/viewfarm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/farm_service.dart';
import '../../../static/color.dart';
import '../../../static/static_values.dart';
import 'editordelete.dart';

class ViewAnimal extends StatefulWidget {
  final String id;
  final String name;
  const ViewAnimal({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  State<ViewAnimal> createState() => _ViewAnimalState();
}

class _ViewAnimalState extends State<ViewAnimal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: CustomColors.barColor,
      //     child: Icon(Icons.add),
      //     onPressed: (){
      //       Get.to(AddAnimal(id: widget.id,));
      //     }
      //
      // ),
      appBar: AppBar(
        title:  Text("View  Animal",style: StaticValues.customFonts(CustomColors.white, 20, FontWeight.w700), ),
        backgroundColor: CustomColors.barColor,

      ),
      body: Padding(
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
                      Text("Animal Cate...",style: StaticValues.customFonts(CustomColors.barColor, 15, FontWeight.w700),),
                      Text("Total",style: StaticValues.customFonts(CustomColors.barColor, 15, FontWeight.w700),),
                      Text("Plot",style: StaticValues.customFonts(CustomColors.barColor, 15, FontWeight.w700),),
                      Text("Farm",style: StaticValues.customFonts(CustomColors.barColor, 15, FontWeight.w700),),
                      // Text("Size Unit",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 15),),

                    ],
                  ),
                ),
              ),

              FutureBuilder<List<Animal>>(
                future: FarmService.getAnimal(widget.id.toString()),
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
                            print(snapshot.data![index].id);

                            Get.to(EditOrDeleteAnimal(id: snapshot.data![index].id.toString(),name: snapshot.data![index].animalCategory!,));
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
                                                  snapshot.data![index].animalCategory!),
                                              // maxLines: 1,
                                              // overflow: TextOverflow.ellipsis,
                                              // softWrap: false,
                                              // style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),
                                            ),

                                            SizedBox(
                                              width: MediaQuery.of(context).size.width / 5.7,
                                              child: Text(
                                                  snapshot.data![index].total.toString()),
                                              // maxLines: 1,
                                              // overflow: TextOverflow.ellipsis,
                                              // softWrap: false,
                                              // style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 14),
                                            ),

                                            SizedBox(
                                              width: MediaQuery.of(context).size.width / 5.7,
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
                                                  snapshot.data![index].farm!),
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
                        );

                      },
                    );
                  } else if (snapshot.hasError) {
                    return Column(
                      children: [
                         Text('No Animals Found',style: StaticValues.customFonts(Colors.red, 15, FontWeight.w700),),
                        Row(
                          children: [
                            Text("Return to Farm to create a animal ",style: StaticValues.customFonts(CustomColors.gary, 15, FontWeight.w700),),
                            GestureDetector(
                                child: Text("Farm",style: StaticValues.customFonts(CustomColors.gary, 15, FontWeight.w700),),
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
              )







            ],
          ),
        ),
      ),
    );
  }
}
