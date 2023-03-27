import 'dart:convert';

import 'package:digifarmer/models/country.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/profile/address/address.dart';
import 'package:digifarmer/views/vendors/price_range.dart';
import 'package:digifarmer/views/wigets/price_range.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:textfields/textfields.dart';
import 'package:http/http.dart' as http;
import 'package:enhanced_drop_down/enhanced_drop_down.dart';

import '../../../services/address_service.dart';
import '../../../static/static_values.dart';


class FilterLocation2 extends StatefulWidget {
  final String name;
  final String id;
  final String title;
  final String searchRoute;
  final String vendorType;
  final String type;
  const FilterLocation2({Key? key, required this.name, required this.id, required this.title, required this.searchRoute, required this.vendorType, required this.type}) : super(key: key);

  @override
  State<FilterLocation2> createState() => _FilterLocation2State();
}

class _FilterLocation2State extends State<FilterLocation2> {

  var countries;







  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(color: CustomColors.barColor,),
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











  //default id for the dropdown
  //its null for me you can copy an id from api and place here it will be seen....

  Future<List<Data>> districts(String id) async {


    var res = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/region/$id/districts"),
        headers: {"Accept": "application/json"}); //if you have any auth key place here...properly..


    var jsonData = jsonDecode(res.body);





    List<Data> faqsData = [];



    for(var faqs in  jsonData['data']){
      Data faqsDataOne = Data( faqs["id"], faqs["name"]);

      faqsData.add(faqsDataOne);
    }






    return faqsData;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Location"),
        backgroundColor: CustomColors.barColor,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Data>>(
          future: this.districts(widget.id),
          builder: ( context,  snapshot){
            if(snapshot.connectionState == ConnectionState.done){

              if(snapshot.hasData){

                return ListView.builder(
                    itemBuilder: (context,index){

                      var data = snapshot.data?[index];
                      // return Container(
                      //   child: Text('${data?.question}'),
                      // );



                      return    Column(
                        children: [
                          GestureDetector(
                            onTap: (){




    if(widget.type == "farm"){

    Get.to(ViewPriceRange(urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm_equipments/location_filter?district_id=${data!.id}",name: widget.title,param: "farm-equipments",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type,));
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



                              // Get.to(ViewPriceRange(name: widget.name,title:widget.title ,vendorType:widget.vendorType ,searchRoute:widget.searchRoute ,param: "" ,urlTo: "https://digifarmer.agrosahas.co/farmerapp/public/api/v1//farm_equipments/location_filter?district_id=${widget.id}"));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(data!.name!,style: StaticValues.customFonts(Colors.black,18, FontWeight.w500),),
                                  ),

                                  Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      );


                    },
                    itemCount: snapshot.data?.length ?? 0);






              }else{
                return Text("No Data");
              }

              //Build you UI
            }else{
              return Center(child: CircularProgressIndicator(color: CustomColors.barColor,));
            }
          },
        ),
      ),
    );
  }





}

class Data{
  final  int id;
  String name;
  Data(this.id, this.name);
}