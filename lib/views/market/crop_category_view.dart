import 'dart:convert';

import 'package:digifarmer/views/wigets/price_range.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../models/constants.dart';
import '../../models/crop_on_sale_market.dart';
import '../../models/crop_on_sale_user.dart';
import '../../models/cropsOnSale.dart';
import '../../providers/crop_on_sale_provider.dart';
import '../../services/market.dart';
import '../../static/color.dart';
import '../../static/static_values.dart';
import '../wigets/filter.dart';
import 'daily_fresh.dart';
import 'product_detais.dart';

class CropCategoryView extends StatefulWidget {
  final String id;
  final String name;
  const CropCategoryView({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  State<CropCategoryView> createState() => _CropCategoryViewState();
}

// https://digifarmer.agrosahas.co/farmerapp/public/api/v1/market/crop_category/2/crops_on_sale






class _CropCategoryViewState extends State<CropCategoryView> {


  List country_data = [];

  String? countryid;                                 //default id for the dropdown
  //its null for me you can copy an id from api and place here it will be seen....
  Future<String> country() async {
    var res = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/countries"),
        headers: {"Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    setState(() {
      country_data = resBody['data'];
    });


    return "Sucess";
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.country();
  }

  String? selectedCountryId;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
appBar: AppBar(
  backgroundColor: CustomColors.barColor,
  title: Text(widget.name+"(s)",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700),),
),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // Filter(max: 1000, min: 50000, type: '',),

            SizedBox(height: 5,),






            SizedBox(height: 5,),

            SizedBox(height: 10,),


            // getCropsById
            Flexible(
              child: FutureBuilder(
                future: ServiceMarket.getCropsById(widget.id),
                builder: (BuildContext context,

                    AsyncSnapshot<List<CropOnSaleMarket>> snapshot) {


                  // print(snapshot.hashCode);

                  if (snapshot.connectionState != ConnectionState.done) {

                    return const Center(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(color: CustomColors.barColor,),
                    ));

                  } else if(!snapshot.hasData) {

                    print(snapshot.error.toString());
                       return Text(snapshot.error.toString());
                    return Text("ddd");

                  }else{
                    return AlignedGridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      itemCount: snapshot.data?.length! ,
                      itemBuilder: (context, index) {
                        return  GestureDetector(
                            onTap: (){
                              Get.to(ProductDetailsView(api: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/market/crops_on_sales/${snapshot.data![index].id}", isUser: false,));
                            },
                            child:
                             DailyFresh(
                              image: StaticValues.mainApi+snapshot.data![index].image!,
                              name: snapshot.data![index].name!,
                              price: StaticValues.formatter.format(snapshot.data![index].sellingPrice),
                              description: "",
                              priceUnit: snapshot.data![index].priceUnit!, id: snapshot.data![index].id.toString(),));
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
