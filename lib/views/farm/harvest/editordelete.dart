import 'dart:convert';

import 'package:digifarmer/static/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:textfields/textfields.dart';
import 'package:http/http.dart' as http;

import '../../../services/auth_service.dart';
import '../../../services/farm_service.dart';
import '../../../static/static_values.dart';

class EditOrDeleteHarvest extends StatefulWidget {
  final String id,name;
  const EditOrDeleteHarvest({Key? key,  required this.id, required this.name}) : super( key: key);

  @override
  State<EditOrDeleteHarvest> createState() => _EditOrDeleteHarvestState();
}

class _EditOrDeleteHarvestState extends State<EditOrDeleteHarvest> {

  Map<String,dynamic>? harvest_data  ;

  Future<String> getPlotInfo() async {

    print(widget.id);

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm/plot/crop_harvests/${widget.id}"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);



    setState(() {
      harvest_data  = resBody;



    });

    print(harvest_data!['data']['name']);

    return "Sucess";
  }


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

  TextEditingController quantity = TextEditingController();


  deleteFarm() async {


    showAlertDialog(context);


    http.Response response = await FarmService.deleteFarm("farm/plot/crop_harvests/${widget.id.toString()}");

    Navigator.pop(context);
    Map responseMap = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (responseMap['success'] == false) {
        StaticValues.errorSnackBar(context, responseMap['message']);
      }


      if (responseMap['success'] == true) {

        StaticValues.successSnackBar(context, responseMap['message']);

        return  Get.back();
      }

    } else {
      StaticValues.errorSnackBar(context, responseMap['message']);
    }

  }

  updateFarm() async {


    showAlertDialog(context);

    Map data = {
      "quantity":quantity.text.isEmpty ? harvest_data!['quantity'] : quantity.text
    };

//     Map data = {
// //      "name":name,
// //      "field_area": field,
// //    };


    // name.text.isEmpty ? farm_data!['name'] : name.text,field.text.isEmpty ? farm_data!['field_area']

    http.Response response = await FarmService.updatedFarm(data, "farm/plot/crop_harvests/${widget.id}");

    Navigator.pop(context);
    Map responseMap = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (responseMap['success'] == false) {
        StaticValues.errorSnackBar(context, responseMap['message']);
      }


      if (responseMap['success'] == true) {

        StaticValues.successSnackBar(context, responseMap['message']);

        return  Get.back();
      }

    } else {
      StaticValues.errorSnackBar(context, responseMap['message']);
    }

  }


  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  final List<String> size = [
    'Item1',
    'Item2',
  ];

  String? selectedSize;

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: CustomColors.barColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 2,
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
                  //
                  // BorderTextFieldWithIcon(
                  //   hintText: "Quantity",
                  //
                  //   suffixIcon: Icon(
                  //     Icons.factory_sharp,
                  //     // color: Colors.white,
                  //   ),
                  // ),
                  SizedBox(height: 20,),

                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      // controller: name,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quantity',
                        hintText: 'Quantity',
                      ),
                    ),
                  ),



                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: (){
                    updateFarm();
                  },
                      child: Text("Update")),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red)
                      ),
                      onPressed: (){
                        deleteFarm();

                      },
                      child: Text("Delete"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
