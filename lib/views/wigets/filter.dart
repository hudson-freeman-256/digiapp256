import 'package:digifarmer/static/static_values.dart';
import 'package:digifarmer/views/wigets/price_range.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../vendors/location.dart';
import '../vendors/price_range.dart';

class Filter extends StatefulWidget {
  final int min;
  final int max;
  final String title;
  final String searchRoute;
  final String vendorType;
  final String type;
  const Filter({Key? key, required this.min, required this.max, required this.type, required this.title, required this.searchRoute, required this.vendorType}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white70
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  GestureDetector(

                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: (){

                            },
                            child: const Icon(Icons.sort_by_alpha,color: Colors.black,)),
                        const SizedBox(width: 10,),
                        Text("Sort",style: StaticValues.customFonts(Colors.black, 12, FontWeight.normal),)
                      ],
                    ),
                    onTap: (){



                      AlertDialog alert =      AlertDialog(
                        content: Container(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(

                                children: [
                                  Icon(Icons.sort,size: 20,),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                      onTap: (){
                                        if(widget.type == "farm"){

                                          Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm_equipments/asc_order",name: "Sorted Ascending Order",param: "seller-products",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                                        }else if(widget.type == "vet"){
                                          Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/veterinary_services/asc_order",name: "Sorted Ascending Order",param: "veterinary-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                                        }else if(widget.type == "agronomist"){
                                          Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/agronomist_services/asc_order",name: "Sorted Ascending Order",param: "agronomist-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                                        }else if(widget.type == "animal"){
                                          Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/animal_feeds/asc_order",name: "Sorted Ascending Order",param: "animal-feeds",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                                        }else if(widget.type == "training"){
                                          Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/training_services/asc_order",name: "Sorted Ascending Order",param: "training-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                                        }else if(widget.type == "rent"){
                                          Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/rent_services/asc_order",name: "Sorted Ascending Order",param: "rent-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                                        }
                                      },
                                      child: Text("Ascending order",style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),)),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Divider(),
                              Row(

                                children: [
                                  Icon(Icons.sort,size: 20,),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                      onTap: (){
                                        if(widget.type == "farm"){

                                          Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm_equipments/desc_order",name: "Sorted Descending Order",param: "seller-products",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                                        }else if(widget.type == "vet"){
                                          Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/veterinary_services/desc_order",name: "Sorted Descending Order",param: "veterinary-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                                        }else if(widget.type == "agronomist"){
                                          Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/agronomist_services/desc_order",name: "Sorted Descending Order",param: "agronomist-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                                        }else if(widget.type == "animal"){
                                          Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/animal_feeds/desc_order",name: "Sorted Descending Order",param: "animal-feeds",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                                        }else if(widget.type == "training"){
                                          Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/training_services/desc_order",name: "Sorted Descending Order",param: "training-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                                        }else if(widget.type == "rent"){
                                          Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/rent_services/desc_orderr",name: "Sorted Descending Order",param: "rent-services",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type));
                                        }

                                      },
                                      child: Text("Descending order",style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),)),
                                ],
                              ),
                              Divider(),
                              // Text("Descending order",style: StaticValues.customFonts(Colors.black, 15, FontWeight.w700)),
                            ],
                          ),
                        ),
                      );


                      showDialog(context: context, builder: (c){
                        return alert;
                      });

                      // Get.to(const LocationRange());
                    },
                  ),



                  Row(
                    children: [
                      Image.asset("assets/up.png",height: 20,),
                      SizedBox(width: 10,),
                      GestureDetector(
                          onTap: (){
                          Get.to(PriceRange(min: widget.min, max: widget.max,type: widget.type,title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType));
                          },
                          child: Text("Price: lowest to high",style: StaticValues.customFonts(Colors.black, 12, FontWeight.normal),))
                    ],
                  ),

                  GestureDetector(

                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: (){

                              Get.to(FilterLocation(name: '',title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType, type: widget.type,));

                            },
                            child: const Icon(Icons.location_on,color: Colors.black,)),
                        const SizedBox(width: 10,),
                        Text("Location",style: StaticValues.customFonts(Colors.black, 12, FontWeight.normal),)
                      ],
                    ),
                    onTap: (){

                      // Get.to(const LocationRange());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        Divider(),
      ],
    );
  }
}
