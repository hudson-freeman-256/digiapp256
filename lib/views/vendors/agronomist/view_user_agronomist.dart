import 'package:digifarmer/models/agronomist.dart';
import 'package:digifarmer/services/auth_service.dart';
import 'package:digifarmer/views/vendors/agronomist/agronomist_shedules_booking.dart';

import 'package:digifarmer/views/wigets/refreshWiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/Farm.dart';
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
import 'add_agronomist.dart';
class ViewUserAgronomist extends StatefulWidget {
  const ViewUserAgronomist({Key? key}) : super(key: key);

  @override
  State<ViewUserAgronomist> createState() => _ViewUserAgronomistState();
}


Future<List<Farm>>  farms()  {
  return FarmService.getFarms();
}

TextEditingController search = TextEditingController();



class _ViewUserAgronomistState extends State<ViewUserAgronomist> {

  @override
  void initState()  {
    super.initState();

    print(AddVendorService.getUserAnimalFeeds());

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Agronomist",style: StaticValues.customFonts(Colors.white,20,FontWeight.w700),),
        backgroundColor: CustomColors.barColor,
      ),

  floatingActionButton: FloatingActionButton(
    onPressed: (){
       Get.to(AddAgronomist());
    },
    backgroundColor: CustomColors.barColor,
    child: Icon(Icons.add),
  ),

      body: RefreshWidget(
          refresh: farms,
          widget: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              SizedBox(height: 10,),
              SearchWidget(search: search, searchRoute: 'agronomist-services', vendorType: 'vendors/farm_equipments/',),

              //
              // Padding(
              //   padding: const EdgeInsets.only(left: 15,right: 15),
              //   child: Flexible(
              //     child: FutureBuilder(
              //       future: AddVendorService.getUserAgronomist(),
              //       builder: (BuildContext context,
              //
              //           AsyncSnapshot<List<Agronomist>> snapshot) {
              //
              //
              //         if (snapshot.connectionState != ConnectionState.done) {
              //
              //
              //           return CircularProgressIndicator(color: CustomColors.barColor,);
              //
              //         }else if (snapshot.data == null) {
              //           return Text('No Agronomist Found');
              //         }
              //       else {
              //
              //
              //           return ListView.builder(
              //               physics: NeverScrollableScrollPhysics(),
              //               shrinkWrap: true,
              //               itemBuilder: (BuildContext context, int index) {
              //
              //                 print(StaticValues.mainApi+snapshot.data![index].image!);
              //                 return  GestureDetector(
              //                   onTap: (){
              //
              //
              //                     // Get.to(ViewUserVendorsInDetails(url: "vendors/agronomist_vendor_services/",id: snapshot.data![index].id!,isCart: false,cartApi: "",));
              //
              //                     Get.to(AgronomistSchedulesBooking(id: snapshot.data![index].id!,name: snapshot.data![index].name!,));
              //                   },
              //                   child: SingleVendorCard(
              //                       snapshot.data![index].name! ?? "",
              //                       snapshot.data![index].description! ?? "",
              //                       snapshot.data![index].image ?? "",
              //                       snapshot.data![index].chargeUnit! ?? "",
              //                       snapshot.data![index].charge! ?? 0,
              //                       ""
              //                   ),
              //                 );
              //               },
              //               itemCount:snapshot.data?.length
              //           );
              //         }
              //       },
              //     ),
              //   ),
              // ),


              Flexible(
                child: FutureBuilder(
                  future:  AddVendorService.getUserAgronomist(),
                  builder: (BuildContext context,

                      AsyncSnapshot<List<Agronomist>> snapshot) {


                    if (snapshot.connectionState != ConnectionState.done ||
                        snapshot.hasData == null) {

                      return const Center(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(color: CustomColors.barColor,),
                      ));

                    }else if(snapshot.hasError){

                      return const ProductError(name: "Agronomist",);


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

                                Get.to(AgronomistSchedulesBooking(id: snapshot.data![index].id!,name: snapshot.data![index].name!,));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleVendorCard(
                                    snapshot.data![index].name! ?? "",
                                    snapshot.data![index].description! ?? "",
                                    StaticValues.mainApi+snapshot.data![index].image! ?? "",
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
      )),

    );
  }
}
