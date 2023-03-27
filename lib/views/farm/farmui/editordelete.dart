import 'dart:convert';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:digifarmer/views/farm/animalui/addanimal.dart';
import 'package:digifarmer/views/farm/animalui/viewanimal.dart';
import 'package:digifarmer/views/farm/expenseui/addexpense.dart';
import 'package:digifarmer/views/farm/farmui/viewfarm.dart';
import 'package:digifarmer/views/farm/harvest/addharvest.dart';
import 'package:digifarmer/views/farm/plotui/addplot.dart';
import 'package:digifarmer/views/farm/plotui/viewplot.dart';
import 'package:digifarmer/views/farm/task/addtask.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:textfields/textfields.dart';

import '../../../services/auth_service.dart';
import '../../../services/farm_service.dart';
import '../../../static/color.dart';
import '../../../static/static_values.dart';
import 'package:http/http.dart' as http;
class EditOrDelete extends StatefulWidget {

 final String? id;
 final String? name;
 final String? location;
  const EditOrDelete({Key? key,required this.id, required this.name, this.location}) : super(key: key);

  @override
  State<EditOrDelete> createState() => _EditOrDeleteState();
}

class _EditOrDeleteState extends State<EditOrDelete> {

  TextEditingController name = TextEditingController();
  TextEditingController field = TextEditingController();

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

  Map<String, double> dataMap = {
    "Plot": 25,
    "Harvest":56,
    "Expense": 78,
    "Animal": 54,
    "Task": 70,
  };




  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];
  String? selectedSize;

  ChartType? _chartType = ChartType.ring;
  bool _showCenterText = true;
  double? _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;
  bool _showLegends = true;
  bool _showLegendLabel = false;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  LegendPosition? _legendPosition = LegendPosition.right;

  Map<String,dynamic>? farm_data  ;



  Future<String> getFarmInfo() async {

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"farms/${widget.id}"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);


    setState(() {
      farm_data  = resBody['data'];

    });


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


    http.Response response = await FarmService.deleteFarm("farms/${widget.id.toString()}");

    Navigator.pop(context);
    Map responseMap = jsonDecode(response.body);

    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      if (responseMap['success'] == false) {
        StaticValues.errorSnackBar(context, responseMap['errors']);
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
      StaticValues.errorSnackBar(context, responseMap['errors']);
    }
    
  }

  updateFarm() async {


    showAlertDialog(context);

    Map data = {
         "name":name.text.isEmpty ? farm_data!['name'] : name.text ,
          "field_area":field.text.isEmpty ? farm_data!['field_area'] : field.text
    };

//     Map data = {
// //      "name":name,
// //      "field_area": field,
// //    };


    // name.text.isEmpty ? farm_data!['name'] : name.text,field.text.isEmpty ? farm_data!['field_area']

    http.Response response = await FarmService.updatedFarm(data, "farms/${widget.id}");

    Navigator.pop(context);
    Map responseMap = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (responseMap['success'] == false) {
        StaticValues.errorSnackBar(context, responseMap['message']);
      }


      if (responseMap['success'] == true) {

        StaticValues.successSnackBar(context, responseMap['message']);

        // Navigator.pushNamed(context, '/page2').then((_) {
        //   // This block runs when you have returned back to the 1st Page from 2nd.
        //   setState(() {
        //     // Call setState to refresh the page.
        //   });
        // });

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

  // updateFarm();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getFarmInfo();
  }
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(widget.name == null ? "" : widget.name!,style: StaticValues.customFonts(Colors.white,15,FontWeight.w700),),Text(widget.location == null ? "" : widget.location!,style: StaticValues.customFonts(Colors.white,13,FontWeight.w700))],),
        backgroundColor: CustomColors.barColor,
        
      ),
      body:   farm_data == null ?  const Center(child: CircularProgressIndicator(color: CustomColors.barColor,)): SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(

                children: [
                   const SizedBox(height: 15,),



                  GridView.builder(

                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2.7/2,
                      crossAxisCount:1,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.to(ViewPlot(id: widget.id.toString(), name: ""));

                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width/2.2,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [


                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Image.asset("assets/farm/1.png",height: 50,),

                                                ),
                                                Center(child: Text("View Plots",style: StaticValues.customFonts(CustomColors.barColor, 17, FontWeight.w700),))
                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                GestureDetector(
                                  onTap: (){
                                    Get.to( AddExpense(id: widget.id.toString(),));

                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width/2.2,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [


                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Image.asset("assets/farm/6.png",height: 50,),

                                                ),
                                                Center(child: Text("Add Expense",style: StaticValues.customFonts(CustomColors.barColor, 17, FontWeight.w700),))
                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                GestureDetector(
                                  onTap: (){
                                    Get.to(AddTask(id: widget.id.toString(),));

                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width/2.2,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 1),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [


                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Image.asset("assets/farm/2.png",height: 50,),

                                                ),
                                                Center(child: Text("Add Task",style: StaticValues.customFonts(CustomColors.barColor, 17, FontWeight.w700),))
                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),


                              ],
                            ),
                            Column(
                              children: [



                      GestureDetector(
                        onTap: (){
                        Get.to(AddHarvest(id: widget.id.toString()));

                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width/2.2,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [


                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/farm/8.png",height: 50,),
                                    Center(child: Text("Add Harvest",style: StaticValues.customFonts(CustomColors.barColor, 17, FontWeight.w700),))
                                  ],
                                ),


                              ],
                            ),
                          ),
                        ),
                        ),
                      ),
SizedBox(height: 5,),
                        GestureDetector(
                          onTap: (){
                            Get.to( AddAnimal(id: widget.id.toString(),));

                          },
                          child: Container(

                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [


                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/farm/5.png",height: 50,),
                                        Center(child: Text("Add Animal",style: StaticValues.customFonts(CustomColors.barColor, 17, FontWeight.w700),))
                                      ],
                                    ),


                                  ],
                                ),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width/2.2,
                          ),
                        ),
                      SizedBox(height: 5,),
                      GestureDetector(
                                  onTap: (){
                                    Get.to(const AddPlot());

                                  },
                                  child: SizedBox(

                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [


                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset("assets/farm/1.png",height: 50,),
                                                Center(child: Text("Add Plot",style: StaticValues.customFonts(CustomColors.barColor, 17, FontWeight.w700),))
                                              ],
                                            ),


                                          ],
                                        ),
                                      ),
                                    ),
                                    width: MediaQuery.of(context).size.width/2.2,
                                  ),
                                ),

                                // Row(
                                //
                                //   children: [
                                //
                                //   ],
                                // )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),







                ],
              ),
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
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  children: [
                                    Text("Your Current Field Area: ",style: StaticValues.customFonts(CustomColors.black, 17, FontWeight.w700),),
                                    Text(farm_data!['field_area'],style: StaticValues.customFonts(CustomColors.barColor, 17, FontWeight.w700))
                                  ],
                                ),
const SizedBox(height: 10,),
                                TextFormField(
                                                      controller: field,
                                  style: StaticValues.customFonts(CustomColors.barColor, 17, FontWeight.w700),
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
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
                              child:  Text("Update",style: StaticValues.customFonts(CustomColors.white, 17, FontWeight.w700),)),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.red)
                              ),
                              onPressed: () async{

                                if (await confirm(context)) {

                                  deleteFarm();

                                  return Get.back();
                                }
                                return print('pressedCancel');



                              },
                              child: Text("Delete",style: StaticValues.customFonts(CustomColors.white, 17, FontWeight.w700),),)
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
