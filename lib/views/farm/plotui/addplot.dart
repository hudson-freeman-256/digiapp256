import 'dart:convert';

import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/farm/farmui/viewfarm.dart';
import 'package:digifarmer/views/farm/plotui/viewplot.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:textfields/textfields.dart';

import '../../../services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../../../services/farm_service.dart';
import '../../../static/static_values.dart';

class AddPlot extends StatefulWidget {
  const AddPlot({Key? key}) : super(key: key);

  @override
  State<AddPlot> createState() => _AddPlotState();
}

class _AddPlotState extends State<AddPlot> {


 List  crop_data = [];
 List  farm_data = [];


 TextEditingController name = TextEditingController();
 TextEditingController sizeTotal = TextEditingController();

 // final List<String> size = [
 //   'Acres',
 //   'Hectares',
 // ];



 showAlertDialog(BuildContext context){
   AlertDialog alert=AlertDialog(
     content: Row(
       children: [
         const CircularProgressIndicator(color: CustomColors.barColor),
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

 String? selectedFarm;
 String? selectedCrop;

 String? selectedSize;

 addPlot() async{

   if(name.text.isEmpty){
     StaticValues.errorSnackBar(context, "Plot can't Empty");
   }else if(sizeTotal.text.isEmpty){
     StaticValues.errorSnackBar(context, "Size can't Empty");
   }else if(selectedFarm == null){
     StaticValues.errorSnackBar(context, "Farm can't Empty");
   }else if(selectedCrop == null){
     StaticValues.errorSnackBar(context, "Crop can't Empty");
   }else{

     showAlertDialog(context);


     http.Response response = await FarmService.addPlot(name.text, int.parse(selectedCrop.toString()), int.parse(selectedFarm.toString()), int.parse(sizeTotal.text.toString()),selectedSize.toString());
     

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
     }



   }



 }


  Future<String> selectCrop() async {

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"crops"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    setState(() {
      crop_data = resBody['data'];
      print(crop_data);
    });


    return "Sucess";
  }

  Future<String> selectFarm() async {

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"farmer/farms"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    setState(() {
      farm_data = resBody['data']['farms'];

      print(farm_data);
    });


    return "Sucess";
  }




 @override
 void initState()  {
   super.initState();

  // selectFarm();

selectFarm();
selectCrop();


 }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Add Plot"),
        backgroundColor: CustomColors.barColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 1.4,
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

                  // BorderTextFieldWithIcon(
                  //   hintText: " Plot Name",
                  //   controller: name,
                  //   suffixIcon: Icon(
                  //     Icons.factory_sharp,
                  //     // color: Colors.white,
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Plot Name',
                        hintText: 'Plot Name',
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: sizeTotal,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Size',
                        hintText: 'Size',
                      ),
                    ),
                  ),

              SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                    hint: Text(
                      'Select Crop',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme
                            .of(context)
                            .hintColor,
                      ),
                    ),
                    items: crop_data.map((item) {
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
                    value: selectedCrop,
                    onChanged: (value) {
                      setState(() {
                       selectedCrop = value as String;
                      });
                    },
                    buttonHeight: 40,
                    buttonWidth: 140,
                    itemHeight: 40,
                ),
              ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text(
                          'Select Farm',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: farm_data.map((item) {
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
                        value: selectedFarm,
                        onChanged: (value) {
                          setState(() {
                            selectedFarm = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text(
                          'Select Size Unit',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: StaticValues.size
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        value: selectedSize,
                        onChanged: (value) {
                          setState(() {
                            selectedSize = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                      ),
                      onPressed: (){
                    addPlot();
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
