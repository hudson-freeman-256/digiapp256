
import 'dart:convert';

import '../static/static_values.dart';
import 'auth_service.dart';
import 'package:http/http.dart' as http;

class PriceRangeService{

  static final String bearerToken = AuthService.token;


  static Future<List<dynamic>> priceRange(String urlTo,String para) async{


    try{




      var url = Uri.parse(urlTo);

      http.Response response  =  await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $bearerToken',
            'Content-Type': 'application/json;charset=UTF-8',
            'X-Requested-With': 'XMLHttpRequest',
          },

      );


      print(json.decode(response.body));


   return json.decode(response.body)['data'][para];



    }catch(e){
      print('Error: $e');
      rethrow;
    }






  }


  // Future<List<dynamic>> fetchProducts() async {
  //
  //
  //   final response = await http.get(Uri.parse('https://example.com/products'));
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body)['data']['seller-products'];
  //   } else {
  //     throw Exception('Failed to load products');
  //   }
  // }

}