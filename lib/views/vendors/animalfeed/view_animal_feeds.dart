import 'package:digifarmer/models/animal_feeds.dart';
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

class ViewAnimalFeeds extends StatefulWidget {
  const ViewAnimalFeeds({Key? key}) : super(key: key);

  @override
  State<ViewAnimalFeeds> createState() => _ViewAnimalFeedsState();
}

TextEditingController search = TextEditingController();

class _ViewAnimalFeedsState extends State<ViewAnimalFeeds> {


  Future<List<Farm>>  farms()  {
    return FarmService.getFarms();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
   title: Text("Animal Feeds",style: StaticValues.customFonts(Colors.white,20,FontWeight.w700),),
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

              Filter(min:1000 ,max: 50000000,type: "animal" ,title: "Animal Feeds", searchRoute: 'animal-feeds', vendorType: 'vendors/animal-feeds/',),
              SearchWidget(search: search, searchRoute: 'animal-feeds', vendorType: 'vendors/animal-feeds/',),

              SizedBox(height: 10,),

              // Flexible(
              //   child: FutureBuilder(
              //     future: HomeService.getAnimalFeeds(),
              //     builder: (BuildContext context,
              //
              //         AsyncSnapshot<List<AnimalFeed>> snapshot) {
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
              //               // /user/seller-product/cart/new/{id}
              //               // /user/animal-feed/cart/new/27
              //
              //                 onTap: (){
              //                   Get.to(ViewUserVendorsInDetails(url: "vendors/animal-feeds/",id: snapshot.data![index].id!,isCart: true,cartApi: "user/animal-feed/cart/",));
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
                  future:  HomeService.getAnimalFeeds(),
                  builder: (BuildContext context,

                      AsyncSnapshot<List<AnimalFeed>> snapshot) {


                    if (snapshot.connectionState != ConnectionState.done) {

                      return const Center(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(color: CustomColors.barColor,),
                      ));

                    } else if(snapshot.hasError){


                      return const ProductError(name: "Animal Feeds",);


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

                                Get.to(ViewUserVendorsInDetails(url: "vendors/animal-feeds/",id: snapshot.data![index].id!,isCart: true,cartApi: "user/animal-feed/cart/",));
                                // Get.to(AgronomistSchedulesBooking(id: snapshot.data![index].id!,name: snapshot.data![index].name!,));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleVendorCard(
                                    snapshot.data![index].name! ?? "",
                                    snapshot.data![index].description! ?? "",
                                    StaticValues.mainApi+snapshot.data![index].image! ?? "",
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
      )),

    );
  }
}
