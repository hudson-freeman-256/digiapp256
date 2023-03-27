import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/insuarance.dart';
import '../../../../services/home_service.dart';
import '../../../../static/color.dart';
import '../../../../static/static_values.dart';
import '../../../services/add_Edit_Delete_Update_vendor_services.dart';

import '../../wigets/filter.dart';
import '../../wigets/no_product.dart';
import '../../wigets/search.dart';
import '../../wigets/single_vendor.dart';
import '../../wigets/single_vendor_no_price.dart';
import '../vendors_in_details.dart';

class ViewInsuarance extends StatefulWidget {
  const ViewInsuarance({Key? key}) : super(key: key);

  @override
  State<ViewInsuarance> createState() => _ViewInsuaranceState();
}

TextEditingController search = TextEditingController();

class _ViewInsuaranceState extends State<ViewInsuarance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.barColor,
        title: Text("Insurance",style: StaticValues.customFonts(Colors.white,20,FontWeight.w700),),

      ),
      body: SafeArea(

         child : SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                // Filter(min:5000 ,max: 50000000,type: "insurance",),
                SearchWidget(search: search, searchRoute: 'insurance-services', vendorType: 'vendors/insuarance_vendor_services/',),

                SizedBox(height: 10,),
                //
                // Padding(
                //   padding: const EdgeInsets.only(left: 5,right: 5),
                //   child: Flexible(
                //     child: FutureBuilder(
                //       future: HomeService.getInsurance(),
                //       builder: (BuildContext context,
                //
                //           AsyncSnapshot<List<Insuarance>> snapshot) {
                //
                //
                //         if (snapshot.connectionState != ConnectionState.done) {
                //
                //           print(snapshot.data);
                //           return CircularProgressIndicator(color: CustomColors.barColor,);
                //
                //         }else if (snapshot.data == null) {
                //           return Text('No Data Found');
                //         }
                //         else {
                //           return ListView.builder(
                //               physics: NeverScrollableScrollPhysics(),
                //               shrinkWrap: true,
                //               itemBuilder: (BuildContext context, int index) {
                //                 return  GestureDetector(
                //                   onTap: (){
                //
                //
                //                     Get.to(ViewUserVendorsInDetails(url: "vendors/insuarance_vendor_services/",id: snapshot.data![index].id!,isCart: false,cartApi:"" ,));
                //
                //                   },
                //                   child: SingleNoPriceVendorCard(
                //                       snapshot.data![index].name! ?? "",
                //                       snapshot.data![index].description! ?? "",
                //                       StaticValues.mainApi+snapshot.data![index].image! ?? "",
                //                       snapshot.data![index].location! ?? ""
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
                    future: HomeService.getInsurance(),
                    builder: (BuildContext context,

                        AsyncSnapshot<List<Insuarance>> snapshot) {


                      if (snapshot.connectionState != ConnectionState.done ||
                          snapshot.hasData == null) {

                        return const Center(child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(color: CustomColors.barColor,),
                        ));

                      } else if(snapshot.hasError){

                        return const ProductError(name: "Insurance",);


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

                                    // Get.to(ViewUserVendorsInDetails(url: "vendors/insuarance_vendor_services/",id: snapshot.data![index].id!,isCart: false,cartApi:"" ,));

                                  StaticValues.errorSnackBar(context, "Something went wrong !!!");

                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleNoPriceVendorCard(
                                      snapshot.data![index].name! ?? "",
                                      snapshot.data![index].description! ?? "",
                                      StaticValues.mainApi+snapshot.data![index].image!,
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
          )
      ),
    );
  }
}
