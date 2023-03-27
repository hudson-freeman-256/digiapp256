import 'package:digifarmer/models/agronomist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../services/home_service.dart';
import '../../../../static/color.dart';
import '../../../../static/static_values.dart';

import '../../../models/farmeq.dart';
import '../../../services/add_Edit_Delete_Update_vendor_services.dart';

import '../../wigets/filter.dart';
import '../../wigets/no_product.dart';
import '../../wigets/search.dart';
import '../../wigets/single_vendor.dart';
import '../vendors_in_details.dart';

class AgronomistView extends StatefulWidget {
  const AgronomistView({Key? key}) : super(key: key);

  @override
  State<AgronomistView> createState() => _AgronomistViewState();
}

TextEditingController search = TextEditingController();

class _AgronomistViewState extends State<AgronomistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.barColor,
        title: Text("Agronomist",style: StaticValues.customFonts(Colors.white,20,FontWeight.w700),),

      ),
      body:   SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Filter(min:1000 ,max: 50000000,type: "agronomist",title: "Agronomist",searchRoute: 'agronomist-services', vendorType: 'vendors/farm_equipments/',),
      SearchWidget(search: search, searchRoute: 'agronomist-services', vendorType: 'vendors/farm_equipments/',),
      SizedBox(height: 10,),

    //   Flexible(
    //   child: FutureBuilder(
    //   future: HomeService.getAgronomist(),
    //   builder: (BuildContext context,
    //
    //   AsyncSnapshot<List<Agronomist>> snapshot) {
    //
    //     print(snapshot.data);
    //   if (snapshot.connectionState != ConnectionState.done) {
    //
    //   return const Center(child: Padding(
    //   padding: EdgeInsets.all(8.0),
    //   child: CircularProgressIndicator(color: CustomColors.barColor,),
    //   ));
    //
    //   }else if(snapshot.hasError){
    //
    //   return Text(snapshot.error.toString());
    //   }
    //   else {
    //   return ListView.builder(
    //   physics: NeverScrollableScrollPhysics(),
    //   shrinkWrap: true,
    //   itemBuilder: (BuildContext context, int index) {
    //   return  GestureDetector(
    //   onTap: (){
    //   Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: 'vendors/agronomist_vendor_services/',isCart: false,cartApi: "",));
    //   },
    //   child: SingleVendorCard(
    //   snapshot.data![index].name! ?? "",
    //   snapshot.data![index].description! ?? "",
    //   StaticValues.mainApi+snapshot.data![index].image! ?? "",
    //   snapshot.data![index].chargeUnit! ?? "",
    //   snapshot.data![index].charge! ?? 0,
    //   snapshot.data![index].location != null ? snapshot.data![index].location! :  ""
    //   ),
    //   );
    //   },
    //   itemCount:snapshot.data?.length
    //   );
    //   }
    //   },
    // ),
    // ),

        Flexible(
          child: FutureBuilder(
            future:  HomeService.getAgronomist(),
            builder: (BuildContext context,

                AsyncSnapshot<List<Agronomist>> snapshot) {


              if (snapshot.connectionState != ConnectionState.done ||
                  snapshot.hasData == null) {

                return const Center(child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(color: CustomColors.barColor,),
                ));

              }else if(snapshot.hasError){

                return const ProductError(name: "Agronomist",);


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
                          Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: 'vendors/agronomist_vendor_services/',isCart: false,cartApi: "",));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleVendorCard(
                              snapshot.data![index].name! ?? "",
                              snapshot.data![index].description! ?? "",
                              StaticValues.mainApi+snapshot.data![index].image! ?? "",
                              "UGX" ?? "",
                              snapshot.data![index].charge  ?? 0,
                               ""
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
    ));

  }
}


