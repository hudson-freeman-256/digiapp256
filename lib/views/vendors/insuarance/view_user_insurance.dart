import 'package:digifarmer/models/insuarance.dart';
import 'package:digifarmer/services/auth_service.dart';

import 'package:digifarmer/views/wigets/refreshWiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/Farm.dart';
import '../../../../models/animal_feeds.dart';
import '../../../../services/add_Edit_Delete_Update_vendor_services.dart';
import '../../../../services/farm_service.dart';
import '../../../../services/home_service.dart';
import '../../../../static/color.dart';
import '../../../../static/static_values.dart';

import '../../wigets/no_product.dart';
import '../../wigets/search.dart';
import '../../wigets/single_vendor.dart';
import '../../wigets/single_vendor_no_price.dart';
import '../vendors_in_details.dart';
import 'add_insurance_view.dart';

class ViewUserInsurance extends StatefulWidget {

  const ViewUserInsurance({Key? key}) : super(key: key);

  @override
  State<ViewUserInsurance> createState() => _ViewUserInsuranceState();
}


Future<List<Farm>>  farms()  {
  return FarmService.getFarms();
}

TextEditingController search = TextEditingController();



class _ViewUserInsuranceState extends State<ViewUserInsurance> {

  @override
  void initState()  {
    super.initState();

    print(AddVendorService.getUserAnimalFeeds());

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Insurance",style: StaticValues.customFonts(Colors.white,20,FontWeight.w700),),
        backgroundColor: CustomColors.barColor,
      ),

  floatingActionButton: FloatingActionButton(
    onPressed: (){
       Get.to(AddInsurance());
    },
    backgroundColor: CustomColors.barColor,
    child: Icon(Icons.add),
  ),

      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            SearchWidget(search: search, searchRoute: 'vet-services', vendorType: 'vendors/veterinaries/',),
            SizedBox(height: 10,),



            Flexible(
              child: FutureBuilder(
                future:  AddVendorService.getUserInsurance(),
                builder: (BuildContext context,

                    AsyncSnapshot<List<Insuarance>> snapshot) {


                  if (snapshot.connectionState != ConnectionState.done) {

                    return const Center(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(color: CustomColors.barColor,),
                    ));

                  }
                  else if(snapshot.hasError){

                    return const ProductError(name: "Insurance",);


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

                              StaticValues.errorSnackBar(context, "Something went wrong !!!");
                               // Get.to(ViewUserVendorsInDetails(id: snapshot.data![index].id!, url: 'vendors/insuarance_vendor_services/',isCart: false,cartApi: "",));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleNoPriceVendorCard(
                                  snapshot.data![index].name! ?? "",
                                  snapshot.data![index].description! ?? "",
                                  StaticValues.mainApi+snapshot.data![index].image!,
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

    );
  }
}
