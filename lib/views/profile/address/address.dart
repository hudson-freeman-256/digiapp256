import 'dart:convert';
import 'package:digifarmer/models/Address.dart';
import 'package:digifarmer/services/address_service.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/profile/address/addAddress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../static/static_values.dart';
import '../../market/daily_fresh.dart';
import '../../wigets/no_product.dart';



class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}


class _AddressState extends State<Address> {



  @override
  void initState() {
    super.initState();


  }

  deleteFarm(String id) async {


    showAlertDialog(context);


    http.Response response = await AddressService.deleteAddress(id);

    Navigator.pop(context);
    Map responseMap = jsonDecode(response.body);


    if (response.statusCode == 200) {
      if (responseMap['success'] == false) {
        StaticValues.errorSnackBar(context, responseMap['errors']);
      }


      if (responseMap['success'] == true) {

        StaticValues.successSnackBar(context, responseMap['message']);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Address() ,)).then(
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
        backgroundColor: CustomColors.barColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.barColor,
        onPressed: (){
          Get.to(const AddAddress());
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(

        onRefresh: () async{
          setState(() {

          });
        },
        child: FutureBuilder<List<AddressUser>>(
          future: AddressService.getAddress(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              print(snapshot.data);
              // snapshot.data![index].addressName.toString()
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 5,),

                          Padding(padding: EdgeInsets.all(5),
                            child:Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.place, size: 45,color: Colors.green,),
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshot.data![index].districtName.toString(),style: GoogleFonts.poppins(fontSize: 15),),
                                        GestureDetector(
                                            onTap: (){
                                              deleteFarm(snapshot.data![index].id.toString());
                                            },
                                            child: const Icon(Icons.delete_forever,color: Colors.red,))
                                      ],
                                    ),


                                  ),


                                ],
                              ),
                            ) ,

                          ),


                          SizedBox(height: 5,),
                        ],
                      ),
                    );
                },
              );
            } else if (snapshot.hasError) {
              return const ProductError(name: "Address(s)",);
            }
            return  Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(color: CustomColors.barColor,),
            ));
          },
        ),
      ),
    );
  }
}
