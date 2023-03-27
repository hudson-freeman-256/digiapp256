
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digifarmer/static/static_values.dart';
import 'package:digifarmer/views/market/product_detais.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/constants.dart';
import '../../static/color.dart';

class SingleNoPriceVendorCard extends StatefulWidget{

  final String name;
  final String location;
  final String description ;
  final String? image;







  const SingleNoPriceVendorCard(  this.name, this.description, this.image, this.location, {Key? key}) : super(key: key);

  @override
  State<SingleNoPriceVendorCard> createState() => _SingleNoPriceVendorCardState();
}

class _SingleNoPriceVendorCardState extends State<SingleNoPriceVendorCard> {
  @override
  Widget build(BuildContext context) {




    return

      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(widget.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                    child: Text(
                      widget.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: StaticValues.customFonts(
                        Colors.black,
                        15,
                        FontWeight.w700,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,


                  ),

                  SizedBox(
                    height: 20,
                    child:               Row(
                      children: [
                        widget.location != ""
                            ? Icon(
                          Icons.location_on_outlined,
                          color: CustomColors.grayshade,
                          size: 10,
                        )
                            : Container(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.2,
                          child: Text(
                            widget.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StaticValues.customFonts(
                              Colors.grey,
                              13,
                              FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                  )



                ],
              ),
            ),
          ],
        ),
      );



  }
}