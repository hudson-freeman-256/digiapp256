import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/Address.dart';
import '../models/country.dart';
import '../static/static_values.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class AddressService {

  static final String bearerToken = AuthService.token;

  static createAddress(String address,
      String districtName) async {

    // {"message":"The given data was invalid.","errors":{"district_id":["The district id field is required."],"address_name":["The address name must be a string.","The address name must be at least 10 characters."]}}


    try{
      Map data = {
        "address_name": address,
        "district_id": int.parse(districtName),

      };

      var body = json.encode(data);
      var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/user/address");


      http.Response response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $bearerToken',
            'Content-Type': 'application/json;charset=UTF-8',
            'X-Requested-With': 'XMLHttpRequest',
          },
          encoding: Encoding.getByName("utf-8"),
          body: body
      );


      print(response.body);

      return response;
    }catch(e){
      print("Error: $e");
      rethrow;
    }


  }




  static Future<List<AddressUser>> getAddress() async {

    try{
      final response = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"user/my-addresses"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      );


      if (response.statusCode == 200) {


        // var result = json.decode(response.body);

        final result = json.decode(response.body);
        Iterable list = result['data'];
        return list.map((model) => AddressUser.fromJson(model)).toList();


        return result['data'].map((e) => AddressUser.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    }catch(e){
      print("Error: $e");
      rethrow;
    }


  }

  // https://digifarmer.agrosahas.co/farmerapp/public/api/v1/user/address/5


  static Future<http.Response> deleteAddress(String id) async {

    try{
      final String bearerToken = AuthService.token;

      var res = await http.delete(
          Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/user/address/${id}"),
          headers: {
            'Authorization': 'Bearer $bearerToken',
            "Accept": "application/json"}); //if you have any auth key place here...properly..
      var resBody = json.decode(res.body);



      return res;
    }catch(e){
      print('Error: $e');
      throw e;
    }

  }





}