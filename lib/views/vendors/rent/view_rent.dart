import 'package:digifarmer/models/animal_feeds.dart';
import 'package:digifarmer/models/rent.dart';
import 'package:digifarmer/services/home_service.dart';


import 'package:digifarmer/views/wigets/refreshWiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/Farm.dart';
import '../../../../services/farm_service.dart';
import '../../../../static/color.dart';
import '../../../../static/static_values.dart';

import '../../wigets/filter.dart';
import '../../wigets/no_product.dart';
import '../../wigets/search.dart';
import '../../wigets/single_vendor.dart';
import '../vendors_in_details.dart';


class ViewRent extends StatefulWidget {
  const ViewRent({Key? key}) : super(key: key);

  @override
  State<ViewRent> createState() => _ViewRentState();
}

TextEditingController search = TextEditingController();

Future<List<Farm>>  farms()  {
  return FarmService.getFarms();
}

class _ViewRentState extends State<ViewRent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
   title: Text("Rent",style: StaticValues.customFonts(Colors.white,20,FontWeight.w700),),
   backgroundColor: CustomColors.barColor,
 ),


      body: RefreshWidget(
          refresh: farms,
          widget: SafeArea(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Filter(min:1000 ,max: 50000000,type: "rent",title: "Rent",searchRoute: 'rent-services', vendorType: 'vendors/rent_vendor_services/'),
                  SearchWidget(search: search, searchRoute: 'rent-services', vendorType: 'vendors/rent_vendor_services/',),

                  SizedBox(height: 10,),

                  // Flexible(
                  //   child: FutureBuilder(
                  //     future: HomeService.getHomeRent(),
                  //     builder: (BuildContext context,
                  //
                  //         AsyncSnapshot<List<Rent>> snapshot) {
                  //
                  //
                  //       if (snapshot.connectionState != ConnectionState.done) {
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
                  //                 onTap: (){
                  //                   Get.to(ViewUserVendorsInDetails (url: "vendors/rent_vendor_services/",id: snapshot.data![index].id!,isCart: true,cartApi: "user/rent-service/cart/new",));
                  //                 },
                  //                 child: SingleVendorCard(
                  //                     snapshot.data![index].name!,
                  //                     snapshot.data![index].description!,
                  //                     StaticValues.mainApi+snapshot.data![index].image!,
                  //                     snapshot.data![index].chargeUnit!,
                  //                     snapshot.data![index].charge!,
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
                      future:  HomeService.getHomeRent(),
                      builder: (BuildContext context,

                          AsyncSnapshot<List<Rent>> snapshot) {


                        if (snapshot.connectionState != ConnectionState.done ||
                            snapshot.hasData == null) {

                          return const Center(child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(color: CustomColors.barColor,),
                          ));

                        } else if(snapshot.hasError){

                          return const ProductError(name: "Rent",);


                        } else {
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

                                    Get.to(ViewUserVendorsInDetails (url: "vendors/rent_vendor_services/",id: snapshot.data![index].id!,isCart: true,cartApi: "user/rent-service/cart/new",));
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
          )),

    );
  }
}
