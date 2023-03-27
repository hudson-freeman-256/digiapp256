// import 'dart:convert';
//
// import 'package:digifarmer/models/cart.dart';
// import 'package:digifarmer/services/home_service.dart';
// import 'package:digifarmer/static/color.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import '../../services/auth_service.dart';
// import '../../static/static_values.dart';
// import '../wigets/shopping_cart_item.dart';
//
// class ShoppingCart extends StatefulWidget {
//   const ShoppingCart({Key? key}) : super(key: key);
//
//   @override
//   State<ShoppingCart> createState() => _ShoppingCartState();
// }
//
// int currentCount = 1;
//
// Map<String, dynamic> _cartData = {};
// bool _isLoading = true;
//
//
//
//
//
// showAlertDialog(BuildContext context){
//   AlertDialog alert=AlertDialog(
//     content: Row(
//       children: [
//         CircularProgressIndicator(color: CustomColors.barColor,),
//         Container(margin: EdgeInsets.only(left: 5),child:Text("Loading" )),
//       ],),
//   );
//   showDialog(barrierDismissible: false,
//     context:context,
//     builder:(BuildContext context){
//       return alert;
//     },
//   );
// }
//
//
//
// class _ShoppingCartState extends State<ShoppingCart> {
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     // StaticValues.successSnackBar(context, totalGrandAmount.toString());
//
//     return  Scaffold(
//       appBar: AppBar(
//         backgroundColor: CustomColors.barColor,
//         title:  const Text("My Cart"),
//
//       ),
//       body:
//       // FutureBuilder<List<CartData>>(
//       //   future: HomeService.getCartItems(),
//       //   builder: (context, snapshot) {
//       //     if (snapshot.hasData) {
//       //
//       //         print(snapshot.data!);
//       //       // snapshot.data![index].addressName.toString()
//       //       return SizedBox(
//       //         child: ListView.builder(
//       //           scrollDirection: Axis.vertical,
//       //           shrinkWrap: true,
//       //           itemCount: snapshot.data!.length,
//       //           itemBuilder: (context, index) {
//       //
//       //
//       //             return
//       //               Column(
//       //                 children: [
//       //                   SizedBox(height: 10,),
//       //
//       //                   ShoppingCartItem(
//       //                     image: StaticValues.mainApi+"/storage/seller_products/"+snapshot.data![index].image!,
//       //                     title: snapshot.data![index].name!?? "",
//       //                     description: "",
//       //                     totalCourt: 100,
//       //                     amount: snapshot.data![index].price!,
//       //
//       //                     onDelete: () async {
//       //
//       //                       // farm-equipments
//       //                     //  animal-feeds
//       //                       // rent
//       //
//       //
//       //
//       //
//       //
//       //                               if(snapshot.data![index].type == "farm-equipments"){
//       //                                // return await onDeleteCartItem(snapshot, index, context, "user/seller-product/cart-item/delete/");
//       //                                 return await onDeleteCartItem(context, "user/seller-product/cart-item/delete", snapshot.data![index].id.toString());
//       //                               }else if(snapshot.data![index].type == "animal-feeds"){
//       //                                 // return   await onDeleteCartItem(snapshot, index, context, "user/animal-feed/cart-item/delete/");
//       //                               }else if(snapshot.data![index].type == "rent"){
//       //                                 // return await onDeleteCartItem(snapshot, index, context, "user/rent-service/cart-item/delete/");
//       //                               }
//       //
//       //                     //
//       //
//       //                     //
//       //
//       //
//       //                     // /user/seller-product/cart-item/delete/{id}
//       //                   }, type: "",
//       //                     onIncrease: () async {
//       //
//       //                       // if(snapshot.data![index].type == "farm-equipments"){
//       //                       //   return await onAddCartItem(snapshot, index, context, "user/seller-product/cart/add-qty/");
//       //                       // }else if(snapshot.data![index].type == "animal-feeds"){
//       //                       //   return   await onAddCartItem(snapshot, index, context, "user/animal-feed/cart/add-qty/");
//       //                       // }else if(snapshot.data![index].type == "rent"){
//       //                       //   return await onAddCartItem(snapshot, index, context, "user/rent-service/cart/add-qty");
//       //                       // }
//       //
//       //                     }, onDecrease: () async {
//       //                       // if(snapshot.data![index].type == "farm-equipments"){
//       //                       //   return await onSubCartItem(snapshot, index, context, "user/seller-product/cart/reduce-qty/");
//       //                       // }else if(snapshot.data![index].type == "animal-feeds"){
//       //                       //   return   await onSubCartItem(snapshot, index, context, "user/animal-feed/cart/add-qty/");
//       //                       // }else if(snapshot.data![index].type == "rent"){
//       //                       //   return await onSubCartItem(snapshot, index, context, "user/rent-service/cart/reduce-qty/");
//       //                       // }
//       //                     },
//       //                   ),
//       //                   const Divider()
//       //                 ],
//       //               );
//       //
//       //           },
//       //         ),
//       //       );
//       //     } else if (snapshot.hasError) {
//       //       return Center(child: Column(
//       //         mainAxisAlignment: MainAxisAlignment.center,
//       //         children: [
//       //           Icon(Icons.remove_shopping_cart_sharp,size: 50,color: CustomColors.gary,),
//       //           Row(
//       //             mainAxisAlignment: MainAxisAlignment.center,
//       //             children: [
//       //               Text("Your Cart looks to be Empty",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.grey),),
//       //               Icon(Icons.mood_bad,color: Colors.grey,)
//       //             ],
//       //           ),
//       //         ],
//       //       ));
//       //     }
//       //     return const Center(child: Padding(
//       //       padding: EdgeInsets.all(8.0),
//       //       child: CircularProgressIndicator(color: CustomColors.barColor,),
//       //     ));
//       //
//       //   },
//       // ),
//       // );
//
//
//
//   }
//
//   // Future<void> onDeleteCartItem( BuildContext context,String api,String idDelete) async {
//   //           // String? id = snapshot.data![index].data?.items![index].id.toString();
//   //
//   //   String? id = idDelete;
//   //
//   //
//   //   showAlertDialog(context);
//   //
//   //   // user/seller-product/cart-item/delete
//   //   // http.Response response = await HomeService.deleteCartItem(id!);
//   //
//   //   Navigator.pop(context);
//   //   Map responseMap = jsonDecode(response.body);
//   //
//   //   if (response.statusCode == 200) {
//   //     if (responseMap['success'] == false) {
//   //       StaticValues.errorSnackBar(context, responseMap['message']);
//   //     }
//   //
//   //
//   //     if (responseMap['success'] == true) {
//   //
//   //       StaticValues.successSnackBar(context, responseMap['message']);
//   //
//   //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const ShoppingCart() ,)).then(
//   //               (value) =>
//   //               setState(() {
//   //
//   //               })
//   //       );
//   //     }
//   //
//   //   } else {
//   //     StaticValues.errorSnackBar(context, responseMap['message']);
//   //     // return  Get.back();
//   //   }
//   // }
//
//   // Future<void> onAddCartItem(AsyncSnapshot<List<Cart>> snapshot, int index, BuildContext context,String api) async {
//   //   // String? id = snapshot.data![index].data?.items![index].id.toString();
//   //
//   //   String? id = snapshot.data![index].id.toString();
//   //
//   //
//   //   showAlertDialog(context);
//   //
//   //
//   //   http.Response response = await HomeService.increaseCartItem("user/seller-product/cart/add-qty/${id}");
//   //
//   //   Navigator.pop(context);
//   //   Map responseMap = jsonDecode(response.body);
//   //
//   //   if (response.statusCode == 200) {
//   //     if (responseMap['success'] == false) {
//   //       StaticValues.errorSnackBar(context, responseMap['message']);
//   //     }
//   //
//   //
//   //     if (responseMap['success'] == true) {
//   //
//   //       StaticValues.successSnackBar(context, responseMap['message']);
//   //
//   //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const ShoppingCart() ,)).then(
//   //               (value) =>
//   //               setState(() {
//   //
//   //               })
//   //       );
//   //     }
//   //
//   //   } else {
//   //     StaticValues.errorSnackBar(context, responseMap['message']);
//   //     // return  Get.back();
//   //   }
//   // }
//   //
//
//
//
//   // Future<void> onSubCartItem(AsyncSnapshot<List<Cart>> snapshot, int index, BuildContext context,String api) async {
//   //   // String? id = snapshot.data![index].data?.items![index].id.toString();
//   //
//   //   String? id = snapshot.data![index].id.toString();
//   //
//   //
//   //   showAlertDialog(context);
//   //
//   //
//   //   http.Response response = await HomeService.decreaseCartItem("user/seller-product/cart/reduce-qty/${id}");
//   //
//   //   Navigator.pop(context);
//   //   Map responseMap = jsonDecode(response.body);
//   //
//   //   if (response.statusCode == 200) {
//   //     if (responseMap['success'] == false) {
//   //       StaticValues.errorSnackBar(context, responseMap['message']);
//   //     }
//   //
//   //
//   //     if (responseMap['success'] == true) {
//   //
//   //       StaticValues.successSnackBar(context, responseMap['message']);
//   //
//   //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const ShoppingCart() ,)).then(
//   //               (value) =>
//   //               setState(() {
//   //
//   //               })
//   //       );
//   //     }
//   //
//   //   } else {
//   //     StaticValues.errorSnackBar(context, responseMap['message']);
//   //     // return  Get.back();
//   //   }
//   // }
// }
