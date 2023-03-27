
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


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



class ViewSort extends StatefulWidget {
  final String urlTo;
  final String param;
  const ViewSort({Key? key, required this.urlTo, required this.param}) : super(key: key);

  @override
  State<ViewSort> createState() => _ViewSortState();
}

TextEditingController search = TextEditingController();

class _ViewSortState extends State<ViewSort> {


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
        title: Text("Price Range",style: StaticValues.customFonts(Colors.white,20,FontWeight.w700),),
        backgroundColor: CustomColors.barColor,
      ),

      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[


            // Filter(min:5000 ,max: 50000000,type: "farm",),

            // SearchWidget(search: search, searchRoute: 'farm-equipments', vendorType: 'vendors/farm_equipments/',),
            SizedBox(height: 10,),


            // Flexible(
            //   child: FutureBuilder<List<dynamic>>(
            //     future: PriceRangeService.priceRange(widget.urlTo),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return ListView.builder(
            //           itemCount: snapshot.data!.length,
            //           itemBuilder: (context, index) {
            //             final product = snapshot.data![index];
            //
            //             print(product);
            //             return Container();
            //           },
            //         );
            //       } else if (snapshot.hasError) {
            //         return Text('Error: ${snapshot.error}');
            //       } else {
            //         return Center(child: CircularProgressIndicator());
            //       }
            //     },
            //   ),
            // )


            Flexible(
              child: FutureBuilder(
                future: PriceRangeService.priceRange(widget.urlTo,widget.param),
                builder: (BuildContext context,

                    AsyncSnapshot<List<dynamic>> snapshot) {








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
                        final product = snapshot.data![index];

                        return  GestureDetector(
                            onTap: (){

                              // Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: 'vendors/farm_equipments/',isCart: true,cartApi: "user/seller-product/cart/new/",));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleVendorCard(
                                  product['name'],
                                  ""  ?? "",
                                  StaticValues.mainApi+product['image'] ?? "",
                                  "UGX" ?? "",
                                  product['price'],
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