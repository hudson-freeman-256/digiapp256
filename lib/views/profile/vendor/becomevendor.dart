import 'package:cached_network_image/cached_network_image.dart';
import 'package:digifarmer/static/color.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/VendorCategories.dart';
import '../../../services/home_service.dart';
import '../../../static/static_values.dart';

import '../../vendors/agronomist/view_user_agronomist.dart';
import '../../vendors/animalfeed/view_user_animal_feeds.dart';
import '../../vendors/farmequipment/view_user_farm_equipment.dart';
import '../../vendors/insuarance/view_user_insurance.dart';
import '../../vendors/rent/view_user_rent.dart';
import '../../vendors/training/view_user_training.dart';
import '../../vendors/veterinary/view_user_veterinary.dart';
import '../../wigets/images.dart';

class BecomeVendor extends StatefulWidget {
  const BecomeVendor({Key? key}) : super(key: key);

  @override
  State<BecomeVendor> createState() => _BecomeVendorState();
}

class _BecomeVendorState extends State<BecomeVendor> {


  final List<String> genderItems = [
    'Rent',
    'Training',
    'Animal Feeds',
    'Finance',
    'Agronomist',
    'Insurance',
    'Veterinary',
    'Farm Machinery',
  ];

  String? selectedValue;

  bool isAgreed = false;

  goToVendorCategory(int id,String name)  async {


    SharedPreferences preferences = await SharedPreferences.getInstance();



    if(name == "Rent"){
        Get.to(const ViewUserRent());
    }else if(name == "Training"){
      Get.to(const ViewUserTraining());
    }else if(name == "Animal Feeds"){
      Get.to(const ViewUserAnimalFeeds());
    }else if(name == "Finance"){
      StaticValues.errorSnackBar(context, "Finance is coming soon");
    }else if(name == "Agronomists"){
     Get.to(const ViewUserAgronomist());
    }else if(name == "Insuarance"){
     Get.to(const ViewUserInsurance());
    }else if(name == "Veterinary"){
      Get.to(ViewUserVeterinary());
    }else if(name == "Farm Equipments"){
       Get.to(ViewUserFarmEquipment());
    }





    // Get.to(MultipleVendor(),arguments: [
    //   {"id": id},
    //   {"name": name}
    // ]);


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Padding(padding: EdgeInsets.all(20),
                child:  Row(
                  children: [
                    Icon(Icons.arrow_back_outlined),
                    const SizedBox(width: 3,),
                    Text("Back",style: StaticValues.customFonts(Colors.grey.shade700, 16, FontWeight.w500),)
                  ],
                ),

              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome to  become a \nvendor",style: StaticValues.customFonts(Colors.black, 22, FontWeight.w700),),
                  SizedBox(height: 10,),
                ],
              ),
            ),



            Flexible(
              child: FutureBuilder<List<VendorCategories>>(
                future: HomeService.getVendorCategories(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {

                        return ListView.separated(
                              separatorBuilder: (BuildContext context, int index) => Divider(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return      GestureDetector(
                                  onTap: (){
                                    int  id = snapshot.data![index].id!;
                                    String name = snapshot.data![index].name!;
                                    goToVendorCategory(id,name);
                                  },
                                  child: Card(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20,bottom: 5,top: 5),
                                              child: Container(

                                                child:GestureDetector(

                                                  child:      CachedNetworkImage(
                                                    imageUrl: StaticValues.mainApi+snapshot.data![index].image!,
                                                    progressIndicatorBuilder: (context, url, downloadProgress) => Container(),
                                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                                  ),
                                                  onTap: (){
                                                    int  id = snapshot.data![index].id!;
                                                    String name = snapshot.data![index].name!;
                                                    goToVendorCategory(id,name);
                                                  },

                                                ) ,
                                                height: 100,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(snapshot.data![index].name!,style: StaticValues.customFonts(Colors.black, 16, FontWeight.w500),),


                                            ),
                                          ],
                                        ),


                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },

                               );



                  } else if (snapshot.hasError) {
                    return const Center(child: Text('No Data Found'));
                  }
                  return const Center(child: CircularProgressIndicator(color: CustomColors.barColor,));
                },
              ),
            ),

                  ],

          )));


  }


}
