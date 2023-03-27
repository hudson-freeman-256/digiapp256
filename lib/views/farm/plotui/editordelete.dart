import 'dart:convert';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:digifarmer/views/farm/expenseui/viewexpense.dart';
import 'package:digifarmer/views/farm/harvest/viewharvest.dart';
import 'package:digifarmer/views/farm/plotui/updateplot.dart';
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

class EditOrDeletePlot extends StatefulWidget {
  final String id;
  final String name;
  final String acres;
  const EditOrDeletePlot({Key? key, required this.id,required this.name, required this.acres}) : super(key: key);

  @override
  State<EditOrDeletePlot> createState() => _EditOrDeletePlotState();
}

class _EditOrDeletePlotState extends State<EditOrDeletePlot> {


  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];



  String? selectedSize;

  String? selectedValue;

  Map<String,dynamic>? plot_data  ;

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: (){

          Get.to(UpdatePlot(id: widget.id,name: widget.name,));
        },
        child: Icon(Icons.edit),

      ),
      body: plot_data == null ?  Center(child: CircularProgressIndicator(color: CustomColors.barColor,)) :  SingleChildScrollView(

        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 15,),
              Padding(padding: EdgeInsets.only(left: 20,right: 20),
                child: GestureDetector(
                  onTap: (){
                    Get.to(ViewAnimal(id: widget.id.toString(), name: ""));

                  },
                  child: Card(

                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                          Column(
                            children: [
                              Container(
                                child: Image.asset("assets/farm/5.png",height: 50,),

                              ),
                              Text("View Animal",style: GoogleFonts.poppins(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 15),)
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                ),),
              Padding(padding: EdgeInsets.only(left: 20,right: 20),
                child: GestureDetector(
                  onTap: (){
                    Get.to(ViewExpense(id: widget.id.toString()));

                  },
                  child: Card(

                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                          Column(
                            children: [
                              Container(
                                child: Image.asset("assets/farm/6.png",height: 50,),

                              ),
                              Text("View Expense",style:  StaticValues.customFonts(CustomColors.barColor, 15, FontWeight.w700),)
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                ),),
              Padding(padding: EdgeInsets.only(left: 20,right: 20),
                child: GestureDetector(
                  onTap: (){
                    Get.to(ViewTask(id: widget.id,));

                  },
                  child: Card(

                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                          Column(
                            children: [
                              Container(
                                child: Image.asset("assets/farm/2.png",height: 50,),

                              ),
                              Text("View Task",style: StaticValues.customFonts(CustomColors.barColor, 15, FontWeight.w700),)
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                ),),
              Padding(padding: EdgeInsets.only(left: 20,right: 20),
                child: GestureDetector(
                  onTap: (){
                    Get.to(ViewHarvest(id: widget.id,));

                  },
                  child: Card(

                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                          Column(
                            children: [
                              Container(
                                child: Image.asset("assets/farm/2.png",height: 50,),

                              ),
                              Text("View Harvest",style: StaticValues.customFonts(CustomColors.barColor, 15, FontWeight.w700),)
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                ),),


              SizedBox(height: 20,),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [

                          const SizedBox(height: 2,),


                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  children: [
                                    Text("Your Current Acres: ",style: StaticValues.customFonts(CustomColors.barColor, 15, FontWeight.w700),),
                                    Text(widget.acres,style: StaticValues.customFonts(CustomColors.gary, 15, FontWeight.w700))
                                  ],
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                   controller: size,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Field Area',
                                    hintText: 'Field Area',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),

                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                              ),
                              onPressed: (){
                                updateFarm();
                              },
                              child: Text("Update",style: StaticValues.customFonts(CustomColors.white, 15, FontWeight.w700),)),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.red)
                              ),
                              onPressed: () async{

                                if (await confirm(context)) {



                                  return Get.back();
                                }
                                return print('pressedCancel');



                              },
                              child: Text("Delete",style: StaticValues.customFonts(CustomColors.white, 15, FontWeight.w700),))
                        ],
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
