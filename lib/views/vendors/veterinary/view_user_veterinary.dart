import 'package:digifarmer/models/veterianry.dart';
import 'package:digifarmer/services/auth_service.dart';


import 'package:digifarmer/views/wigets/refreshWiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/Farm.dart';
import '../../../../models/UserVeterinary.dart';
import '../../../../models/animal_feeds.dart';
import '../../../../services/add_Edit_Delete_Update_vendor_services.dart';
import '../../../../services/farm_service.dart';
import '../../../../services/home_service.dart';
import '../../../../static/color.dart';
import '../../../../static/static_values.dart';

import '../../wigets/no_product.dart';
import '../../wigets/search.dart';
import '../../wigets/single_vendor.dart';
import '../vendors_in_details.dart';
import 'add_veterinary.dart';

class ViewUserVeterinary extends StatefulWidget {
  const ViewUserVeterinary({Key? key}) : super(key: key);

  @override
  State<ViewUserVeterinary> createState() => _ViewUserVeterinaryState();
}


Future<List<Farm>>  farms()  {
  return FarmService.getFarms();
}




class _ViewUserVeterinaryState extends State<ViewUserVeterinary> {

  @override
  void initState()  {
    super.initState();

    print(AddVendorService.getUserAnimalFeeds());

  }

  TextEditingController search = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Veterinary",style: StaticValues.customFonts(Colors.white,20,FontWeight.w700),),
        backgroundColor: CustomColors.barColor,
      ),

  floatingActionButton: FloatingActionButton(
    onPressed: (){
       Get.to(AddVeterinary());
    },
    backgroundColor: CustomColors.barColor,
    child: Icon(Icons.add),
  ),

      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            SearchWidget(search: search, searchRoute: 'vet-services', vendorType: 'vendors/veterinaries/',),
            SizedBox(height: 10,),


            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width ,
                decoration: BoxDecoration(
                    color: CustomColors.barColor,
                    borderRadius: BorderRadius.circular(15)

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 2,),
                    Icon(Icons.timer,color: Colors.white,),
                    SizedBox(width: 5,),
                    Text("Add Schedules", style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),

                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            // Flexible(
            //   child: FutureBuilder(
            //     future: AddVendorService.getUserVeterinaries(),
            //     builder: (BuildContext context,
            //
            //         AsyncSnapshot<List<UserVetServices >> snapshot) {
            //
            //
            //       if (snapshot.connectionState != ConnectionState.done) {
            //
            //         return const Center(child: Padding(
            //           padding: EdgeInsets.all(8.0),
            //           child: CircularProgressIndicator(color: CustomColors.barColor,),
            //         ));
            //
            //       }else if(snapshot.hasError){
            //
            //         return Text("No Data Found");
            //       }
            //       else {
            //         return ListView.builder(
            //             physics: NeverScrollableScrollPhysics(),
            //             shrinkWrap: true,
            //             itemBuilder: (BuildContext context, int index) {
            //               return  GestureDetector(
            //                 onTap: (){
            //                   Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: 'vendors/veterinaries/',isCart: false,cartApi: "",));
            //                 },
            //                 child: SingleVendorCard(
            //                     snapshot.data![index].name! ?? "",
            //                     snapshot.data![index].description! ?? "",
            //                     StaticValues.mainApi+snapshot.data![index].image! ?? "",
            //                     snapshot.data![index].chargeUnit! ?? "",
            //                     snapshot.data![index].charge! ?? 0,
            //                     snapshot.data![index].location != null ? snapshot.data![index].location! : ""
            //                 ),
            //               );
            //             },
            //             itemCount:snapshot.data?.length
            //         );
            //       }
            //     },
            //   ),
            // ),

            Flexible(
              child: FutureBuilder(
                future: AddVendorService.getUserVeterinaries(),
                builder: (BuildContext context,

                    AsyncSnapshot<List<VetServices  >> snapshot) {


                  if (snapshot.connectionState != ConnectionState.done ||
                      snapshot.hasData == null) {

                    return const Center(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(color: CustomColors.barColor,),
                    ));

                  } else if(snapshot.hasError){

                    return const ProductError(name: "Veterinary",);


                  }

                  else {
                    return AlignedGridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      itemCount: snapshot.data?.length! ,
                      itemBuilder: (context, index) {
                        return  GestureDetector(
                            onTap: (){
                              Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: 'vendors/veterinaries/',isCart: false,cartApi: "",));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleVendorCard(
                                  snapshot.data![index].name! ?? "",
                                  snapshot.data![index].description! ?? "",
                                  StaticValues.mainApi+snapshot.data![index].image!,
                                 "UGX" ?? "",
                                   snapshot.data![index].charge  ?? 0,
                                   ""
                              ),
                            ));
                      },


                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
