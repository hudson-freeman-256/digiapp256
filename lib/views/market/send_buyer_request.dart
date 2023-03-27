import 'dart:convert';

import 'package:digifarmer/services/market.dart';
import 'package:digifarmer/views/market/product_detais.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../static/color.dart';
import '../../static/static_values.dart';
import 'package:http/http.dart' as http;

import '../home/shopping_cart.dart';
import '../vendors/vendors_in_details.dart';
class BuyerRequest extends StatefulWidget {
  final String id;
  const BuyerRequest({Key? key, required this.id}) : super(key: key);

  @override
  State<BuyerRequest> createState() => _BuyerRequestState();
}

String? selectedAddress;

List address_data = [];

TextEditingController amount = TextEditingController();

class _BuyerRequestState extends State<BuyerRequest> {

  Future<String> selectAddress() async {

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"user/my-addresses"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    setState(() {
      address_data = resBody['data'];
    });


    return "Sucess";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectAddress();
  }


  @override
  Widget build(BuildContext context) {





    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.barColor,
        title: const Text("Send A buyer Request"),
      ),
      body: Container(
          color: Colors.grey.shade200,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Center(child: Text("Add Animal Feed",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 25))),
                // ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,

                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [




                           Padding(
                            padding: EdgeInsets.all(15),
                            child: TextField(
                              controller: amount,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Amount',
                                hintText: 'Amount',
                              ),
                            ),
                          ),




                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text(
                                  'Select Address',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme
                                        .of(context)
                                        .hintColor,
                                  ),
                                ),
                                items: address_data.map((item) {
                                  return new DropdownMenuItem(
                                      child: new Text(
                                        item['address_name'],    //Names that the api dropdown contains
                                        style: TextStyle(
                                          fontSize: 13.0,
                                        ),
                                      ),
                                      value: item['id'].toString()       //Id that has to be passed that the dropdown has.....
                                    //e.g   India (Name)    and   its   ID (55fgf5f6frf56f) somethimg like that....
                                  );
                                }).toList(),
                                value: selectedAddress,
                                onChanged: (value) {
                                  setState(() {
                                    selectedAddress = value as String;
                                  });
                                },
                                buttonHeight: 40,
                                buttonWidth: MediaQuery.of(context).size.width,
                                itemHeight: 40,
                              ),
                            ),
                          ),












                          Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                                ),
                                onPressed: () async {

                                  // addFarm();

                                  if(selectedAddress == null){
                                    StaticValues.errorSnackBar(context, "Address can't be empty");

                                  }else if(amount.text.isEmpty){
                                    StaticValues.errorSnackBar(context, "Amount can't be empty");

                                  }
                                  else{



                                    showAlertDialog(context);


                                    // String name,String price,String weight,String description,String selectedSubCategory,String selectedUnit,String selectedAddressId,String imagePath

                                    http.Response  isUploaded = await ServiceMarket.sendBuyerRequest(widget.id, amount.text, selectedAddress);


                                    Navigator.pop(context);

                                    Map responseMap = jsonDecode(isUploaded.body);


                                    if(responseMap['success'] == true){

                                      StaticValues.successSnackBar(context, responseMap['message']);

                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductDetailsView(api: widget.id,isUser: false ),)).then(
                                              (value) =>
                                              setState(() {
                                                // Call setState to refresh the page.
                                              })
                                      );

                                    }else{

                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductDetailsView(api: widget.id,isUser: false ,) ,)).then(
                                              (value) =>
                                              setState(() {
                                                // Call setState to refresh the page.
                                              })
                                      );


                                      StaticValues.successSnackBar(context, responseMap['message']);
                                    }

                                  }


                                  // addAnimalFeed();
                                },
                                child: Text("Send"),
                              ),
                            ),
                          )

                        ],
                      ),
                    ),

                  ),
                )
              ],
            ),
          )

      ),
    )
    ;
  }
}
