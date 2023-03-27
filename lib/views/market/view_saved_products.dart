import 'dart:convert';
import 'package:http/http.dart' as http;
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
import '../../models/crop_on_sale_market.dart';
import '../../models/market_crop.dart';
import '../../models/save_product.dart';
import '../../models/savedCrops.dart';
import '../../providers/crop_on_sale_provider.dart';
import '../../services/home_service.dart';
import '../../services/market.dart';
import '../wigets/no_product.dart';
import 'crop_category_view.dart';
import 'daily_fresh.dart';
import 'fresh_fruits.dart';


// ServiceMarket.fetchCropCategory("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/crop_category/${widget.id}/crops")
class ViewSaveProduct extends StatefulWidget {



  @override
  State<ViewSaveProduct > createState() => _ViewSaveProductState();
}

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


class _ViewSaveProductState extends State<ViewSaveProduct > {
  @override
  Widget build(BuildContext context) {

    // https://digifarmer.agrosahas.co/farmerapp/public/api/v1/crop_category/2/crops

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.barColor,
        title: Text("Save Product(s)"),

      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(

          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[




            SizedBox(height: 5,),
            FutureBuilder<List<SavedCrops>>(
              future: ServiceMarket.getCropOnSaleSaved(),
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
                                    Get.to(ProductDetailsView(api: snapshot.data![index].id.toString(), isUser: false,));
                                  },
                                  child:  Container(
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
                                                image: NetworkImage(StaticValues.mainApi+"/"+snapshot.data![index].image!),

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
                                           Text("${snapshot.data![index].name}",style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 20),),
                                          ],
                                        ),

                                        GestureDetector(
                                            onTap: () async {
                                              await deleteCro(context, snapshot, index);

                                            },
                                            child: Icon(Icons.delete_forever,color: Colors.red,size: 30,))
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
                  return const ProductError(name: "Save(s) Products",);
                }
                return const Center(child: CircularProgressIndicator(color: CustomColors.barColor,));
              },
            )




          ],
        ),
      ),
    );


  }

  Future<void> deleteCro(BuildContext context, AsyncSnapshot<List<SavedCrops>> snapshot, int index) async {
    showAlertDialog(context);


    // String name,String price,String weight,String description,String selectedSubCategory,String selectedUnit,String selectedAddressId,String imagePath

    http.Response  isUploaded = await ServiceMarket.deleteCropOnSaleSaved(snapshot.data![index].id.toString());


    Navigator.pop(context);

    Map responseMap = jsonDecode(isUploaded.body);


    if(responseMap['success'] == true){

      StaticValues.successSnackBar(context, responseMap['message']);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ViewSaveProduct() ,)).then(
              (value) =>
              setState(() {
                // Call setState to refresh the page.
              })
      );

    }else{
      StaticValues.errorSnackBar(context, responseMap['message']);
    }
    // StaticValues.errorSnackBar(context, responseMap['message']);
  }
}