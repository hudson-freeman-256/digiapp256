import 'dart:convert';

import 'package:digifarmer/services/auth_service.dart';
import 'package:digifarmer/services/farm_service.dart';
import 'package:digifarmer/static/static_values.dart';
import 'package:digifarmer/views/farm/farmui/viewfarm.dart';
import 'package:digifarmer/views/profile/address/addAddress.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:textfields/textfields.dart';
import 'package:http/http.dart' as http;

import '../../../static/color.dart';
class AddFarm extends StatefulWidget {
  const AddFarm({Key? key}) : super(key: key);

  @override
  State<AddFarm> createState() => _AddFarmState();


}



class _AddFarmState extends State<AddFarm> {

  List address_data = [];


  String? addressid;

  TextEditingController name = TextEditingController();
  TextEditingController field = TextEditingController();


  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(color: CustomColors.barColor,),
          Container(margin: const EdgeInsets.only(left: 5),child:const Text("Loading" )),
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
  Future<String> selectAddress() async {

     final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"user/my-addresses"),
        headers: {
    'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    setState(() {
      address_data = resBody['data'];
    });


    return "Sucess";
  }

 addFarm() async{

    var farm;

   if(field.text.isEmpty){
      StaticValues.errorSnackBar(context, "Please Enter your Field Area");
    }else if(selectedAddress == null){
      StaticValues.errorSnackBar(context, "Please Enter your Address");
    }
   else if(name.text.isEmpty){
     StaticValues.errorSnackBar(context, "Please Enter your Name");
   }
   else {
      // farm = await FarmService.addFarm(name.text, field.text, selectedSize!, selectedAddress!);


      showAlertDialog(context);


      http.Response response = await FarmService.addFarm(name.text, field.text, selectedAddress!);

      Navigator.pop(context);
      Map responseMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseMap['success'] == false) {
          StaticValues.errorSnackBar(context, responseMap['message']);
        }


        if (responseMap['success'] == true) {

          StaticValues.successSnackBar(context, responseMap['message']);

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ViewFarm() ,)).then(
                  (value) =>
                  setState(() {
                    // Call setState to refresh the page.
                  })
          );
        }

      } else {
        StaticValues.errorSnackBar(context, responseMap['message']);
        return  Get.back();
      }



    }



 }




  final List<String> size = [
    'Acres',
    'Hectares',
  ];

  String? selectedSize;

  String? selectedAddress;

  @override
  void initState()  {
    super.initState();



   selectAddress();


  }


  @override
  Widget build(BuildContext context) {




    return    Scaffold(
      appBar: AppBar(
        title: Text("Add Farm",style: StaticValues.customFonts(Colors.white, 20, FontWeight.w700),),
        backgroundColor: CustomColors.barColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 1.6,
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



                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      style: StaticValues.customFonts(Colors.grey, 15, FontWeight.w400),
                      controller: name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'Name',
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  // BorderTextFieldWithIcon(
                  //   hintText: " Field Area",
                  //   controller: field,
                  //   suffixIcon: Icon(
                  //     Icons.area_chart,
                  //     // color: Colors.white,
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: field,
                      style: StaticValues.customFonts(Colors.grey, 15, FontWeight.w400),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Field Area (Acre)',
                        hintText: 'Field Area (Acre)',
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text(
                          'Select Address',
                          style: StaticValues.customFonts(Colors.grey, 15, FontWeight.w400),
                        ),
                        items: address_data.map((item) {
                          return new DropdownMenuItem(
                              child: new Text(
                                item['district_name'],    //Names that the api dropdown contains
                                style: StaticValues.customFonts(Colors.grey, 15, FontWeight.w400),
                              ),
                              value: item['id'].toString()       //Id that has to be passed that the dropdown has.....
                            //e.g   India (Name)    and   its   ID (55fgf5f6frf56f) somethimg like that....
                          );
                        }).toList(),
                        value: selectedAddress,
                        onChanged: (value) {
                          setState(() {
                            selectedAddress = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                        onTap: (){
                          Get.to(AddAddress());
                        },
                        child: Row(
                          children: [
                            Text("Or ",style: StaticValues.customFonts(CustomColors.black, 15, FontWeight.w400),),
                            Text("Create new Address",style: StaticValues.customFonts(CustomColors.barColor, 15, FontWeight.w400),),
                          ],
                        )),
                  ),

                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                      ),
                      onPressed: (){
                    addFarm();
                  },
                      child: Text("Save"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


