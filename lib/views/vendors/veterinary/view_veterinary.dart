import 'package:digifarmer/models/animal_feeds.dart';
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

import '../../wigets/filter.dart';
import '../../wigets/no_product.dart';
import '../../wigets/search.dart';
import '../../wigets/single_vendor.dart';


class ViewVeterinary extends StatefulWidget {
  const ViewVeterinary({Key? key}) : super(key: key);

  @override
  State<ViewVeterinary> createState() => _ViewVeterinaryState();
}

class _ViewVeterinaryState extends State<ViewVeterinary> {

  TextEditingController search = TextEditingController();


  Future<List<Farm>>  farms()  {
    return FarmService.getFarms();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
   title: Text("Veterinary",style: StaticValues.customFonts(Colors.white,20,FontWeight.w700),),
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

              Filter(min:1000 ,max: 50000000, type: 'vet',title: "Veterinary",searchRoute: 'vet-services', vendorType: 'vendors/veterinaries/',),

            SearchWidget(search: search, searchRoute: 'vet-services', vendorType: 'vendors/veterinaries/',),
              SizedBox(height: 10,),



              FutureBuilder(
                future: HomeService.getVeterinary(),
                builder: (BuildContext context,

                    AsyncSnapshot<List<VetServices>> snapshot) {


                  if (snapshot.connectionState != ConnectionState.done ||
                      snapshot.hasData == null) {

                    return const Center(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(color: CustomColors.barColor,),
                    ));

                  }
                  else if(snapshot.hasError){

                    return   const ProductError(name: "Veterinary",);


                  }

                  else {
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
                              Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: 'vendors/veterinaries/',isCart: false,cartApi: "",));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleVendorCard(
                                  snapshot.data![index].name! ?? "",
                                  snapshot.data![index].description! ?? "",
                                  StaticValues.mainApi+snapshot.data![index].image!,
                                  "UGX"?? "",
                                  snapshot.data![index].charge  ?? 0,
                                  ""
                              ),
                            ));
                      },


                    );
                  }
                },
              ),
            ],
          ),
        ),
      )),

    );
  }
}
