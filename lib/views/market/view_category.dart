import 'package:cached_network_image/cached_network_image.dart';
import 'package:digifarmer/models/cropsOnSale.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/static/static_values.dart';
import 'package:digifarmer/views/market/add_crop_sale/view_user_crop_on_sale.dart';
import 'package:digifarmer/views/market/product_detais.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../models/VendorCategories.dart';
import '../../models/constants.dart';
import '../../models/market_crop.dart';
import '../../providers/crop_on_sale_provider.dart';
import '../../services/home_service.dart';
import '../../services/market.dart';
import 'crop_category_view.dart';
import 'daily_fresh.dart';
import 'fresh_fruits.dart';


// ServiceMarket.fetchCropCategory("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/crop_category/${widget.id}/crops")
class ViewCategory extends StatefulWidget {

  final String id;
  final String name;
  const ViewCategory({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  @override
  Widget build(BuildContext context) {

    // https://digifarmer.agrosahas.co/farmerapp/public/api/v1/crop_category/2/crops

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.barColor,
        title: Text(widget.name,style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700),),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(

          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[




            SizedBox(height: 5,),
            FutureBuilder<List<MarketCrop>>(
              future: ServiceMarket.getCropsCategoryById("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/crop_category/${widget.id}/crops"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {


                  // snapshot.data![index].addressName.toString()
                  return SizedBox(

                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return
                          GestureDetector(
                            onTap: (){

                              // Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: "vendors/rent_vendor_services/",isCart: false,cartApi: "/user/rent-service/cart/new",));
                            },
                            child:   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: GestureDetector(
                                  onTap: (){
                                    Get.to(CropCategoryView(id: snapshot.data![index].id!.toString(),name: snapshot.data![index].name!,));
                                  },
                                  child: Container(
                                    height: 80,
                                    width: MediaQuery.of(context).size.width,
                                    decoration:  BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: black.withOpacity(0.2),
                                            offset: const Offset(5, 5),
                                            blurRadius: 10,
                                          )]

                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
                                        Row(
                                          children: [
                                            FadeInImage(

                                                placeholder: const AssetImage('assets/LOADING_ANIMATION.gif'),
                                                image: NetworkImage(StaticValues.mainApi+snapshot.data![index].image!),

                                                imageErrorBuilder:
                                                    (context, error, StackTrace) {
                                                  return const Image(
                                                      width: 100,
                                                      height: 100,
                                                      image:
                                                      AssetImage("assets/no_image.jpg"));
                                                }


                                            ),
                                            // Image.network(StaticValues.mainApi+snapshot.data![index].image!,height: 100,width: 100,),
                                            SizedBox(width: 20,),
                                            Text(snapshot.data![index].name!,style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 20),),
                                          ],
                                        ),

                                        Icon(Icons.arrow_forward_ios,color: Colors.grey.shade400,size: 40,)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //  SingleVendorCard(this.name, this.description, this.image, this.price_unit, this.price, this.location);

                          );
                      },
                    ),
                  );
                } else if (snapshot.hasError || snapshot.hasData!) {
                  return const Center(child: Text('No Data Found'));
                }
                return const Center(child: CircularProgressIndicator(color: CustomColors.barColor,));
              },
            )




          ],
        ),
      ),
    );


  }
}
