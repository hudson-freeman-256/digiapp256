import 'package:digifarmer/views/profile/addTask.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textfields/textfields.dart';


class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();


}

class _TaskState extends State<Task> {







  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
          child: Icon(Icons.add),
          onPressed: (){

          Get.to(AddTask());
          }

      ),
      appBar: AppBar(
        title: const Text("Task"),
        backgroundColor: Colors.lightGreen,

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 20,),
              Card(
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Plot",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 17),),
                      Text("|"),
                      Text("Task",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 17),),
                      Text("|"),
                      Text("Date",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 17),),
                      Text("|"),
                      Text("Action",style: GoogleFonts.actor(color: Colors.blue,fontWeight: FontWeight.w900,fontSize: 17),),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Jinja Farm",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 13),),

                      Text("Weeding",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 13),),

                      Text("120 days",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 13),),

                      Row(
                        children: [
                          Text("Edit",style: TextStyle(color: Colors.green),),
                          SizedBox(width: 5,),
                          Text("Delete",style: TextStyle(color: Colors.red),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Jinja Farm",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 13),),

                      Text("Weeding",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 13),),

                      Text("120 days",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 13),),

                      Row(
                        children: [
                          Text("Edit",style: TextStyle(color: Colors.green),),
                          SizedBox(width: 5,),
                          Text("Delete",style: TextStyle(color: Colors.red),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Jinja Farm",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 13),),

                      Text("Weeding",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 13),),

                      Text("120 days",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 13),),

                      Row(
                        children: [
                          Text("Edit",style: TextStyle(color: Colors.green),),
                          SizedBox(width: 5,),
                          Text("Delete",style: TextStyle(color: Colors.red),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Jinja Farm",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 13),),

                      Text("Weeding",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 13),),

                      Text("120 days",style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 13),),

                      Row(
                        children: [
                          Text("Edit",style: TextStyle(color: Colors.green),),
                          SizedBox(width: 5,),
                          Text("Delete",style: TextStyle(color: Colors.red),),
                        ],
                      )
                    ],
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
