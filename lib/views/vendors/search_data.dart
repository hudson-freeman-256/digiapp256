import 'dart:convert';

import 'package:digifarmer/views/vendors/vendors_in_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../models/search_model.dart';
import '../../static/color.dart';
import '../../static/static_values.dart';
import '../wigets/single_vendor.dart';

class SearchedData extends StatefulWidget {
  final String? searchData;
  final String? searchRoute;
  final String? vendorType;
  const SearchedData({Key? key, required this.searchData, required this.searchRoute, required this.vendorType}) : super(key: key);

  @override
  State<SearchedData> createState() => _SearchedDataState();
}

List searchData = [];









class _SearchedDataState extends State<SearchedData> {



  Future<List<SearchModel>> search() async{


    var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/search/${widget.searchRoute}?keyword=${widget.searchData}");

    http.Response response  =  await http.get(
      url,
      headers: StaticValues.headers,

    );


    print(response.body);

    if (response.statusCode == 200) {


      // var result = json.decode(response.body);

      final result = json.decode(response.body);
      Iterable list = result['data']['search-results'];





      return list.map((model) => SearchModel.fromJson(model)).toList();


    } else {
      throw Exception('Failed to load data');
    }





  }

  @override
  void initState()  {
    super.initState();


    search();




  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Search Results: ${widget.searchData}...",style: StaticValues.customFonts(Colors.white,20,FontWeight.w700),

        ),backgroundColor: CustomColors.barColor,
      ),
      body:   SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[


            FutureBuilder(
              future: search(),
              builder: (BuildContext context,

                  AsyncSnapshot<List<SearchModel>> snapshot) {



                if (snapshot.connectionState != ConnectionState.done) {


                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator(color: CustomColors.barColor,)),
                  );

                }else if (snapshot.data == null ) {
                  return Text('No Data Found',style: StaticValues.customFonts(Colors.white,20,FontWeight.w700),);
                }
                else {


                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {


                        return  GestureDetector(
                          onTap: (){


                            Get.to(ViewUserVendorsInDetails(url: widget.vendorType!,id: snapshot.data![index].id!,isCart: false,cartApi: "",));
                          },


                          child: Container(
                            height: 150,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FadeInImage(
                                        height: 100,
                                        width: 100,
                                        placeholder: const AssetImage('assets/LOADING_ANIMATION.gif'),
                                        image: NetworkImage(StaticValues.mainApi+snapshot.data![index].image!),

                                        imageErrorBuilder:
                                            (context, error, StackTrace) {
                                          return const Image(
                                              width: 100,
                                              image:
                                              AssetImage("assets/no_image.jpg"));
                                        }


                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,top: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 1.6,
                                            child: Text(
                                              snapshot.data![index].name! ?? "",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: StaticValues.customFonts(Colors.black,17,FontWeight.w700),
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 1.6,
                                            child: Text(
                                              snapshot.data![index].description! ?? "",
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: StaticValues.customFonts(Colors.grey.shade600,13,FontWeight.w400),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount:snapshot.data?.length
                  );
                }
              },
            ),
          ],
        ),
      )
    );
  }
}
