import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:textfields/textfields.dart';

import '../../../services/auth_service.dart';
import '../../../services/farm_service.dart';
import '../../../static/color.dart';
import '../../../static/static_values.dart';
import 'package:http/http.dart' as http;
class AddHarvest extends StatefulWidget {
  final String id;
  const AddHarvest({Key? key, required this.id}) : super(key: key);

  @override
  State<AddHarvest> createState() => _AddHarvestState();
}

class _AddHarvestState extends State<AddHarvest> {




  List plot_data = [];

  TextEditingController quantity = TextEditingController();


  String? selectedPlot;

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

  addHarvest() async {


      if(quantity.text.isEmpty){
         StaticValues.errorSnackBar(context, "Please enter Quantity");
      }else if(selectedPlot == null){
        StaticValues.errorSnackBar(context, "Please Select Plot");
      }else{


        showAlertDialog(context);


        http.Response response = await FarmService.addHarvest(int.parse(quantity.text), int.parse(selectedPlot!));


        Navigator.pop(context);
        Map responseMap = jsonDecode(response.body);

        if (response.statusCode == 200) {
          if (responseMap['success'] == false) {
            StaticValues.errorSnackBar(context, responseMap['message']);
          }


          if (responseMap['success'] == true) {

            StaticValues.successSnackBar(context, responseMap['message']);

Get.back();
          }

        } else {
          StaticValues.errorSnackBar(context, responseMap['message']);
        }


      }




  }

 


  Future<String> selectPlot() async {








      final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"farm/${widget.id}/plots"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);


    setState(() {

      List list = resBody["data"]["plots"];
      plot_data = list;

      print(list);

    });


    return "Sucess";
  }






  @override
  void initState()  {
    super.initState();

    selectPlot();





  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Add Harvest"),
        backgroundColor: CustomColors.barColor,
      ),
      body:  Container(
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



                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: DropdownButtonHideUnderline(

                      child: DropdownButton2(

                        hint: Text(
                          'Select Plot',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: plot_data.map((item) {
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
                        value: selectedPlot,
                        onChanged: (value) {
                          setState(() {
                            selectedPlot = value as String;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 140,
                        itemHeight: 40,
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      controller: quantity,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quantity',
                        hintText: 'Quantity',
                      ),
                    ),
                  ),

                  const SizedBox(height: 10,),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                      ),
                      onPressed: (){
                    addHarvest();
                  },
                      child: const Text("Save"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
