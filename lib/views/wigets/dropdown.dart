import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownButton extends StatefulWidget {

   List data = [];
  final String name;
  final String? selected;
   DropDownButton({Key? key, required this.name, required this.data, required this.selected}) : super(key: key);

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: DropdownButtonFormField2(
        decoration: InputDecoration(
          //Add isDense true and zero Padding.
          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          //Add more decoration as you want here
          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
        ),
        isExpanded: true,
        hint:  Text(
          widget.name,
          style: TextStyle(fontSize: 14),
        ),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 30,
        buttonHeight: 60,
        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        items: widget.data.map((item) {
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
        value: widget.selected,
        onChanged: (value) {
          setState(() {
            // widget.selected! = value as String;
          });

          // selectSubCategory(value as String);
        },
        buttonWidth: MediaQuery.of(context).size.width,
        itemHeight: 40,
      ),
    );
  }
}
