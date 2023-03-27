
 import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/cropsOnSale.dart';
import '../services/auth_service.dart';
import 'package:http/http.dart' as http;



 final String bearerToken = AuthService.token;




class CropOnSaleProvider with ChangeNotifier{



 Future<List<CropsOnSale>> getCropOnSale() async {


  final response = await http.get(
   Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/market/crops_on_sales"),
   headers: {
    'Authorization': 'Bearer $bearerToken',
   },
  );




  if (response.statusCode == 200) {


// var result = json.decode(response.body);

   final result = json.decode(response.body);

   List list = result['data']["crops-on-sale"];


   // notifyListeners();

   return list.map((model) => CropsOnSale.fromJson(model)).toList();




  }else {
   throw Exception('Failed to load data');
  }





 }


 Future<List<CropsOnSale>> getSearchedCropOnSale(String min,String max) async {


  final response = await http.get(
   Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/market/crop_on_sale/price_filter?min_price=${min}&max_price=${max}"),
   headers: {
    'Authorization': 'Bearer $bearerToken',
   },
  );




  if (response.statusCode == 200) {


// var result = json.decode(response.body);

   final result = json.decode(response.body);

   List list = result['data']["crops-on-sale"];


   // notifyListeners();

   return list.map((model) => CropsOnSale.fromJson(model)).toList();




  }else {
   throw Exception('Failed to load data');
  }





 }

 Future<List<CropsOnSale>> getSearchedCropOnSaleByLocation(String id) async {

  try {
   final response = await http.get(
    Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/region/${id}/districts"),
    headers: {
     'Authorization': 'Bearer $bearerToken',
    },
   );

   if (response.statusCode == 200) {
    final result = json.decode(response.body);
    List list = result['data']["crops-on-sale"];
    return list.map((model) => CropsOnSale.fromJson(model)).toList();
   } else {
    throw Exception('Failed to load data');
   }
  } catch (error) {
   print('Error occurred while fetching data: $error');
   throw Exception('Failed to load data');
  }
 }
}