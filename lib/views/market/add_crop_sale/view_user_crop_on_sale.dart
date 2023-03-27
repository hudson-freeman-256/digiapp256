import 'package:digifarmer/models/agronomist.dart';
import 'package:digifarmer/models/crop_on_sale_user.dart';
import 'package:digifarmer/services/auth_service.dart';
import 'package:digifarmer/views/market/add_crop_sale/add_crop_sale.dart';
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
import '../../../services/market.dart';

import '../../wigets/no_product.dart';
import '../../wigets/single_vendor.dart';
import '../product_detais.dart';
import '../search.dart';
class ViewUserCropOnSale extends StatefulWidget {
  const ViewUserCropOnSale({Key? key}) : super(key: key);

  @override
  State<ViewUserCropOnSale> createState() => _ViewUserCropOnSaleState();
}


Future<List<Farm>>  farms()  {
  return FarmService.getFarms();
}




class _ViewUserCropOnSaleState extends State<ViewUserCropOnSale> {

  TextEditingController search = TextEditingController();

  @override
  void initState()  {
    super.initState();



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.barColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [

           Text("See Buyer Request(s)",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),)
         ],
       ),
      ),

  floatingActionButton: FloatingActionButton(
    onPressed: (){
       Get.to(AddCropOnSale());
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

              Padding(
                padding:  EdgeInsets.only(
                  left:15,
                  right: 15,
                  top: 5 * 1.5,
                ),
                child: Material(
                  elevation: 10.0,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  child:  TextField(
                    controller: search,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 5 * 0.75,
                          horizontal: 5,
                        ),
                        fillColor: Colors.white,
                        hintText: 'Search here....',
                        suffixIcon: GestureDetector(
                          onTap: (){

                            if(search.text.isNotEmpty){
                              Get.to(MarketSearch(searchData: search.text,));
                            }else{
                              StaticValues.errorSnackBar(context, "Search area can't be empty");
                            }
                          },
                          child: Icon(
                            Icons.search_rounded,
                            size: 25,
                            color: CustomColors.barColor,
                          ),
                        )),
                  ),
                ),
              ),

              SizedBox(height: 10,),



              // Padding(
              //   padding: const EdgeInsets.only(left: 15,right: 15),
              //   child: Flexible(
              //     child: FutureBuilder(
              //       future: ServiceMarket.getCropOnSaleForUser(),
              //       builder: (BuildContext context,
              //
              //           AsyncSnapshot<List<CropsOnSaleUser>> snapshot) {
              //
              //
              //         if (snapshot.connectionState != ConnectionState.done) {
              //
              //
              //           return const Center(child: Padding(
              //             padding: EdgeInsets.all(8.0),
              //             child: CircularProgressIndicator(color: CustomColors.barColor,),
              //           ));
              //
              //         }else if (snapshot.data == null) {
              //           return Text(snapshot.error.toString());
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
              //                     Get.to(ProductDetailsView(api: "${snapshot.data![index].id}", isUser: false,));
              //                   },
              //                   child: SingleVendorCard(
              //                       snapshot.data![index].name! ?? "",
              //                       snapshot.data![index].description! ?? "",
              //                      StaticValues.mainApi+ snapshot.data![index].image! ?? "",
              //                       snapshot.data![index].priceUnit! ?? "",
              //                       snapshot.data![index].sellingPrice! ?? 0,
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
                  future:  ServiceMarket.getCropOnSaleForUser(),
                  builder: (BuildContext context,

                      AsyncSnapshot<List<CropsOnSaleUser>> snapshot) {


                    if (snapshot.connectionState != ConnectionState.done) {

                      return const Center(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(color: CustomColors.barColor,),
                      ));

                    } else if(snapshot.hasError){

                      return const ProductError(name: "Crop(s)",);
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

                                Get.to(ProductDetailsView(api: "${snapshot.data![index].id}", isUser: false,));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleVendorCard(
                                    snapshot.data![index].name! ?? "",
                                    snapshot.data![index].description! ?? "",
                                    StaticValues.mainApi+snapshot.data![index].image! ?? "",
                                    snapshot.data![index].priceUnit!,
                                  snapshot.data![index].sellingPrice!,
                                    snapshot.data![index].location ?? ""
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
