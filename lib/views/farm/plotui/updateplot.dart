import 'dart:convert';

import 'package:digifarmer/views/farm/expenseui/viewexpense.dart';
import 'package:digifarmer/views/farm/plotui/viewplot.dart';
import 'package:digifarmer/views/farm/task/viewtask.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textfields/textfields.dart';

import '../../../services/auth_service.dart';
import '../../../services/farm_service.dart';
import '../../../static/color.dart';
import '../../../static/static_values.dart';
import 'package:http/http.dart' as http;

import '../animalui/viewanimal.dart';

class UpdatePlot extends StatefulWidget {
  final String id;
  final String name;
  const UpdatePlot({Key? key, required this.id,required this.name}) : super(key: key);

  @override
  State<UpdatePlot> createState() => _UpdatePlotState();
}

class _UpdatePlotState extends State<UpdatePlot> {


  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];



  String? selectedSize;

  String? selectedValue;

  Map<String,dynamic>? plot_data  ;

  TextEditingController plotName = TextEditingController();
  TextEditingController size = TextEditingController();

  Future<String> getPlotInfo() async {

    print(widget.id);

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm/plots/${widget.id}"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);



    setState(() {
      plot_data  = resBody;



    });

    print(plot_data!['data']['name']);

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


    http.Response response = await FarmService.deleteFarm("farm/plots/${widget.id.toString()}");

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
      "name":plotName.text.isEmpty ? plot_data!['name'] : plotName.text ,
      "size":size.text.isEmpty ? plot_data!['field_area'] : size.text
    };

//     Map data = {
// //      "name":name,
// //      "field_area": field,
// //    };


    // name.text.isEmpty ? farm_data!['name'] : name.text,field.text.isEmpty ? farm_data!['field_area']

    http.Response response = await FarmService.updatedFarm(data, "farm/plots/${widget.id}");

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

    getPlotInfo();
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: CustomColors.barColor,
      ),
      body: plot_data == null ?  Center(child: CircularProgressIndicator(color: CustomColors.barColor,)) :  SingleChildScrollView(

        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 15,),

              Container(
                height: MediaQuery.of(context).size.height / 1.7,
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
                            child: Row(
                              children: [
                                Text("Your current Plot size: ",style: GoogleFonts.poppins(fontSize: 15,)),
                                Text(plot_data!['data']['size'].toString(),style: GoogleFonts.poppins(fontSize: 15,color: CustomColors.barColor),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: TextField(
                              controller: size,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Size',
                                hintText: 'Size',
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),


                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                              ),
                              onPressed: (){
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
            ],
          ),
        ),
      ),
    );
  }
}
