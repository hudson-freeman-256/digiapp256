import 'package:cached_network_image/cached_network_image.dart';
import 'package:digifarmer/models/cropsOnSale.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/static/static_values.dart';
import 'package:digifarmer/views/market/add_crop_sale/view_user_crop_on_sale.dart';
import 'package:digifarmer/views/wigets/price_range.dart';
import 'package:digifarmer/views/market/product_detais.dart';
import 'package:digifarmer/views/market/search.dart';

import 'package:digifarmer/views/market/view_category.dart';
import 'package:digifarmer/views/market/view_saved_products.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../models/VendorCategories.dart';
import '../../models/constants.dart';
import '../../providers/crop_on_sale_provider.dart';
import '../../services/home_service.dart';
import '../../services/market.dart';
import '../bottommenu/bottom_menu.dart';
import 'daily_fresh.dart';
import 'fresh_fruits.dart';
import 'home_page.dart';


class MarketScreenSearch extends StatefulWidget {
  final int min;
  final int max;


  const MarketScreenSearch({Key? key, required this.min, required this.max,}) : super(key: key);

  @override
  State<MarketScreenSearch> createState() => _MarketScreenSearchState();
}

TextEditingController search = TextEditingController();

class _MarketScreenSearchState extends State<MarketScreenSearch> {
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey.shade200,
        leading: Padding(
          padding: EdgeInsets.only(left: appPadding / 2),
          child: GestureDetector(
            child: Icon(
              Icons.home,
              color: CustomColors.barColor,
              size: 35,
            ),
            onTap: (){
                   Get.back();
            },
          ),
        ),
        title: Text("Filtered by Price Or Location",style: GoogleFonts.poppins(color: CustomColors.barColor,fontSize: 17,fontWeight: FontWeight.w700),),
        actions:  [

        ],
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Divider(),
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

            Padding(
              padding: EdgeInsets.all(appPadding),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white70
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: (){

                              },
                              child: const Icon(Icons.filter_list,color: Colors.black,)),
                          SizedBox(width: 10,),
                          Text("Filter",style: GoogleFonts.poppins(fontWeight:FontWeight.w700,color: Colors.grey,fontSize: 12),)
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset("assets/up.png",height: 20,),
                          SizedBox(width: 10,),
                          GestureDetector(
                              onTap: (){
                                // Get.to(PriceRange(min: widget.min,max: widget.max, type: '',));
                              },
                              child: Text("Price: lowest to high",style: GoogleFonts.poppins(fontWeight:FontWeight.w700,color: Colors.grey,fontSize: 12),))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5,),





            Padding(
              padding: EdgeInsets.all(appPadding),
              child: Text(
                'Crops On Sale',
                style: TextStyle(
                    fontSize: 24, letterSpacing: 1, fontWeight: FontWeight.bold,wordSpacing: 0.2),
              ),
            ),
            const SizedBox(height: 5,),

            const SizedBox(height: 10,),

            // context.watch<CropOnSaleProvider>().getSearchedCropOnSale(widget.min, widget.max)
            // Flexible(
            //   child: FutureBuilder(
            //     future: context.watch<CropOnSaleProvider>().getSearchedCropOnSale(widget.min, widget.max) ,
            //     builder: (BuildContext context,
            //
            //         AsyncSnapshot<List<CropsOnSale>> snapshot) {
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
            //         return AlignedGridView.count(
            //           physics: NeverScrollableScrollPhysics(),
            //           shrinkWrap: true,
            //           crossAxisCount: 2,
            //           mainAxisSpacing: 2,
            //           crossAxisSpacing: 2,
            //           itemCount: snapshot.data?.length! ,
            //           itemBuilder: (context, index) {
            //             return  GestureDetector(
            //                 onTap: (){
            //                   Get.to(ProductDetailsView(api: snapshot.data![index].id.toString(), isUser: true,));
            //                 },
            //                 child: DailyFresh(image: StaticValues.mainApi+"/"+snapshot.data![index].image!, name: snapshot.data![index].name!, price: StaticValues.formatter.format(snapshot.data![index].sellingPrice), description: snapshot.data![index].description!,priceUnit: snapshot.data![index].priceUnit!,id: snapshot.data![index].id.toString(),));
            //           },
            //
            //
            //         );
            //       }
            //     },
            //   ),
            // ),


          ],
        ),
      ),
    );


  }
}


