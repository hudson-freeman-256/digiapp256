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

import 'package:http/http.dart' as http;

import '../../services/price_range_services.dart';
import '../wigets/filter.dart';
import '../wigets/no_product.dart';
import '../wigets/search.dart';
import '../wigets/single_vendor.dart';

// searchRoute: 'farmer-trainings', vendorType: 'vendors/training-vendor-services/',

class ViewPriceRange extends StatefulWidget {
  final String urlTo;
  final String name;
  final String title;
  final String type;
  final String searchRoute;
  final String vendorType;
  final String param;
  const ViewPriceRange({Key? key, required this.urlTo, required this.name, required this.param, required this.title, required this.searchRoute, required this.vendorType, required this.type}) : super(key: key);

  @override
  State<ViewPriceRange> createState() => _ViewPriceRangeState();
}

TextEditingController search = TextEditingController();

class _ViewPriceRangeState extends State<ViewPriceRange> {




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
        title: Text(widget.title,style: StaticValues.customFonts(Colors.white,20,FontWeight.w700),),
        backgroundColor: CustomColors.barColor,
      ),

      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[


            Filter(min:5000 ,max: 50000000,type: "farm",title: widget.title,searchRoute: widget.searchRoute, vendorType: widget.vendorType,),

          SearchWidget(search: search, searchRoute: widget.searchRoute, vendorType: widget.vendorType,),
            SizedBox(height: 10,),





            Flexible(
              child: FutureBuilder(
                future: PriceRangeService.priceRange(widget.urlTo,widget.param),
                builder: (BuildContext context,

                    AsyncSnapshot<List<dynamic>> snapshot) {



 print(widget.urlTo);




                  if (snapshot.connectionState != ConnectionState.done) {

                    return const Center(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(color: CustomColors.barColor,),
                    ));

                  }
                  else if(snapshot.hasError){

                    return const ProductError(name: "Product",);


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
                        final product = snapshot.data![index];

                        return  GestureDetector(
                            onTap: (){


                        Get.to(ViewUserVendorsInDetails (url: "vendors/rent_vendor_services/",id: snapshot.data![index].id!,isCart: true,cartApi: "user/rent-service/cart/new",));




                              if(widget.type == "farm"){

                                Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: 'vendors/farm_equipments/',isCart: false,cartApi: "",));
                              }else if(widget.type == "vet"){
                                Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: 'vendors/veterinaries/',isCart: false,cartApi: "",));
                              }else if(widget.type == "agronomist"){
                                Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: 'vendors/agronomist_vendor_services/',isCart: false,cartApi: "",));
                              }else if(widget.type == "animal"){

                                Get.to(ViewUserVendorsInDetails(url: "vendors/animal-feeds/",id: snapshot.data![index].id!,isCart: true,cartApi: "user/animal-feed/cart/",));
                              }else if(widget.type == "training"){
                                Get.to(ViewUserVendorsInDetails(url: "vendors/training-vendor-services/"
                                    "",id: snapshot.data![index].id!,isCart: false,cartApi: "",));
                              }else if(widget.type == "rent"){
                                Get.to(ViewUserVendorsInDetails (url: "vendors/rent_vendor_services/",id: snapshot.data![index].id!,isCart: true,cartApi: "user/rent-service/cart/new",));



                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleVendorCard(
                                  product['name'],
                                  ""  ?? "",
                                  StaticValues.mainApi+product['image'] ?? "",
                                  "UGX" ?? "",
                                  product['price'] != null ? product['price'] : product['charge'],
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