import 'dart:convert';

import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/farm/animalui/viewanimal.dart';
import 'package:digifarmer/views/farm/farmui/viewfarm.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textfields/textfields.dart';
import 'package:http/http.dart' as http;

import '../../../services/auth_service.dart';
import '../../../services/farm_service.dart';
import '../../../static/static_values.dart';


class EditOrDeleteAnimal extends StatefulWidget {
  final String id,name;
  const EditOrDeleteAnimal ({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  State<EditOrDeleteAnimal > createState() => _EditOrDeleteAnimalState();
}

class _EditOrDeleteAnimalState extends State<EditOrDeleteAnimal > {


  String? selectedSize;

  String? selectedValue;

  Map<String,dynamic>? animal_data  ;

  TextEditingController total = TextEditingController();



  Future<String> getAnimalInfo() async {

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"farm/plot/animals/${widget.id}"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);


    setState(() {
      animal_data  = resBody['data'];

    });

    print(animal_data!['name']);

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


  deleteFarm() async {


    showAlertDialog(context);



    http.Response response = await FarmService.deleteFarm("farm/plot/animals/${widget.id.toString()}");

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
                }));

      }

    } else {
      StaticValues.errorSnackBar(context, responseMap['message']);
    }

  }

  updateFarm() async {


    if(total.text.isEmpty){
     return StaticValues.errorSnackBar(context, "Total is Empty");
    }

    showAlertDialog(context);

    Map data = {
      "total" : total.text.isEmpty ? animal_data!['total'].toString() : total.text.toString() ,
    };

//     Map data = {
// //      "name":name,
// //      "field_area": field,
// //    };


    // name.text.isEmpty ? farm_data!['name'] : name.text,field.text.isEmpty ? farm_data!['field_area']

    http.Response response = await FarmService.updatedFarm(data, "farm/plot/animals/${widget.id.toString()}");

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAnimalInfo();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: CustomColors.barColor,
      ),
      body: animal_data == null ? Center(child: CircularProgressIndicator(color: CustomColors.barColor,),) : Container(
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


                  SizedBox(height: 20,),

                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Total Number(s) of "+animal_data!['animal_category']+" is "+animal_data!['total'].toString(),style: GoogleFonts.poppins(fontSize: 15),),
                 ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                       controller: total,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Total',
                        hintText: 'Toatal',
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),
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
                      child: Text("Delete")),
                ],
              ),
            ),
          ),
        ),
      ),
    );;
  }
}
