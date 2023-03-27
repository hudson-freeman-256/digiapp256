import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:digifarmer/services/farm_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:textfields/textfields.dart';

import '../../../services/auth_service.dart';
import '../../../static/color.dart';
import '../../../static/static_values.dart';
import 'package:http/http.dart' as http;
class AddTask extends StatefulWidget {
  final String id;
  const AddTask({Key? key, required this.id}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {



  String _startDate = "Not set";
  String _endDate = "Not set";
  String _startTime = "Not set";
  String _endTime = "Not set";
  List plot_data = [];
  TextEditingController task_name = TextEditingController();



  String? selectedPlot;
  String? date;


  void pickDate(BuildContext context,String value) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2023, 1, 1),
        maxTime: DateTime(2050, 1, 1),
        theme: DatePickerTheme(
            headerColor: Colors.white70,
            backgroundColor: Colors.white70,
            itemStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 18),
            doneStyle:
            TextStyle(color: CustomColors.barColor, fontSize: 16)),
        onChanged: (date) {
          print('change $date in time zone ' +
              date.timeZoneOffset.inHours.toString());
        }, onConfirm: (date) {

          // String? startDate,endDate,startTime,endTime;

          if(_startDate!.contains("startDate")){
            setState(() {
              _startDate = date.toString().trim();
            });
          }




        }, currentTime: DateTime.now(), locale: LocaleType.en);

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




  addTask() async {


    if(task_name.text.isEmpty){
     StaticValues.errorSnackBar(context, "Please Add a Task Name");
    }else if(selectedPlot == null){
      StaticValues.errorSnackBar(context, "Please Select A Plot");
    }else if(_startDate.isEmpty){
      StaticValues.errorSnackBar(context, "Please Select A Date");
    }else{




      showAlertDialog(context);


      http.Response response = await FarmService.addTask(task_name.text, _startDate, int.parse(selectedPlot.toString()));


      Navigator.pop(context);
      Map responseMap = jsonDecode(response.body);


        if (responseMap['success'] == false) {
          StaticValues.successSnackBar(context, responseMap['message']);
        }


        if (responseMap['success'] == true) {

          StaticValues.successSnackBar(context, responseMap['message']);

          return Get.back();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
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
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: task_name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task Name',
                  hintText: 'Task Name',
                ),
              ),
            ),
              SizedBox(height: 20,),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xfff5f5f5)),
                    ),

                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          theme: DatePickerTheme(
                            containerHeight: 210.0,
                          ),
                          showTitleActions: true,
                          minTime: DateTime(2023, 1, 1),
                          maxTime: DateTime(2050, 12, 31), onConfirm: (date) {

                            _startDate = '${date.year}-${date.month}-${date.day}';
                            setState(() {});
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      size: 18.0,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      " $_startDate",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text(
                            "  Change",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),

                  ),
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


                  ElevatedButton(onPressed: (){

                      addTask();
                  },
                      child: Text("Save"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(CustomColors.barColor),
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//