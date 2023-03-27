import 'dart:convert';

import 'package:digifarmer/models/animal_feeds.dart';
import 'package:digifarmer/models/farmeq.dart';
import 'package:digifarmer/models/veterianry.dart';
import 'package:digifarmer/services/home_service.dart';
import 'package:digifarmer/views/vendors/vendors_in_details.dart';

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
import '../../../services/auth_service.dart';

import '../../wigets/filter.dart';
import '../../wigets/no_product.dart';
import '../../wigets/search.dart';
import '../../wigets/single_vendor.dart';
import 'package:http/http.dart' as http;

import '../search_data.dart';


class ViewFarmEquipment extends StatefulWidget {
  const ViewFarmEquipment({Key? key}) : super(key: key);

  @override
  State<ViewFarmEquipment> createState() => _ViewFarmEquipmentState();
}

TextEditingController search = TextEditingController();

class _ViewFarmEquipmentState extends State<ViewFarmEquipment> {


  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(color: CustomColors.barColor,),
          Container(margin: EdgeInsets.only(left: 5),child:Text("Loading" )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }




  Future<List<Farm>>  farms()  {
    return FarmService.getFarms();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
   title: Text("Farm Equipment",style: StaticValues.customFonts(Colors.white,20,FontWeight.w700),),
   backgroundColor: CustomColors.barColor,
 ),
      
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[


            Filter(min:1000 ,max: 50000000,type: "farm",title:"Farm Equipment" ,searchRoute: 'farm-equipments', vendorType: 'vendors/farm_equipments/',),

            SearchWidget(search: search, searchRoute: 'farm-equipments', vendorType: 'vendors/farm_equipments/',),
            SizedBox(height: 10,),

            // Flexible(
            //   child: FutureBuilder(
            //     future: HomeService.getFarmEquipment(),
            //     builder: (BuildContext context,
            //
            //         AsyncSnapshot<List<FarmEquipment>> snapshot) {
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
            //                   Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: 'vendors/farm_equipments/',isCart: true,cartApi: "user/seller-product/cart/new/",));
            //                 },
            //                 child: SingleVendorCard(
            //                     snapshot.data![index].name!,
            //                     snapshot.data![index].description!,
            //                     StaticValues.mainApi+"/"+snapshot.data![index].image!,
            //                     snapshot.data![index].priceUnit!,
            //                     snapshot.data![index].price!,
            //                     snapshot.data![index].location!
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
                future: HomeService.getFarmEquipment(),
                builder: (BuildContext context,

                    AsyncSnapshot<List<FarmEquipment>> snapshot) {


                  if (snapshot.connectionState != ConnectionState.done) {

                    return const Center(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(color: CustomColors.barColor,),
                    ));

                  }
                  else if(snapshot.hasError){

                    return const ProductError(name: "Farm Equipment",);


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
                              Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: 'vendors/farm_equipments/',isCart: true,cartApi: "user/seller-product/cart/new/",));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleVendorCard(
                                  snapshot.data![index].name! ?? "",
                                  snapshot.data![index].description! ?? "",
                                  StaticValues.mainApi+snapshot.data![index].image!,
                                  snapshot.data![index].priceUnit! ?? "",
                                  snapshot.data![index].price  ?? 0,
                                  snapshot.data![index].location! ?? ""
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


