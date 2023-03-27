import 'dart:convert';

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

class AddAnimal extends StatefulWidget {
  final String id;
  const AddAnimal({Key? key, required this.id}) : super(key: key);

  @override
  State<AddAnimal> createState() => _AddAnimalState();
}

class _AddAnimalState extends State<AddAnimal> {

  List plot_data = [];
  List expense_data = [];



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

  addAnimal() async {

    // print(amount.text);
    // print(selectedPlot);
    // print(selectedCategory);


    if(total.text.isEmpty){
      StaticValues.errorSnackBar(context, "Total Can't Empty");
    }else if(selectedPlot == null){
      StaticValues.errorSnackBar(context, "Plot was not selected");
    }else if(selectedCategory == null){
      StaticValues.errorSnackBar(context, "Expense Category was not selected");
    }else{

      showAlertDialog(context);


      http.Response response = await FarmService.addAnimal(int.parse(total.text), int.parse(selectedPlot!), int.parse(selectedCategory!));


      Navigator.pop(context);
      Map responseMap = jsonDecode(response.body);

      // if (response.statusCode == 200) {
        // if (responseMap['success'] == false) {
        //   StaticValues.errorSnackBar(context, responseMap['message']);
        // }


        if (responseMap['success'] == true) {

          StaticValues.successSnackBar(context, responseMap['message']);

          return Get.back();
        }else{
          StaticValues.errorSnackBar(context, responseMap['message']);
        }

      // } else {
      //   StaticValues.errorSnackBar(context, responseMap['message']);
      // }

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

  Future<String> selectCategory() async {

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"animal_categories"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);


    setState(() {
      expense_data = resBody['data'];

    });


    return "Sucess";
  }

  String? selectedPlot;

  String? selectedCategory;

  @override
  void initState()  {
    super.initState();

    selectPlot();
    selectCategory();




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Animal"),
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


                  SizedBox(height: 20,),

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
                    padding: const EdgeInsets.all(15),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text(
                          'Select Animal Category',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: expense_data.map((item) {
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
                        value: selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value as String;
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
                      controller: total,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Total',
                        hintText: 'Total',
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                      ),
                      onPressed: (){

                    addAnimal();
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
