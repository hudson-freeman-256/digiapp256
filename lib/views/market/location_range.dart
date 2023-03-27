import 'dart:convert';

import 'package:digifarmer/views/market/search.dart';
import 'package:digifarmer/views/market/searched_home.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:textfields/textfields.dart';

import '../../../services/auth_service.dart';

import 'package:http/http.dart' as http;

import '../../../services/farm_service.dart';
import '../../../static/color.dart';
import '../../../static/static_values.dart';

class LocationRange extends StatefulWidget {

  const LocationRange({Key? key,}) : super(key: key);

  @override
  State<LocationRange> createState() => _LocationRangeState();
}

class _LocationRangeState extends State<LocationRange> {

  List plot_data = [];
  List expense_data = [];

  List animal_category_data = [];
  List animal_sub_category_data = [];



  TextEditingController total = TextEditingController();

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




  Future<String> selectSubCategory(String id) async {

    // /region/1/districts

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/region/1/districts"),
        headers: {
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    //   print(resBody['data']['name']);

    setState(() {
      animal_sub_category_data = resBody['data'];

      print(animal_sub_category_data);

    });



    return "Sucess";
  }




  Future<String> selectCategory() async {

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/regions"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    setState(() {
      animal_category_data = resBody['data'];
    });


    return "Sucess";
  }
  String? selectedPlot;


  String? selectedCategory;
  String? selectedSubCategory;

  @override
  void initState()  {
    super.initState();


    selectCategory();




  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Location "),
        backgroundColor: CustomColors.barColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 3,
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Card(
            color: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [




                  // Padding(
                  //   padding: const EdgeInsets.all(15.0),
                  //   child: DropdownButtonHideUnderline(
                  //     child: DropdownButton2(
                  //       hint: Text(
                  //         'Select Region',
                  //         style: TextStyle(
                  //           fontSize: 14,
                  //           color: Theme
                  //               .of(context)
                  //               .hintColor,
                  //         ),
                  //       ),
                  //
                  //
                  //       items: animal_category_data.map((item) {
                  //         return new DropdownMenuItem(
                  //             child: new Text(
                  //               item['name'],    //Names that the api dropdown contains
                  //               style: TextStyle(
                  //                 fontSize: 13.0,
                  //               ),
                  //             ),
                  //             value: item['id'].toString()       //Id that has to be passed that the dropdown has.....
                  //           //e.g   India (Name)    and   its   ID (55fgf5f6frf56f) somethimg like that....
                  //         );
                  //       }).toList(),
                  //       value: selectedCategory,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           selectedCategory = value as String;
                  //         });
                  //
                  //         selectSubCategory(value as String);
                  //       },
                  //       buttonHeight: 40,
                  //       buttonWidth: MediaQuery.of(context).size.width,
                  //       itemHeight: 40,
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: DropdownButtonFormField2(


                      decoration: InputDecoration(
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                     fillColor: Colors.green,
                        contentPadding: EdgeInsets.zero,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Select Region',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: animal_category_data.map((item) {
                        return DropdownMenuItem(
                            child: Text(
                              item['name'],    //Names that the api dropdown contains
                              style: const TextStyle(
                                fontSize: 13.0,
                              ),
                            ),
                            value: item['id'].toString()       //Id that has to be passed that the dropdown has.....
                          //e.g   India (Name)    and   its   ID (55fgf5f6frf56f) somethimg like that....
                        );
                      }).toList(),
                      value: selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value as String;
                        });

                        selectSubCategory(value as String);
                      },
                      buttonWidth: MediaQuery.of(context).size.width,
                      itemHeight: 40,
                    ),
                  ),
                  SizedBox(height: 20,),
                  // Padding(
                  //   padding: const EdgeInsets.all(15.0),
                  //   child: DropdownButtonHideUnderline(
                  //     child: DropdownButton2(
                  //       hint: Text(
                  //         'Select Animal Feeds',
                  //         style: TextStyle(
                  //           fontSize: 14,
                  //           color: Theme
                  //               .of(context)
                  //               .hintColor,
                  //         ),
                  //       ),
                  //       items: animal_sub_category_data.map((item) {
                  //         return new DropdownMenuItem(
                  //             child: new Text(
                  //               item['name'],    //Names that the api dropdown contains
                  //               style: TextStyle(
                  //                 fontSize: 13.0,
                  //               ),
                  //             ),
                  //             value: item['id'].toString()       //Id that has to be passed that the dropdown has.....
                  //           //e.g   India (Name)    and   its   ID (55fgf5f6frf56f) somethimg like that....
                  //         );
                  //       }).toList(),
                  //       value: selectedSubCategory,
                  //       onChanged: (value) {
                  //
                  //         print("jj");
                  //         setState(() {
                  //           selectedSubCategory = value as String;
                  //         });
                  //
                  //       },
                  //       buttonHeight: 40,
                  //       buttonWidth: MediaQuery.of(context).size.width,
                  //       itemHeight: 40,
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: DropdownButtonFormField2(


                      decoration: InputDecoration(
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                        fillColor: Colors.green,
                        contentPadding: EdgeInsets.zero,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Select District',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: animal_sub_category_data .map((item) {
                        return DropdownMenuItem(
                            child: Text(
                              item['name'],    //Names that the api dropdown contains
                              style: const TextStyle(
                                fontSize: 13.0,
                              ),
                            ),
                            value: item['id'].toString()       //Id that has to be passed that the dropdown has.....
                          //e.g   India (Name)    and   its   ID (55fgf5f6frf56f) somethimg like that....
                        );
                      }).toList(),
                      value: selectedSubCategory,
                      onChanged: (value) {
                        setState(() {
                          selectedSubCategory = value as String;
                        });

                         // Get.to(MarketScreenSearch(min: '', max: '', id: selectedSubCategory!, isLocation: true,));


                      },
                      buttonWidth: MediaQuery.of(context).size.width,
                      itemHeight: 40,
                    ),
                  ),

                  SizedBox(height: 20,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}