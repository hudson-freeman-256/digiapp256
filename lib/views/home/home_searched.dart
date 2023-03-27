import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/search_model.dart';
import '../../services/auth_service.dart';
import '../../static/color.dart';
import '../../static/static_values.dart';
import 'package:http/http.dart' as http;

class HomeSearched extends StatefulWidget {
  final String searchData;
  const HomeSearched({Key? key, required this.searchData}) : super(key: key);

  @override
  State<HomeSearched> createState() => _HomeSearchedState();
}


List searchData = [];

class _HomeSearchedState extends State<HomeSearched> {



  Future<List<SearchModel>> search() async{


    var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/search/home?keyword=${widget.searchData}");

    http.Response response  =  await http.get(
      url,
      headers: StaticValues.headers,

    );


    if (response.statusCode == 200) {


      // var result = json.decode(response.body);



      final result = json.decode(response.body);
      // Iterable list = result['data']['search-results']['crops-on-sale'];
      Iterable list = result['data']['search-results']['agronomist-services'];

      if(result['data']['search-results']['crops-on-sale'] != null){
        print("crop");
      }else if(result['data']['search-results']['agronomist-services'] != null){
        print("agronmist");
      }





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
          title:  Text("Search Results: ${widget.searchData}...",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),

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
                    return Text('No Data Found');
                  }
                  else {


                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {


                          return  GestureDetector(
                            onTap: (){


                              // Get.to(ViewUserVendorsInDetails(url: widget.vendorType!,id: snapshot.data![index].id!,isCart: false,));
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
                                        padding: const EdgeInsets.only(left: 8.0),
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
                                                style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),
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
                                                style: GoogleFonts.poppins(color: Colors.grey.shade700,fontWeight: FontWeight.bold,fontSize: 14),
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
}}
