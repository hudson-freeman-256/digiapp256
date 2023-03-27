import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart'
    as slideDialog;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digifarmer/models/animal_feeds.dart';
import 'package:digifarmer/models/insuarance.dart';
import 'package:digifarmer/services/auth_service.dart';
import 'package:digifarmer/services/home_service.dart';
import 'package:digifarmer/views/home/shopping_cart.dart';

import 'package:digifarmer/views/vendor/single_vendor.dart';
import 'package:digifarmer/views/vendors/vendors_in_details.dart';
import 'package:digifarmer/views/vendors/veterinary/view_veterinary.dart';
import 'package:digifarmer/views/wigets/refreshWiget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import '../../ConnectivityService.dart';
import '../../enums/connectivity_status.dart';
import '../../models/Farm.dart';
import '../../models/VendorCategories.dart';
import '../../models/constants.dart';
import '../../models/rent.dart';
import '../../models/user.dart';
import '../../providers/home_screen_provider.dart';
import '../../services/farm_service.dart';
import '../../static/color.dart';
import '../../static/static_values.dart';
import '../vendor/multiple_vendor.dart';
import '../vendors/agronomist/view_agronomist.dart';
import '../vendors/animalfeed/view_animal_feeds.dart';
import '../vendors/farmequipment/view_farm_equipment.dart';
import '../vendors/farmequipment/view_user_farm_equipment.dart';
import '../vendors/insuarance/viewInsuarance.dart';
import '../vendors/rent/view_rent.dart';
import '../vendors/training/view_training.dart';
import '../wigets/images.dart';
import '../wigets/shopping_cart.dart';
import '../wigets/single_vendor.dart';

import 'package:http/http.dart' as http;

import '../wigets/single_vendor_no_price.dart';
import 'home_searched.dart';

class HomeScreen extends StatefulWidget {
  static int? totalCartItems = 0;
  static int? totalCartQuantity = 0;
  static int? totalGrandAmount = 0;

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController search = TextEditingController();

  List plot_data = [];

  Future<String> getData() async {
    String bearerToken = AuthService.token;

    final response = await http.get(
      Uri.parse(
          "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/user/seller-product/cart-items"),
      headers: {
        'Authorization': 'Bearer $bearerToken',
      },
    );

    print(json.decode(response.body));

    if (response.statusCode == 200) {
      // var result = json.decode(response.body);

      final result = json.decode(response.body);


      // total-grand_amount

      return "";
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String> selectPlot() async {
    if (search.text.isEmpty) {
      StaticValues.errorSnackBar(context, "Search can't empty");
    } else {
      final String bearerToken = AuthService.token;

      var res = await http.get(
          Uri.parse(
              "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/search/home?search=$search"),
          headers: {
            'Authorization': 'Bearer $bearerToken',
            "Accept": "application/json"
          }); //if you have any auth key place here...properly..
      var resBody = json.decode(res.body);

      print(resBody);

      setState(() {
        plot_data = resBody['data']['search-results'];
      });
    }

    return "Sucess";
  }

  goToVendorCategory(int id, String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (name == "Rent") {
      Get.to(const ViewRent());
    } else if (name == "Training") {
      Get.to(const TrainingView());
    } else if (name == "Animal Feeds") {
      Get.to(const ViewAnimalFeeds());
    } else if (name == "Finance") {
      StaticValues.errorSnackBar(context, "Coming soon");
    } else if (name == "Agronomists") {
      Get.to(const AgronomistView());
    } else if (name == "Insuarance") {
      Get.to(const ViewInsuarance());
    } else if (name == "Veterinary") {
      Get.to(ViewVeterinary());
    } else if (name == "Farm Equipments") {
      Get.to(const ViewFarmEquipment());
    }

    // Get.to(MultipleVendor(),arguments: [
    //   {"id": id},
    //   {"name": name}
    // ]);
  }

  getToken() async {
    var userInfo = await AuthService.token;

    print(userInfo);
  }

  @override
  void initState() {
    setState(() {
      HomeScreen.totalCartItems;
      HomeScreen.totalGrandAmount;
      HomeScreen.totalCartQuantity;
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Farm>> farms() {
      return FarmService.getFarms();
    }

    return SafeArea(
        child: WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: UpgradeAlert(
        upgrader: Upgrader(
            durationUntilAlertAgain: Duration(days: 2),
            shouldPopScope: () => true,
            canDismissDialog: false),
        child: RefreshIndicator(

          onRefresh: () async {
            setState(() {});
          },
          child: ListView(
            children: [

              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  color: CustomColors.barColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20) )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [



                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Text("Welcome to Digi Framer",style: StaticValues.customFonts(Colors.white, 25, FontWeight.w700),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                        right: 5,
                      ),
                      child: Material(
                        elevation: 10.0,
                        color: white,
                        borderRadius: BorderRadius.circular(10.0),
                        child: TextField(
                          style: StaticValues.customFonts(Colors.grey,15,FontWeight.w300),
                          controller: search,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: appPadding * 0.75,
                                horizontal: appPadding,
                              ),
                              fillColor: white,
                              hintText: 'Search Crops,farm products....',
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  if (search.text.isEmpty) {
                                    StaticValues.errorSnackBar(
                                        context, "Search Bar can't be empty");
                                  } else {
                                    Get.to(HomeSearched(
                                      searchData: search.text,
                                    ));
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
                    ),
                  ],
                ),
              ),




              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, top: 10),
                    child: Text(
                      "Vendor Categories",
                      style: StaticValues.customFonts(Colors.black,15,FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, top: 10),
                    child: GestureDetector(
                        child: Text(
                      "View All",
                      style: StaticValues.customFonts(CustomColors.gary,13,FontWeight.w700),
                    )),
                  )
                ],
              ),
              SizedBox(height: 10,),

              FutureBuilder<List<VendorCategories>>(
                future: HomeService.getVendorCategories(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.error.toString());
                    // snapshot.data![index].addressName.toString()
                    return SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              int id = snapshot.data![index].id!;
                              String name = snapshot.data![index].name!;
                              goToVendorCategory(id, name);
                            },
                            child: SizedBox(
                                height: 200,
                                width: 130,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      // FadeImage(image: ,),

                                      CachedNetworkImage(
                                        imageUrl: StaticValues.mainApi +
                                            snapshot.data![index].image!,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                color: CustomColors.barColor,
                                                value: downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )
                                    ],
                                  ),
                                )),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                    color: CustomColors.barColor,
                  ));
                },
              ),

              //Rent

              Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0, top: 10),
                            child: Text(
                              "Rent Vendors",
                              style: StaticValues.customFonts(Colors.black,15,FontWeight.w700),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0, top: 10),
                            child: GestureDetector(
                                onTap: () {
                                  Get.to(ViewRent());
                                },
                                child: Text(
                                  "View All",
                                  style: StaticValues.customFonts(CustomColors.gary,13,FontWeight.w700),
                                )),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(height: 10,),
              //insurance

              FutureBuilder(
                future: Provider.of<HomeScreenProvider>(context, listen: false).fetchHomeRents(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Rent>> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done ||
                      snapshot.hasData == null) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: CustomColors.barColor,
                      ),
                    ));
                  } else {
                    return AlignedGridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      itemCount: snapshot.data?.length!,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Get.to(ViewUserVendorsInDetails(
                                url: "vendors/rent_vendor_services/",
                                id: snapshot.data![index].id!,
                                isCart: true,
                                cartApi: "user/rent-service/cart/new",
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleVendorCard(
                                  snapshot.data![index].name! ?? "",
                                  snapshot.data![index].description! ?? "",
                                  StaticValues.mainApi +
                                      snapshot.data![index].image!,
                                  snapshot.data![index].chargeUnit! ?? "",
                                  snapshot.data![index].charge ?? 0,
                                  snapshot.data![index].location! ?? ""),
                            ));
                      },
                    );
                  }
                },
              ),
              // Column(
              //   children: [
              //     Column(
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(left: 14.0, top: 10),
              //               child: Text(
              //                 "Insurance Vendors",
              //                 style: StaticValues.customFonts(Colors.black,15,FontWeight.w700),
              //               ),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.only(right: 20.0, top: 10),
              //               child: GestureDetector(
              //                   onTap: () {
              //                     Get.to(ViewInsuarance());
              //                   },
              //                   child: Text(
              //                     "View All",
              //                     style: StaticValues.customFonts(CustomColors.gary,13,FontWeight.w700),
              //                   )),
              //             )
              //           ],
              //         ),
              //       ],
              //     )
              //   ],
              // ),
              //
              // FutureBuilder(
              //   future: HomeService.getInsurance(),
              //   builder: (BuildContext context,
              //       AsyncSnapshot<List<Insuarance>> snapshot) {
              //     if (snapshot.connectionState != ConnectionState.done ||
              //         snapshot.hasData == null) {
              //       return const Center(
              //           child: Padding(
              //         padding: EdgeInsets.all(8.0),
              //         child: CircularProgressIndicator(
              //           color: CustomColors.barColor,
              //         ),
              //       ));
              //     } else {
              //       return AlignedGridView.count(
              //         physics: NeverScrollableScrollPhysics(),
              //         shrinkWrap: true,
              //         crossAxisCount: 2,
              //         mainAxisSpacing: 2,
              //         crossAxisSpacing: 2,
              //         itemCount: snapshot.data?.length!,
              //         itemBuilder: (context, index) {
              //           return GestureDetector(
              //               onTap: () {
              //                 StaticValues.errorSnackBar(context, "Something went wrong !!!");
              //                 // Get.to(ViewUserVendorsInDetails(
              //                 //   url: "vendors/insuarance_vendor_services/",
              //                 //   id: snapshot.data![index].id!,
              //                 //   isCart: false,
              //                 //   cartApi: "",
              //                 // ));
              //               },
              //               child: Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: SingleNoPriceVendorCard(
              //                     snapshot.data![index].name! ?? "",
              //                     snapshot.data![index].description! ?? "",
              //                     StaticValues.mainApi +
              //                         snapshot.data![index].image!,
              //                     snapshot.data![index].location! ?? ""),
              //               ));
              //         },
              //       );
              //     }
              //   },
              // ),

              Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0, top: 10),
                            child: Text(
                              "Animal Feeds",
                              style: StaticValues.customFonts(Colors.black,15,FontWeight.w700),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0, top: 10),
                            child: GestureDetector(
                                onTap: () {
                                  Get.to(ViewAnimalFeeds());
                                },
                                child: Text(
                                  "View All",
                                  style: StaticValues.customFonts(CustomColors.gary,13,FontWeight.w700),
                                )),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              FutureBuilder(
                future: HomeService.getAnimalFeeds(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AnimalFeed>> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done ||
                      snapshot.hasData == null) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: CustomColors.barColor,
                      ),
                    ));
                  } else {
                    return AlignedGridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      itemCount: snapshot.data?.length!,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Get.to(ViewUserVendorsInDetails(
                                url: "vendors/animal-feeds/",
                                id: snapshot.data![index].id!,
                                isCart: true,
                                cartApi: "user/animal-feed/cart/",
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleVendorCard(
                                  snapshot.data![index].name! ?? "",
                                  snapshot.data![index].description! ?? "",
                                  StaticValues.mainApi +
                                      snapshot.data![index].image!,
                                  snapshot.data![index].priceUnit! ?? "",
                                  snapshot.data![index].price ?? 0,
                                  snapshot.data![index].location! ?? ""),
                            ));
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      )),
    ));
  }

  void _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: Column(
        children: [
          Center(
            child: Image.asset(
              "assets/error.png",
              height: 30,
            ),
          ),
          Text(
            "Dear valued users,",
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "We are happy to inform you that you have a bonus of 10,000 Ugandan Shillings in your account. However, please be advised that our wallet system is currently under development and may not be available for use at this time We apologize for any inconvenience this may cause and appreciate your understanding. We will keep you updated on the status of the wallet and will notify you as soon as it becomes available for use.Thank you for your patience and continued support.",
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          )
        ],
      ),
      barrierColor: Colors.white.withOpacity(0.7),
      pillColor: Colors.red,
      backgroundColor: Colors.grey.shade200,
    );
  }
}

class BackGroundTile extends StatelessWidget {
  final Color backgroundColor;
  final IconData icondata;

  BackGroundTile({required this.backgroundColor, required this.icondata});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Card(
        color: backgroundColor,
        child: Icon(icondata, color: Colors.white),
      ),
    );
  }
}
