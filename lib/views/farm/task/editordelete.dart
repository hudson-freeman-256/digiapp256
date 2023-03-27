import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/static/static_values.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textfields/textfields.dart';

class EditOrDeleteTask extends StatefulWidget {

  final String id;
  final String name;
  final String date;
  final String plot;
  const EditOrDeleteTask({Key? key, required this.id, required this.name, required this.date, required this.plot}) : super(key: key);




  @override
  State<EditOrDeleteTask> createState() => _EditOrDeleteTaskState();
}

class _EditOrDeleteTaskState extends State<EditOrDeleteTask> {

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
    return Scaffold(
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

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(

                            children: [
                              Text("Name: ",style: GoogleFonts.poppins(fontSize: 20,color: CustomColors.gary),),
                              Text(widget.name,style: GoogleFonts.poppins(fontSize: 20),),
                            ],
                          ),
                          Row(

                            children: [
                              Text("Plot: ",style: GoogleFonts.poppins(fontSize: 20,color: CustomColors.gary),),
                              Text(widget.plot,style: GoogleFonts.poppins(),),
                            ],
                          ),
                          Row(
                            children: [
                              Text("End Date: ",style: GoogleFonts.poppins(fontSize: 20,color: Colors.red),),
                              Text(widget.date,style: GoogleFonts.poppins(),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red)
                      ),
                      onPressed: (){
                        StaticValues.errorSnackBar(context, "Down For maintenance please try again later");
                      },
                      child: const Text("End Task"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
