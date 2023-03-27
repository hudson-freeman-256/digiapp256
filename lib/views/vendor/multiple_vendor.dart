import 'dart:convert';
import 'package:digifarmer/models/rent.dart';
import 'package:digifarmer/services/home_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../static/color.dart';
import '../../static/static_values.dart';

import '../wigets/single_vendor.dart';



class MultipleVendor extends StatefulWidget {



  @override
  State<MultipleVendor> createState() => _MultipleVendorState();


}






class _MultipleVendorState extends State<MultipleVendor> {


  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: CustomColors.aBackground,
            child: Column(
              children: [

                // Search(name: "Rent"),






                // FutureBuilder<List<Rent>>(
                //   future: HomeService.getRent(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //
                //       print(snapshot.data![0].rentImages![0].url);
                //
                //       // snapshot.data![index].addressName.toString()
                //       return GestureDetector(
                //         onTap: (){
                //           print(snapshot.data);
                //         },
                //         child: ListView.builder(
                //
                //           shrinkWrap: true,
                //           itemCount: snapshot.data!.length,
                //           itemBuilder: (context, index) {
                //             return
                //             Padding(
                //               padding: const EdgeInsets.only(right: 8.0 , left: 8),
                //               child: SingleVendorCard(
                //                 snapshot.data![index].name!,
                //                 3.5,
                //                 snapshot.data![index].description!,
                //                 StaticValues.mainApi+snapshot.data![index].rentImages![0].url!,
                //                     () {
                //
                //                 },
                //                 ""
                //               ),
                //             );
                //
                //           },
                //         ),
                //       );
                //     } else if (snapshot.hasError) {
                //       return Center(child:  Text(snapshot.error.toString()));
                //     }
                //     return const Center(child: Padding(
                //       padding: EdgeInsets.all(8.0),
                //       child: CircularProgressIndicator(),
                //     ));
                //   },
                // ),

                // SingleVendorCard(
                //   "Car Renter",
                //   3.5,
                //   "Lorem ipsum dolor sit amet, consectetuer adipiscing elit...",
                //   "https://www.shutterstock.com/image-vector/car-rental-company-logo-rent-600w-356620781.jpg",
                //       () {
                //
                //   },
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }



}