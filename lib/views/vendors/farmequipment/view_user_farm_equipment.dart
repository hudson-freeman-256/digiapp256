import 'package:digifarmer/models/farmeq.dart';
import 'package:digifarmer/services/add_Edit_Delete_Update_vendor_services.dart';
import 'package:digifarmer/views/vendors/farmequipment/add_view_farm_equ.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../services/home_service.dart';
import '../../../../static/color.dart';
import '../../../../static/static_values.dart';

import '../../wigets/no_product.dart';
import '../../wigets/search.dart';
import '../../wigets/single_vendor.dart';
import '../vendors_in_details.dart';


class ViewUserFarmEquipment extends StatefulWidget {
  const ViewUserFarmEquipment({Key? key}) : super(key: key);

  @override
  State<ViewUserFarmEquipment> createState() => _ViewUserFarmEquipmentState();
}

TextEditingController search = TextEditingController();

class _ViewUserFarmEquipmentState extends State<ViewUserFarmEquipment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.barColor,
        title: Text("Farm Equipment",style:   StaticValues.customFonts(Colors.white,20,FontWeight.w700),),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.barColor,
        child: Icon(Icons.add),
        onPressed: (){
          Get.to(AddFarmEquipment());
        },
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            SearchWidget(search: search, searchRoute: 'farm-equipments', vendorType: 'vendors/farm_equipments/',),
            SizedBox(height: 10,),

            // Flexible(
            //   child: FutureBuilder(
            //     future: AddVendorService.getUserFarmEquipment(),
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
            //                   Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: 'vendors/farm_equipments/',isCart: true,cartApi: "user/seller-product/cart/new",));
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
                future: AddVendorService.getUserFarmEquipment(),
                builder: (BuildContext context,

                    AsyncSnapshot<List<FarmEquipment>> snapshot) {


                  if (snapshot.connectionState != ConnectionState.done ||
                      snapshot.hasData == null) {

                    return const Center(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(color: CustomColors.barColor,),
                    ));

                  } else if(snapshot.hasError){

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
                              Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: 'vendors/farm_equipments/',isCart: false,cartApi: "user/seller-product/cart/new/",));
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
