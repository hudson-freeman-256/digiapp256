import 'dart:convert';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:digifarmer/static/color.dart';
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

class EditOrDeleteExpense extends StatefulWidget {
  final String id;
  final String name;
  final int amount;
  const EditOrDeleteExpense({Key? key, required this.id,required this.name, required this.amount}) : super(key: key);

  @override
  State<EditOrDeleteExpense> createState() => _EditOrDeleteExpenseState();
}

class _EditOrDeleteExpenseState extends State<EditOrDeleteExpense> {

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

  // TextEditingController amount = TextEditingController();




  Map<String,dynamic>? expense_data  ;


  TextEditingController amount = TextEditingController();

  Future<String> getExpenseInfo() async {

    print(widget.id);

    final String bearerToken = AuthService.token;

    // /farm/plot/expenses/{id}
    var res = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm/plot/expenses/${widget.id}"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);



    setState(() {
      expense_data  = resBody;



    });

    print(expense_data!['data']['name']);

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


    http.Response response = await FarmService.deleteFarm("farm/plot/expenses/${widget.id.toString()}");

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
      "amount":amount.text.isEmpty ? expense_data!['amount'] : amount.text ,
    };

    print(widget.id);




    // name.text.isEmpty ? farm_data!['name'] : name.text,field.text.isEmpty ? farm_data!['field_area']

    http.Response response = await FarmService.updatedFarm(data, "farm/plot/expenses/${widget.id}");

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: CustomColors.barColor,
      ),
      body: SizedBox(
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
                            Text("Your Current Amount: ",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
                            Text(StaticValues.formatter.format(widget.amount),style: GoogleFonts.poppins(color: CustomColors.barColor))
                          ],
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                           controller:amount,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Amount',
                            hintText: 'Amount',
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
                      child: const Text("Update")),
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
                      child: const Text("Delete"))
                ],
              ),
            ),
          ),
        ),
      ),
    );;
  }
}
