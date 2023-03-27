import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../static/color.dart';
import '../../static/static_values.dart';
import '../vendors/search_data.dart';
class SearchWidget extends StatefulWidget {

 final TextEditingController search;
 final String? searchRoute,vendorType;
  const SearchWidget({
    Key? key, required this.search, required this.searchRoute, required this.vendorType,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(
        left:5,
        right: 5,
        top: 5 * 1.5,
      ),
      child: Material(
        elevation: 10.0,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        child:  TextField(
          style: StaticValues.customFonts(Colors.grey,15,FontWeight.w300),
          controller: widget.search,
          decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.symmetric(
                vertical: 5 * 0.75,
                horizontal: 5,
              ),
              fillColor: Colors.white,
              hintText: 'Search here....',
              suffixIcon: GestureDetector(
                onTap: (){

                  if(widget.search.text.isNotEmpty){
                    Get.to(SearchedData(searchData: widget.search.text,searchRoute: widget.searchRoute,vendorType: widget.vendorType,));
                  }else{
                    StaticValues.errorSnackBar(context, "Search area can't be empty");
                  }
                },
                child: Icon(
                  Icons.search_rounded,
                  size: 25,
                  color: CustomColors.barColor,
                ),
              )),
        ),
      ),
    );
  }
}