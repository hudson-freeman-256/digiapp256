import 'dart:convert';

import 'package:digifarmer/services/market.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/market/send_buyer_request.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../services/auth_service.dart';
import '../../static/static_values.dart';
import '../home/shopping_cart.dart';

class ProductDetailsView extends StatefulWidget {
  final bool isUser;
  final String api;
   const ProductDetailsView({Key? key,required this.isUser, required this.api}) : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}
TextEditingController price =TextEditingController();
List address_data = [];
String? selectedAddress;
class _ProductDetailsViewState extends State<ProductDetailsView> {
  Map<String, dynamic>? _cropData;





  @override
  void initState()  {
    super.initState();


    ServiceMarket.fetchCropOnSaleById(widget.api).then((value) => setState(() => _cropData = value));






  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.kBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.kBgColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {

            Get.back();
          },
          icon: const Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          ),
        ),
        actions: [

        ],
      ),
      body: _cropData != null ? Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child: Image.network(StaticValues.mainApi+_cropData!['data']['image']),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(

                  padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _cropData!['data']['crop'] ?? "",
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${_cropData!['data']['price_unit'] }   ',
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${StaticValues.formatter.format(_cropData!['data']['selling_price']) }   ',
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Quantity :',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),

                                Text(
                                  " ${_cropData!['data']['quantity']} ${_cropData!['data']['quantity_unit']}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),




                              ],
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'farmer :',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),

                                Text(
                                  " ${_cropData!['data']['farmer']}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),




                              ],
                            ),

                          ],
                        ),

                        // farmer

                        const SizedBox(height: 15),
                        Text(
                          _cropData!['data']['description'] ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),

                        Text(
                          _cropData!['data']['time_since'] ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Visibility(
                          visible: widget.isUser,
                            child: Center(
                          child: _cropData!['data']['is-sold']  ? ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                              ),
                              onPressed: (){

                              },
                              child: Text("Buy")) : ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.redAccent)
                              ),
                              onPressed: (){

                              },
                              child: GestureDetector(
                                  onTap: () {

                                    print(widget.api);

                                    Get.to( BuyerRequest(id:widget.api,));
                                    // _displayTextInputDialog(context,widget.api);
                                  },
                                  child: Text("Send A Buy Request",style: GoogleFonts.poppins(),))),
                        ))
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.kGreyColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ) : Center(child: CircularProgressIndicator(color: CustomColors.barColor,),),

    );
  }
}
// Future<void> _displayTextInputDialog(BuildContext context,String id) async {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text('Buy Request'),
//         content: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton2(
//                   hint: Text(
//                     'Select Address',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Theme
//                           .of(context)
//                           .hintColor,
//                     ),
//                   ),
//                   items: address_data.map((item) {
//                     return new DropdownMenuItem(
//                         child: new Text(
//                           item['address_name'],    //Names that the api dropdown contains
//                           style: TextStyle(
//                             fontSize: 13.0,
//                           ),
//                         ),
//                         value: item['id'].toString()       //Id that has to be passed that the dropdown has.....
//                       //e.g   India (Name)    and   its   ID (55fgf5f6frf56f) somethimg like that....
//                     );
//                   }).toList(),
//                   value: selectedAddress,
//                   onChanged: (value) {
//                     // setState(() {
//                       selectedAddress = value as String;
//                     // });
//                   },
//                   buttonHeight: 40,
//                   buttonWidth: MediaQuery.of(context).size.width,
//                   itemHeight: 40,
//                 ),
//               ),
//             ),
//             TextField(
//               keyboardType: TextInputType.number,
//
//               controller: price ,
//               decoration: InputDecoration(hintText: "Price"),
//             ),
//           ],
//         ),
//         actions: <Widget>[
//           ElevatedButton(
//             child: Text('CANCEL'),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           ElevatedButton(
//             child: Text('OK'),
//             onPressed: () async {
//
//               if(price.text.isNotEmpty){
//
//                 showAlertDialog(context);
//                 //
//                 http.Response isUploaded = await ServiceMarket.sendBuyerRequest(id, price.text);
//
//                 Navigator.pop(context);
//
//                 Map responseMap = jsonDecode(isUploaded.body);
//
//
//                 if(responseMap['success'] == true){
//
//                   StaticValues.successSnackBar(context, responseMap['message']);
//
//
//
//                 }else{
//                   StaticValues.errorSnackBar(context, responseMap['message']);
//                 }
//
//                 Navigator.pop(context);
//               }else{
//                 StaticValues.errorSnackBar(context, "Days a required ");
//               }
//
//
//             },
//           ),
//         ],
//       );
//     },
//   );
// }


class AppColors {
  static HexColor kBgColor = HexColor('e7ded7');
  static HexColor kGreyColor = HexColor('dcdde2');
  static HexColor kSmProductBgColor = HexColor('f9f9f9');
}
