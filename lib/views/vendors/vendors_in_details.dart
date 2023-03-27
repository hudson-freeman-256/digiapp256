
import 'dart:convert';

import 'package:digifarmer/services/add_Edit_Delete_Update_vendor_services.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../../../services/auth_service.dart';
import '../../../../static/static_values.dart';
import '../market/product_detais.dart';
class ViewUserVendorsInDetails extends StatefulWidget {

  final int id;
  final String url;
  final bool isCart;

  final String cartApi;
  const ViewUserVendorsInDetails({Key? key,required this.id, required this.url, required this.isCart, required this.cartApi}) : super(key: key);

  @override
  State<ViewUserVendorsInDetails> createState() => _ViewUserVendorsInDetailsState();
}

TextEditingController daysEntered = TextEditingController();
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

addCartProduct(String api,String id) async {

  // /user/seller-product/cart/new/{id}
  String bearerToken = AuthService.token;

  // /user/seller-product/cart/new/{id}


  print(api);
  var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/${api}${id}");

  http.Response response  =  await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Accept': 'application/json',
    },
  );



  print(response.body);
  return response;
}

addCartRentProduct(int id,String days) async {

  // /user/seller-product/cart/new/{id}
  String bearerToken = AuthService.token;

  // /user/seller-product/cart/new/{id}

  var data = {
    "days": days
  };


  var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/user/rent-service/cart/new/${id}");

  http.Response response  =  await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Accept': 'application/json',
    },
    body: data
  );



  print(response.body);
  return response;
}

class _ViewUserVendorsInDetailsState extends State<ViewUserVendorsInDetails> {


  Map<String, dynamic>? _animalsFeed;




  @override
  void initState()  {
    super.initState();


    print(widget.url+widget.id.toString());

    try{
      AddVendorService.fetchVendorsById(widget.url+widget.id.toString()).then((value) => setState(() => _animalsFeed = value));
    }catch(e){
      Get.back();
    }








  }








  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.kBgColor,
      body: _animalsFeed != null ? Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height /1.8,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(StaticValues.mainApi+_animalsFeed!['data']['image']),
                  fit: BoxFit.cover,

                ),

              ),
          ),
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height /2,
                    padding: const EdgeInsets.only(bottom: 30),
                    width: MediaQuery.of(context).size.width / 1,
                  ),
                  Positioned(
                    top: 40,
                    left: 0,
                    child: IconButton(
                      onPressed: () {

                        Get.back();
                      },
                      icon: const Icon(
                        Ionicons.chevron_back,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(

                      padding: const EdgeInsets.only(top: 40, right: 5, left: 5),
                      height: MediaQuery.of(context).size.height,
                      decoration:  BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 7), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 1.2,
                                    child: Text(
                                      _animalsFeed!['data']['name'] ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style:  StaticValues.customFonts(CustomColors.black, 22, FontWeight.w700),
                                    ),
                                  ),
SizedBox(height: 10,),

                                  _animalsFeed!['data']['charge'] != null ?
                                  Row(
                                    children: [
                                      Text(
                                         "UGX ",
                                        style: StaticValues.customFonts(CustomColors.gary, 15, FontWeight.w700),
                                      ),
                                      Text(
                                        '${StaticValues.formatter.format(_animalsFeed!['data']['charge']) }' ?? "",
                                        style: StaticValues.customFonts(Colors.orange, 20, FontWeight.w700),
                                      ),
                                    ],
                                  )
                                      :
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start
    ,
                                    children: [
                                      Text(
                                        '${_animalsFeed!['data']['price_unit'] } ' ?? "",
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                       StaticValues.formatter.format( _animalsFeed!['data']['price']) ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style:     StaticValues.customFonts(Colors.orange, 20, FontWeight.w700),
                                      ),
                                    ],
                                  )
                                  ,

                                  SizedBox(height: 10,)





                                ],
                              ),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.8),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Center(child: Text("Chat",style: StaticValues.customFonts(CustomColors.black, 15, FontWeight.w700),)),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.8),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Center(child: Text("Call",style: StaticValues.customFonts(CustomColors.black, 15, FontWeight.w700),)),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.8),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Center(child: Text("Video Call",style:  StaticValues.customFonts(CustomColors.black, 15, FontWeight.w700),)),
                                  ),
                                ],
                              ),

SizedBox(height: 5,),

                              _animalsFeed!['data']['availability'] != null ?     Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Availability",style:  StaticValues.customFonts(CustomColors.black, 18, FontWeight.w700)),
                                    SizedBox(width: 5,),
                                    Text(_animalsFeed!['data']['availability'] ?? "",style:  StaticValues.customFonts(CustomColors.gary, 15, FontWeight.w700),),
                                  ],
                                ),
                              ) : Container(),
//
                              SizedBox(height: 5,),
                              _animalsFeed!['data']['access'] != null ?     Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text("Access:",style:  StaticValues.customFonts(CustomColors.black, 18, FontWeight.w700)),
                                    SizedBox(width: 5,),
                                    Text(_animalsFeed!['data']['access'] ?? "",style:  StaticValues.customFonts(CustomColors.gary, 15, FontWeight.w700)),
                                  ],
                                ),
                              ) : Text(""),
                              _animalsFeed!['data']['vendor_category'] != null ?     Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Vendor Category:",style:  StaticValues.customFonts(CustomColors.black, 18, FontWeight.w700)),
                                    SizedBox(width: 5,),
                                    Text(_animalsFeed!['data']['availability'] ?? "",style:  StaticValues.customFonts(CustomColors.gary, 15, FontWeight.w700)),
                                  ],
                                ),
                              ) : Container(),

                              SizedBox(height: 5,),
                              _animalsFeed!['data']['rent_category'] != null ?     Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                          "Rent Category",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style:  StaticValues.customFonts(CustomColors.black, 18, FontWeight.w700)
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(_animalsFeed!['data']['rent_category'] ?? "",style:  StaticValues.customFonts(CustomColors.gary, 15, FontWeight.w700)),
                                  ],
                                ),
                              ) :  Container(),

                              SizedBox(height: 5,),
                              _animalsFeed!['data']['animal_feed_category'] != null ?     Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(

                                      width: MediaQuery.of(context).size.width / 1,
                                      child: Text(
                                          "Animal Feed Category",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: StaticValues.customFonts(CustomColors.black, 18, FontWeight.w700)
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(_animalsFeed!['data']['animal_feed_category'] ?? "",style:  StaticValues.customFonts(CustomColors.gary, 15, FontWeight.w700)),
                                  ],
                                ),
                              ) :  Container(),

                              SizedBox(height: 5,),
                              _animalsFeed!['data']['animal_category'] != null ?     Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                        "Animal  Category",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style:  StaticValues.customFonts(CustomColors.black, 18, FontWeight.w700)
                                    ),

                                    SizedBox(width: 5,),
                                    Text(_animalsFeed!['data']['animal_category'] ?? "",style:
                                    StaticValues.customFonts(CustomColors.gary, 15, FontWeight.w700)),
                                  ],
                                ),
                              ) :  Container(),
                              // animal_feed_category
                              SizedBox(height: 5,),
                              _animalsFeed!['data']['weight'] != null ?     Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Weight",style:  StaticValues.customFonts(CustomColors.black, 18, FontWeight.w700)),
                                    SizedBox(width: 5,),
                                    Text(_animalsFeed!['data']['weight'] ?? "",style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey ,fontWeight: FontWeight.w700,)),
                                  ],
                                ),
                              ) :  Container(),

                              SizedBox(height: 5,),
                              _animalsFeed!['data']['location'] != null ?     Padding(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Location",style:  StaticValues.customFonts(CustomColors.black, 18, FontWeight.w700)),
                                    SizedBox(width: 5,),
                                    Text(_animalsFeed!['data']['location'] ?? ""
                                        "",style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey ,fontWeight: FontWeight.w700,)),
                                  ],
                                ),
                              ) :  Container(),


//     // ,"category":"Hoes","vendor":"Freeman Hardson"
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _animalsFeed!['data']['category'] != null ?     Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Category",style: GoogleFonts.poppins(fontSize: 20, color: Colors.black ,fontWeight: FontWeight.w700,)),
                                        SizedBox(width: 5,),
                                        Text(_animalsFeed!['data']['category'] ?? "",style: GoogleFonts.poppins(fontSize: 17, color: Colors.grey ,fontWeight: FontWeight.w700,)),
                                      ],
                                    ),
                                  ) : Text(""),

                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _animalsFeed!['data']['vendor'] != null ?     Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Vendor",style: GoogleFonts.poppins(fontSize: 20, color: Colors.black ,fontWeight: FontWeight.w700,)),
                                        SizedBox(width: 5,),
                                        Text(_animalsFeed!['data']['vendor'] ?? "",style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey,fontWeight: FontWeight.w700,)),
                                      ],
                                    ),
                                  ) : Text(""),

                                ],
                              ),
//               // expertise
//
                              _animalsFeed!['data']['expertise'] != null ?     Padding(
                                padding: const EdgeInsets.all(00),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Expertise ",style: GoogleFonts.poppins(fontSize: 20, color: Colors.black ,fontWeight: FontWeight.w700,)),
                                    SizedBox(width: 5,),
                                    Text(_animalsFeed!['data']['expertise'] ?? "",style: GoogleFonts.poppins(fontSize: 15 ,fontWeight: FontWeight.w400,color: Colors.grey)),
                                  ],
                                ),
                              ) : Text(""),
//
//               // terms
                              _animalsFeed!['data']['terms'] != null ?     Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Terms:",style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey ,fontWeight: FontWeight.w700,)),
                                    SizedBox(width: 5,),
                                    Text(_animalsFeed!['data']['terms'] ?? ""),
                                  ],
                                ),
                              ) : Container(),
//

//
//
                              _animalsFeed!['data']['vendor'] == AuthService.username ?
                              Padding
                                (
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Colors.red)
                                        ),
                                        onPressed: (){


                                        },
                                        child: Text("Delete")),
                                  ),
                                ),
                              ):

//
//
                              SizedBox(height: 10,),




                              SizedBox(height: 15),
                              Text("About",style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),),
                              Text(
                                _animalsFeed!['data']['description'] ?? "",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,

                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 15),

                              Text(
                                "Posted ${_animalsFeed!['data']['time_since']}" ?? "",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),

                              widget.isCart ?

                              Padding(
                                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width ,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                                      ),
                                      onPressed: () async {

                                        // /user/animal-feed/cart/new/27
                                        // /user/seller-product/cart/new/{id}



                                        showAlertDialog(context);

                                        print(_animalsFeed!['data']['charge']);
                                        print( _animalsFeed!['data']['id']);


                                        http.Response response = await AddVendorService.buy(_animalsFeed!['data']['price'], "farming", _animalsFeed!['data']['id']);


                                        Navigator.pop(context);
                                        Map responseMap = jsonDecode(response.body);

                                        // if (response.statusCode == 200) {
                                        // if (responseMap['success'] == false) {
                                        //   StaticValues.errorSnackBar(context, responseMap['message']);
                                        // }


                                        if (responseMap['success'] == true) {

                                          StaticValues.successSnackBar(context, responseMap['message']);


                                          StaticValues.successSnackBar(context, responseMap.toString());

                                          // return Get.back();
                                        }else{
                                          StaticValues.errorSnackBar(context, responseMap['message']);
                                        }



                                      },
                                      child: GestureDetector(
                                        onTap: () async {
                                          // fetchVendorsById



                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.shopping_cart_checkout),
                                                const Text("Buy"),

                                              ],
                                            ),

                                          ],
                                        ),
                                      )),
                                ),
                              )
                                  : Container()


                            ],
                          ),
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
              )
            ],
          )
        ],
      ) : const Center(child: CircularProgressIndicator(color: CustomColors.barColor,),),

    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Days To Rent'),
          content: TextField(
            keyboardType: TextInputType.number,

            controller: daysEntered ,
            decoration: InputDecoration(hintText: "1 to 30 Days"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('OK'),
              onPressed: () async {

                if(daysEntered.text.isNotEmpty){

                  showAlertDialog(context);
                  //
                  http.Response isUploaded = await addCartRentProduct(widget.id,daysEntered.text);

                  Navigator.pop(context);

                  Map responseMap = jsonDecode(isUploaded.body);


                  if(responseMap['success'] == true){

                    StaticValues.successSnackBar(context, responseMap['message']);



                  }else{
                    StaticValues.errorSnackBar(context, responseMap['message']);
                  }

                  Navigator.pop(context);
                }else{
                  StaticValues.errorSnackBar(context, "Days a required ");
                }


              },
            ),
          ],
        );
      },
    );
  }
}





