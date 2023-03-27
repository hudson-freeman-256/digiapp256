import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:textfields/textfields.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController dateController = TextEditingController();

  final List<String> items = [
    'Kampala Farm',
    'A_Item2',
    'A_Item3',
    'A_Item4',
    'B_Item1',
    'B_Item2',
    'B_Item3',
    'B_Item4',
  ];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();


  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        dateController.text = selectedDate as String; //set foratted date to TextField value.
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Add Task"),


      ),

      body:
                    Container(
                width: MediaQuery.of(context).size.width * 2,
                height: MediaQuery.of(context).size.height /2.1,
                child: Card(
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(

                      children: [
                        Column(
                          children: [

                            BorderTextFieldWithIcon(
                              hintText: " Add Task Name",

                              suffixIcon: Icon(
                                Icons.task,
                                // color: Colors.white,
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonHideUnderline(

                                child: DropdownButton2(

                                  isExpanded: true,
                                  hint: Text(
                                    'Select Plot',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: items
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value as String;
                                    });
                                  },
                                  buttonHeight: 40,
                                  buttonWidth: 200,
                                  itemHeight: 40,
                                  dropdownMaxHeight: 200,
                                  searchController: textEditingController,
                                  searchInnerWidget: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextFormField(
                                      controller: textEditingController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 20,
                                        ),
                                        hintText: 'Search for an plots...',
                                        hintStyle: const TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return (item.value.toString().contains(searchValue));
                                  },
                                  //This to clear the search value when you close the menu
                                  onMenuStateChange: (isOpen) {
                                    if (!isOpen) {
                                      // textEditingController.clear();
                                    }
                                  },
                                ),

                              ),
                            ),

                          ],
                        ),

SizedBox(height: 10,),


                        SizedBox(height: 10,),

                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            hintText: 'Choose Your Date.',
                            hintStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            icon: Icon(Icons.date_range)
                          ),
                        ),
                        // TextField(
                        //     //editing controller of this TextField
                        //   controller: dateController,
                        //   decoration: const InputDecoration(
                        //         icon: Icon(Icons.calendar_today), //icon of text field
                        //         labelText: "Enter Date" //label text of field
                        //     ),
                        //     readOnly: true,  // when true user cannot edit text
                        //     onTap: () => _selectDate(context),
                        //
                        //
                        //
                        //
                        // )
                        SizedBox(height: 10,),
                        Center(
                          child: ElevatedButton(
                            onPressed: (){

                            },
                            child: Text("Save"),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}
