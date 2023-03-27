import 'dart:convert';

import 'package:digifarmer/models/country.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/profile/address/address.dart';
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
import 'location2.dart';


class FilterLocation extends StatefulWidget {
  final String name;
  final String title;
  final String searchRoute;
  final String vendorType;
  final String type;
  const FilterLocation({Key? key, required this.name, required this.title, required this.searchRoute, required this.vendorType, required this.type}) : super(key: key);

  @override
  State<FilterLocation> createState() => _FilterLocationState();
}

class _FilterLocationState extends State<FilterLocation> {

  var countries;






  final List<String> items = [
    'A_Item1',
    'A_Item2',
    'A_Item3',
    'A_Item4',
    'B_Item1',
    'B_Item2',
    'B_Item3',
    'B_Item4',
  ];


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







  List country_data = [];
  List district_data = [];






  //default id for the dropdown
  //its null for me you can copy an id from api and place here it will be seen....
  Future<String> regions() async {
    var res = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/regions"),
        headers: {"Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    print(resBody['data']);

    setState(() {
      country_data = resBody['data'];
    });


    return "Sucess";
  }
  Future<List<Data>> districts(String id) async {


    var res = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/region/$id/districts"),
        headers: {"Accept": "application/json"}); //if you have any auth key place here...properly..


    var jsonData = jsonDecode(res.body);





    List<Data> faqsData = [];

    print(jsonData['data']);

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
    this.regions();

    regions();

  }





  String? selectedCountryId;
  String? selectedDistrict;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Location"),
        backgroundColor: CustomColors.barColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 1.8,
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [



                GestureDetector(
                  onTap: (){
                    Get.to(FilterLocation2(name: "",id: "1",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType,type: widget.type,));
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
                          child: Text("Central Region",style: StaticValues.customFonts(Colors.black,18, FontWeight.w500),),
                        ),

                        Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Get.to(FilterLocation2(name: "",id: "2",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType, type: widget.type,));
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
                          child: Text("Western Region",style: StaticValues.customFonts(Colors.black,18, FontWeight.w500),),
                        ),

                        Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Get.to(FilterLocation2(name: "",id: "3",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType, type: widget.type,));
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
                          child: Text("Eastern Region",style: StaticValues.customFonts(Colors.black,18, FontWeight.w500),),
                        ),

                        Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Get.to(FilterLocation2(name: "",id: "4",title: widget.title,searchRoute: widget.searchRoute,vendorType: widget.vendorType, type: widget.type,));
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
                          child: Text("Northern Region",style: StaticValues.customFonts(Colors.black,18, FontWeight.w500),),
                        ),

                        Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                      ],
                    ),
                  ),
                ),












              ],
            ),
          ),
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