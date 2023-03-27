import 'package:digifarmer/services/price_range_services.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/home/home_searched.dart';
import 'package:digifarmer/views/market/searched_home.dart';
import 'package:digifarmer/views/vendors/price_range.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../static/static_values.dart';
class PriceRange extends StatefulWidget {
  final int min;
  final int max;
  final String title;
  final String searchRoute;
  final String vendorType;
  final String type;
  const PriceRange({Key? key, required this.min, required this.max, required this.type, required this.title, required this.searchRoute, required this.vendorType}) : super(key: key);

  @override
  State<PriceRange> createState() => _PriceRangeState();
}

// searchRoute: widget.searchRoute,vendorType: widget.vendorType

TextEditingController min = TextEditingController();
TextEditingController max = TextEditingController();
class _PriceRangeState extends State<PriceRange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.barColor,
        title: Text("Price Range",style: GoogleFonts.poppins(),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    width: MediaQuery.of(context).size.width /2.4,
                    child: TextField(

                      keyboardType: TextInputType.number,
                      controller: min,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Min ${StaticValues.formatter.format(widget.min)}',
                        hintText: 'Min ${StaticValues.formatter.format(widget.min)}',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    width: MediaQuery.of(context).size.width /2.4,
                    child: TextField(
                     controller: max,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Max ${StaticValues.formatter.format(widget.max)}',
                        hintText: 'Max ${StaticValues.formatter.format(widget.max)}',
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding
              (
              padding: const EdgeInsets.only(left: 18.0,right: 18),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){

                      String pMin = "1000";
                      String pMax = "50000";

                      if(widget.type == "farm"){

                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm_equipments/price_filter?min_price=$pMin&max_price=$pMax",name: "Price Range",param: "seller-products",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "vet"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/veterinary_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "veterinary-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "agronomist"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/agronomist_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "agronomist-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "animal"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/animal_feeds/price_filter?min_price=$pMin&max_price=$pMax",name: "Price Range",param: "animal-feeds",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "training"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/training_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "training-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "rent"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/rent_services/price_filter?min_price=$pMin&max_price=$pMax",name: "Price Range",param: "rent-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }


                    },
                    child: Container(

                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Under",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),),

                          SizedBox(width: 10,),
                          Text("-",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),),
                          SizedBox(width: 10,),

                          Text("50,000",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),)
                        ],
                      ),
                    ),
                  ),
                  const Divider(),

                  GestureDetector(
                    onTap: (){

                      String pMin = "100000";
                      String pMax = "200000";

                      if(widget.type == "farm"){

                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm_equipments/price_filter?min_price=${pMin}&max_price=${pMax}",name: "Price Range",param: "seller-products",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "vet"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/veterinary_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "veterinary-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "agronomist"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/agronomist_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "agronomist-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "animal"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/animal_feeds/price_filter?min_price=${pMin}&max_price=${pMax}",name: "Price Range",param: "animal-feeds",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "training"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/training_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "training-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "rent"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/rent_services/price_filter?min_price=${pMin}&max_price=${pMax}",name: "Price Range",param: "rent-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }


                    },
                    child: Container(

                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("100,000",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),),

                          SizedBox(width: 10,),
                          Text("-",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),),
                          SizedBox(width: 10,),

                          Text("200,000",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),)
                        ],
                      ),
                    ),
                  ),
                  const Divider(),


                  GestureDetector(
                    onTap: (){

                      String pMin = "300000";
                      String pMax = "500000";

                      if(widget.type == "farm"){

                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm_equipments/price_filter?min_price=${pMin}&max_price=${pMax}",name: "Price Range",param: "seller-products",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "vet"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/veterinary_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "veterinary-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "agronomist"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/agronomist_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "agronomist-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "animal"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/animal_feeds/price_filter?min_price=${pMin}&max_price=${pMax}",name: "Price Range",param: "animal-feeds",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "training"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/training_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "training-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "rent"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/rent_services/price_filter?min_price=${pMin}&max_price=${pMax}",name: "Price Range",param: "rent-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }


                    },
                    child: Container(

                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("300,000",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),),

                          SizedBox(width: 10,),
                          Text("-",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),),
                          SizedBox(width: 10,),

                          Text("500,000",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),)
                        ],
                      ),
                    ),
                  ),
                  const Divider(),


                  GestureDetector(
                    onTap: (){

                      String pMin = "1000000";
                      String pMax = "5000000";

                      if(widget.type == "farm"){

                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm_equipments/price_filter?min_price=${pMin}&max_price=${pMax}",name: "Price Range",param: "seller-products",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "vet"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/veterinary_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "veterinary-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "agronomist"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/agronomist_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "agronomist-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "animal"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/animal_feeds/price_filter?min_price=${pMin}&max_price=${pMax}",name: "Price Range",param: "animal-feeds",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "training"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/training_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "training-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "rent"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/rent_services/price_filter?min_price=${pMin}&max_price=${pMax}",name: "Price Range",param: "rent-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }


                    },
                    child: Container(

                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("1,000,000",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),),

                          SizedBox(width: 10,),
                          Text("-",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),),
                          SizedBox(width: 10,),

                          Text("5,000,000",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),)
                        ],
                      ),
                    ),
                  ),
                  const Divider(),


                  GestureDetector(
                    onTap: (){

                      String pMin = "5000000";
                      String pMax = "10000000";

                      if(widget.type == "farm"){

                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm_equipments/price_filter?min_price=${pMin}&max_price=${pMax}",name: "Price Range",param: "seller-products",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "vet"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/veterinary_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "veterinary-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "agronomist"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/agronomist_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "agronomist-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "animal"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/animal_feeds/price_filter?min_price=${pMin}&max_price=${pMax}",name: "Price Range",param: "animal-feeds",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "training"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/training_services/charge_filter?min_charge=${pMin}&max_charge=${pMax}",name: "Price Range",param: "training-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }else if(widget.type == "rent"){
                        Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/rent_services/price_filter?min_price=${pMin}&max_price=${pMax}",name: "Price Range",param: "rent-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                      }


                    },
                    child: Container(

                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("More Than",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),),

                          SizedBox(width: 10,),
                          Text("-",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),),
                          SizedBox(width: 10,),

                          Text("10,000,000",style: StaticValues.customFonts(Colors.grey, 18, FontWeight.w400),)
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),

            const SizedBox(height: 50,),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: ElevatedButton(onPressed: () async {



                if(widget.type == "farm"){

                  Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm_equipments/price_filter?min_price=${min.text}&max_price=${max.text}",name: "Price Range",param: "seller-products",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                }else if(widget.type == "vet"){
                  Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/veterinary_services/charge_filter?min_charge=${min.text}&max_charge=${max.text}",name: "Price Range",param: "veterinary-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                }else if(widget.type == "agronomist"){
                  Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/agronomist_services/charge_filter?min_charge=${min.text}&max_charge=${max.text}",name: "Price Range",param: "agronomist-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                }else if(widget.type == "animal"){
                  Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/animal_feeds/price_filter?min_price=${min.text}&max_price=${max.text}",name: "Price Range",param: "animal-feeds",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                }else if(widget.type == "training"){
                  Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/training_services/charge_filter?min_charge=${min.text}&max_charge=${max.text}",name: "Price Range",param: "training-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                }else if(widget.type == "rent"){
                  Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/rent_services/price_filter?min_price=${min.text}&max_price=${max.text}",name: "Price Range",param: "rent-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                }




              }, child: Text("Show"),      style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
              ),),
            )




          ],
        ),
      ),
    );
  }
}
