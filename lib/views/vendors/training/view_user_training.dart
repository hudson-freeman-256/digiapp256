import 'package:digifarmer/services/auth_service.dart';

import 'package:digifarmer/views/wigets/refreshWiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/Farm.dart';
import '../../../../models/animal_feeds.dart';
import '../../../../models/training.dart';
import '../../../../services/add_Edit_Delete_Update_vendor_services.dart';
import '../../../../services/farm_service.dart';
import '../../../../services/home_service.dart';
import '../../../../static/color.dart';
import '../../../../static/static_values.dart';

import '../../wigets/no_product.dart';
import '../../wigets/search.dart';
import '../../wigets/single_vendor.dart';
import '../vendors_in_details.dart';
import 'add_training.dart';
class ViewUserTraining extends StatefulWidget {
  const ViewUserTraining({Key? key}) : super(key: key);

  @override
  State<ViewUserTraining> createState() => _ViewUserTrainingState();
}


Future<List<Farm>>  farms()  {
  return FarmService.getFarms();
}




class _ViewUserTrainingState extends State<ViewUserTraining> {

  @override
  void initState()  {
    super.initState();



  }

  TextEditingController search = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Training",style: StaticValues.customFonts(Colors.white,20,FontWeight.w700),),
        backgroundColor: CustomColors.barColor,
      ),

  floatingActionButton: FloatingActionButton(
    onPressed: (){
       Get.to(AddTraining());
    },
    backgroundColor: CustomColors.barColor,
    child: Icon(Icons.add),
  ),

      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            SearchWidget(search: search, searchRoute: 'farmer-trainings', vendorType: 'vendors/training-vendor-services/',),

            SizedBox(height: 10,),

            // Flexible(
            //   child: FutureBuilder(
            //     future: AddVendorService.getUserTraining(),
            //     builder: (BuildContext context,
            //
            //         AsyncSnapshot<List<TrainingVendor>> snapshot) {
            //
            //
            //       if (snapshot.connectionState != ConnectionState.done ||
            //           snapshot.hasData == null) {
            //
            //         return const Center(child: Padding(
            //           padding: EdgeInsets.all(8.0),
            //           child: CircularProgressIndicator(color: CustomColors.barColor,),
            //         ));
            //
            //       } else {
            //         return ListView.builder(
            //             physics: NeverScrollableScrollPhysics(),
            //             shrinkWrap: true,
            //             itemBuilder: (BuildContext context, int index) {
            //               return  GestureDetector(
            //
            //                 onTap: (){
            //                   Get.to(ViewUserVendorsInDetails(url: "vendors/training-vendor-services/",id: snapshot.data![index].id!,isCart: false,cartApi: "",));
            //                 },
            //                 child: SingleVendorCard(
            //                     snapshot.data![index].name! ?? "",
            //                     snapshot.data![index].description! ?? "",
            //                     StaticValues.mainApi+"/"+snapshot.data![index].image! ?? "",
            //                     "UGX",
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
                future:  AddVendorService.getUserTraining(),
                builder: (BuildContext context,

                    AsyncSnapshot<List<TrainingVendor>> snapshot) {


                  if (snapshot.connectionState != ConnectionState.done ||
                      snapshot.hasData == null) {

                    return const Center(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(color: CustomColors.barColor,),
                    ));

                  }
                  else if(snapshot.hasError){


                    return const ProductError(name: "Training",);


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

                              Get.to(ViewUserVendorsInDetails(url: "vendors/training-vendor-services/",id: snapshot.data![index].id!,isCart: false,cartApi: "",));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleVendorCard(
                                  snapshot.data![index].name! ?? "",
                                  snapshot.data![index].description! ?? "",
                                  StaticValues.mainApi+snapshot.data![index].image! ?? "",
                                  "UGX",
                                  snapshot.data![index].charge  ?? 0,
                                  "" ?? ""
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
