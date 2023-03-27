import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digifarmer/services/market.dart';
import 'package:digifarmer/static/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/constants.dart';
import '../../models/data.dart';
import '../../models/fruits_and_vegs.dart';
import 'package:http/http.dart' as http;

import '../../static/static_values.dart';

class DailyFresh extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final String description;
  final String price;
  final String priceUnit;

  const DailyFresh({Key? key, required this.image, required this.name,   required this.price, required this.description, required this.priceUnit, required this.id}) : super(key: key);



  @override
  State<DailyFresh> createState() => _DailyFreshState();
}

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


class _DailyFreshState extends State<DailyFresh> {
//Categories of fruits or vegetables

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: appPadding,
            right: appPadding / 2,
            bottom: appPadding,
          ),
          child: Container(
            width: size.width * 0.55,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: black.withOpacity(0.2),
                  offset: const Offset(5, 5),
                  blurRadius: 10,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(appPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeInImage(

                      placeholder: const AssetImage('assets/LOADING_ANIMATION.gif'),
                      image: Image(
                        image: CachedNetworkImageProvider(
                            widget.image!
                        ),
                        // placeholder: (context, url) => CircularProgressIndicator(),
                        errorBuilder: (context, url, error) => Icon(Icons.error),
                      ).image,

                      imageErrorBuilder:
                          (context, error, StackTrace) {
                        return const Image(
                            width: 50,
                            height: 50,
                            image:
                            AssetImage("assets/no_image.jpg"));
                      }


                  ),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1,
                    child: Text(
                      widget.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: GoogleFonts.actor(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 12),
                    ),
                  ),
                  Text(
                    '${widget.priceUnit} ${widget.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: appPadding * 1,
          bottom: appPadding / 3,
          child: GestureDetector(
            onTap: () async {


              showAlertDialog(context);


              http.Response response =  await ServiceMarket.saveProduct(widget.id);


              Navigator.pop(context);

              Map responseMap = jsonDecode(response.body);

              // if (response.statusCode == 200) {
              // if (responseMap['success'] == false) {
              //   StaticValues.errorSnackBar(context, responseMap['message']);
              // }


              if (responseMap['success'] == true) {

                StaticValues.successSnackBar(context, responseMap['message']);

              }else{
                StaticValues.errorSnackBar(context, responseMap['message']);
              }

            },
            child: Container(
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.5),
                      offset: const Offset(3, 3),
                      blurRadius: 3,
                    )
                  ]),
              padding: const EdgeInsets.symmetric(
                vertical: appPadding / 4,
                horizontal: appPadding / 1.5,
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.book_outlined,
                    size: 20,
                    color: CustomColors.barColor,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }


}
