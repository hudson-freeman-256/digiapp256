import 'package:cached_network_image/cached_network_image.dart';
import 'package:digifarmer/models/cropsOnSale.dart';
import 'package:digifarmer/services/auth_service.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/static/static_values.dart';
import 'package:digifarmer/views/market/add_crop_sale/view_user_crop_on_sale.dart';
import 'package:digifarmer/views/market/location_range.dart';
import 'package:digifarmer/views/market/notification.dart';
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
import 'daily_fresh.dart';
import 'fresh_fruits.dart';


class MarketScreen extends StatefulWidget {



  const MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

TextEditingController search = TextEditingController();

class _MarketScreenState extends State<MarketScreen> {

  @override
  void initState() {
    // TODO: implement initState
    print(AuthService.token);
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.barColor,
        child: Icon(Icons.add_business),
        onPressed: (){
          Get.to(ViewUserCropOnSale());
        },
      ),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.grey.shade200,
          leading: GestureDetector(
              onTap: (){
               Get.to(NotificationScreen());
              },
              child: Icon(Icons.notifications,color: Colors.orangeAccent,size: 40,)),
          title: Text("Welcome to the Market",style:  StaticValues.customFonts(CustomColors.barColor,20,FontWeight.w700),),
          actions:  [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Get.to(ViewSaveProduct());
                },
                child: Icon(
                  Icons.book_outlined,
                  size: 35,
                  color: CustomColors.barColor,
                ),
              ),
            )
          ],
        ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: RefreshIndicator(

          onRefresh: () async{
            setState(() {

            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              const Divider(),
              Padding(
                padding:  const EdgeInsets.only(
                  left:15,
                  right: 15,
                  top: 5 * 1.5,
                ),
                child: Material(
                  elevation: 10.0,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  child:  TextField(
                    style:  StaticValues.customFonts(Colors.grey,15,FontWeight.w300),
                    controller: search,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(
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
                          child: const Icon(
                            Icons.search_rounded,
                            size: 25,
                            color: CustomColors.barColor,
                          ),
                        )),
                  ),
                ),
              ),



              const SizedBox(height: 5,),
              const Padding(
                padding: EdgeInsets.all(appPadding),
                child: Text(
                  'Crops Categories',
                  style: TextStyle(
                      fontSize: 15, letterSpacing: 1, fontWeight: FontWeight.bold,wordSpacing: 0.2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: appPadding,right: appPadding),
                child: FutureBuilder<List<VendorCategories>>(
                  future: ServiceMarket.getMarketCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {


                      // snapshot.data![index].addressName.toString()
                      return SizedBox(
                        height: 138,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return
                              GestureDetector(
                                onTap: (){
                                  //
                                  // int  id = snapshot.data![index].id!;
                                  // String name = snapshot.data![index].name!;
                                  // goToVendorCategory(id,name);
                                },
                                child: Container(
                                    width: 130,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [

                                          // FadeImage(image: ,),

                                          GestureDetector(
                                            child: CachedNetworkImage(
                                              imageUrl: StaticValues.mainApi+snapshot.data![index].image!,
                                              height: 120,
                                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                  SizedBox(
                                                    height: 20,
                                                    child: CircularProgressIndicator(
                                                        color:  Colors.transparent,
                                                        value: downloadProgress.progress

                                                    ),
                                                  ),
                                              errorWidget: (context, url, error) => const Icon(Icons.error),
                                            ),
                                            onTap: (){
                                              Get.to(ViewCategory(id: snapshot.data![index].id.toString()!,name: snapshot.data![index].name!,));
                                            },
                                          )

                                          // FadeInImage(
                                          //
                                          //  placeholder: AssetImage('assets/LOADING_ANIMATION.gif'),
                                          //  image: NetworkImage(StaticValues.mainApi+snapshot.data![index].image!,),
                                          //
                                          //     )
                                        ],
                                      ),
                                    )
                                ),
                              );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('No Data Found'));
                    }
                    return const Center(child: Text(""));

                  },
                ),
              ),




              const Padding(
                padding: EdgeInsets.all(appPadding),
                child: Text(
                  'Crops On Sale',
                  style: TextStyle(
                      fontSize: 15, letterSpacing: 1, fontWeight: FontWeight.bold,wordSpacing: 0.2),
                ),
              ),
              SizedBox(height: 5,),

              SizedBox(height: 10,),

              Flexible(
                child: FutureBuilder(
                  future: ServiceMarket.getCropOnSale(),
                  builder: (BuildContext context,

                      AsyncSnapshot<List<CropsOnSale>> snapshot) {


                    if (snapshot.connectionState != ConnectionState.done ||
                        snapshot.hasData == null) {

                      return const Center(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(color: CustomColors.barColor,),
                      ));

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
                                       Get.to(ProductDetailsView(api: snapshot.data![index].id.toString(), isUser: true,));
                                    },
                                    child: DailyFresh(image: StaticValues.mainApi+"/"+snapshot.data![index].image!, name: snapshot.data![index].name!, price: StaticValues.formatter.format(snapshot.data![index].sellingPrice), description: snapshot.data![index].description!,priceUnit: snapshot.data![index].priceUnit!,id: snapshot.data![index].id.toString(),));
                              },


                            );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );


  }
}
