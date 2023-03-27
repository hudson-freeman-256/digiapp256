import 'dart:convert';


import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/profile/address/address.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:textfields/textfields.dart';
import 'package:http/http.dart' as http;

import '../../../services/address_service.dart';
import '../../../static/static_values.dart';


class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  var countries;





  TextEditingController address = TextEditingController();
  TextEditingController district_name = TextEditingController();




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

    setState(() {
      country_data = resBody['data'];
    });


    return "Sucess";
  }
  Future<String> districts(String id) async {
    var res = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/region/$id/districts"),
        headers: {"Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    print( resBody);
    setState(() {
      district_data = resBody['data'];
    });


    return "Sucess";
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.regions();

  }





  String? selectedCountryId;
  String? selectedDistrict;
  @override
  Widget build(BuildContext context) {


     return Scaffold(
    appBar: AppBar(
    title: Text("Add Address"),
    backgroundColor: CustomColors.barColor,
    ),
    body: Container(
    height: MediaQuery.of(context).size.height / 1.8,
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
        padding: const EdgeInsets.all(15.0),
        child: MultiLineTextField(
          controller: address,
          maxLines:5,
          bordercolor: Colors.grey,
          label: "Address",
        ),
      ),

      Padding(
        padding: const EdgeInsets.all(15.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'Select Regions',
              style: TextStyle(
                fontSize: 14,
                color: Theme
                    .of(context)
                    .hintColor,
              ),
            ),
            items: country_data.map((item) {
                        return new DropdownMenuItem(
                            child: new Text(
                              item['name'],    //Names that the api dropdown contains
                              style: TextStyle(
                                fontSize: 13.0,
                              ),
                            ),
                            value: item['id'].toString()       //Id that has to be passed that the dropdown has.....
                          //e.g   India (Name)    and   its   ID (55fgf5f6frf56f) somethimg like that....
                        );
                      }).toList(),
            value: selectedCountryId,
            onChanged: (value) {

              districts(selectedCountryId.toString());

              setState(() {
                selectedCountryId = value as String;

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
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text(
              'Select District',
              style: TextStyle(
                fontSize: 14,
                color: Theme
                    .of(context)
                    .hintColor,
              ),
            ),
            items: district_data.map((item) {
              return new DropdownMenuItem(
                  child: new Text(
                    item['name'],    //Names that the api dropdown contains
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                  value: item['id'].toString()       //Id that has to be passed that the dropdown has.....
                //e.g   India (Name)    and   its   ID (55fgf5f6frf56f) somethimg like that....
              );
            }).toList(),
            value: selectedDistrict,
            onChanged: (value) {
              setState(() {
                selectedDistrict = value as String;


              });
            },
            buttonHeight: 40,
            buttonWidth: 140,
            itemHeight: 40,
          ),
        ),
      )



,

    SizedBox(height: 20,),

    ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
        ),
        onPressed: (){

      sendAddress();
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


  sendAddress() async {
    try {
      // Check for missing district
      if (selectedDistrict == null) {
        StaticValues.successSnackBar(context,"District is missing");
        return;
      }

      // Check for missing country
      if (selectedCountryId == null) {
        StaticValues.successSnackBar(context,"Region is missing");
        return;
      }

      // Check for missing address
      if (address.text.isEmpty) {
        StaticValues.successSnackBar(context,"Address is missing");
        return;
      }

      // Show loading dialog
      showAlertDialog(context);

      // Send address to server
      http.Response response = await AddressService.createAddress(
        address.text,
        selectedDistrict.toString(),
      );

      // Hide loading dialog
      Navigator.pop(context);

      Map responseMap = jsonDecode(response.body);

      String errorMessage = responseMap['message'];
      if (responseMap['errors'] != null) {
        responseMap['errors'].forEach((key, value) {
          errorMessage += "\n$key: $value";


        });
      }

      // Check for success status
      if (response.statusCode == 200) {


        // Check for success message
        if (responseMap['success'] == true) {

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Address(),)).then(
                  (value) =>
                  setState(() {
                    // Call setState to refresh the page.
                  })
          );
          StaticValues.successSnackBar(context, responseMap['message']);
        } else {
          // Handle error message

          StaticValues.errorSnackBar(context, errorMessage);
        }
      } else {
        // Handle server error

        StaticValues.errorSnackBar(context,errorMessage);
        return;
      }
    } catch (e) {
      // Handle any other errors
      StaticValues.errorSnackBar(context,"Error ddd: $e");
      return;
    }
  }


}






