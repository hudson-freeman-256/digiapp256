import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digifarmer/models/crop_on_sale_user.dart';
import 'package:digifarmer/models/cropsOnSale.dart';
import 'package:digifarmer/models/market_crop.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../models/VendorCategories.dart';
import '../models/crop_on_sale_market.dart';
import '../models/save_product.dart';
import '../models/savedCrops.dart';
import '../static/static_values.dart';
import 'auth_service.dart';


class ServiceMarket{


  static final String bearerToken = AuthService.token;


  static Future<List<CropsOnSale>> getCropOnSale() async {


    try{
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



        return list.map((model) => CropsOnSale.fromJson(model)).toList();



      }else {
        throw Exception('Failed to load data');
      }


    }catch(e){
      print('Error: $e');
      throw e;
    }





  }


  static Future<List<CropsOnSaleUser>> getCropOnSaleForUser() async {


    try{
      final response = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/market/farmer/crops_on_sale"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      );


      if (response.statusCode == 200) {


        // var result = json.decode(response.body);

        final result = json.decode(response.body);

        List list = result['data']["crops-on-sale"];



        return list.map((model) => CropsOnSaleUser.fromJson(model)).toList();



      }else {
        throw Exception('Failed to load data');
      }

    }catch(e){
      print('Error: $e');
      throw e;
    }







  }


    static Future<http.Response> addCropOnSale(String quantity ,String sellingPrice,String addressId,String description,String cropId) async{



    try{
      Map data = {
        "quantity":quantity,
        "selling_price": sellingPrice,
        "address_id":addressId,
        "description":description,
        "crop_id":cropId

      };

      var body = json.encode(data);
      var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/market/crops_on_sales");

      http.Response response  =  await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $bearerToken',
            'Content-Type': 'application/json;charset=UTF-8',
            'X-Requested-With': 'XMLHttpRequest',
          },
          body: body
      );


      return response;
    }catch(e){
      print('Error: $e');
      throw e;
    }





  }


  static Future<Map<String, dynamic>> fetchCropOnSaleById(String api) async {

    try{
      final response = await http.get(Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/market/crops_on_sales/"+api),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Content-Type": "application/json"
        },
      );

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        return json.decode(response.body);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load data');
      }
    }catch(e){
      print('Error: $e');
      throw e;
    }


  }



  static Future<List<VendorCategories>> getMarketCategories() async {

    File file = await saveData("marketCategories.json");
    var jsonData;

    if(file.existsSync()){
      jsonData =  file.readAsStringSync();
    }

    Future<List<VendorCategories>> updateData() async {

      Timer.periodic(Duration(minutes: 2), (timer) {
        updateData();
      });

      final response = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/categories"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      );

      if (response.statusCode == 200) {
        jsonData = response.body;
        file.writeAsString(jsonData);
      } else {
        throw Exception('Failed to load data');
      }
      final result = json.decode(jsonData);
      Iterable list = result['data'];
      return list.map((model) => VendorCategories.fromJson(model)).toList();
    }

    if (jsonData != null) {
      final result = json.decode(jsonData);
      Iterable list = result['data'];
      return list.map((model) => VendorCategories.fromJson(model)).toList();
    } else {
      return updateData();
    }


  }



  static Future<List<MarketCrop>> getCropsCategoryById(String api) async {

    // https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/vendor/rent_vendor_services

    try{
      final response = await http.get(
        Uri.parse(api),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Content-Type": "application/json"
        },
      );




      if (response.statusCode == 200) {


        // var result = json.decode(response.body);

        final result = json.decode(response.body);

        List list = result['data'];



        return list.map((model) => MarketCrop.fromJson(model)).toList();



      }else {
        throw Exception('Failed to load data');
      }

    }catch(e){
      print('Error: $e');
      throw e;
    }






  }


  static Future<List<CropOnSaleMarket>> getCropsById(String id) async {

    try{

      final response = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/market/crop_category/${id}/crops_on_sale"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // "Content-Type", "application/json; charset=UTF-8"

      final result = json.decode(response.body);


      if (response.statusCode == 200) {



        final result = json.decode(response.body);



        List list = result['data']['crops-on-sale'];



        return list.map((model) => CropOnSaleMarket.fromJson(model)).toList();



      }else {
        throw Exception('Failed to load data');
      }
    }catch(e){
      print('Error: $e');
      rethrow;
    }








  }




  static Future<http.Response> saveProduct(String id) async{




    try{


      Map data = {
        "crop_on_sale_id":id,

      };

      var body = json.encode(data);
      var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farmer/crops_on_sale/save");

      http.Response response  =  await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $bearerToken',
            'Content-Type': 'application/json;charset=UTF-8',
            'X-Requested-With': 'XMLHttpRequest',
          },
          body: body
      );



      return response;
    }catch(e){
      print('Error: $e');
    rethrow;}




  }

  static Future<http.Response> sendBuyerRequest(String id,price,address_id) async{



    try{


      Map data = {
        "crop_on_sale_id":id,
        'address_id':address_id,
        "buying_price":price
      };

      var body = json.encode(data);
      var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/market/crop_buy_request/${id}");

      http.Response response  =  await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $bearerToken',
            'Content-Type': 'application/json;charset=UTF-8',
            'X-Requested-With': 'XMLHttpRequest',
          },
          body: body
      );



      print(response.body);
      return response;
    }catch(e){
      print('Error: $e');
      rethrow;
    }
    }



  static Future<List<SavedCrops>> getCropOnSaleSaved() async {
    try {
      final file = await saveData("cropOnSaleSaved.json");
      DateTime lastUpdated = file.existsSync()
          ? await file.lastModified()
          : DateTime.now().subtract(Duration(minutes: 5));
      Duration difference = DateTime.now().difference(lastUpdated);
      if (difference.inMinutes >= 2) {
        final response = await http.get(
          Uri.parse(
              "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farmer/saved_crops"),
          headers: {
            'Authorization': 'Bearer $bearerToken',
          },
        );

        if (response.statusCode == 200) {
          final result = json.decode(response.body);
          List list = result['data']['saved-crops'];
          file.writeAsString(response.body);
          return list.map((model) => SavedCrops.fromJson(model)).toList();
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        var jsonData = file.readAsStringSync();
        final result = json.decode(jsonData);
        Iterable list = result['data']['saved-crops'];
        return list.map((model) => SavedCrops.fromJson(model)).toList();
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  static Future<File> saveData(String name) async {

    String fileName = name;

    var dir = await getTemporaryDirectory();

    File file = new File(dir.path+"/"+fileName);
    return file;
  }
  static Future<http.Response> deleteCropOnSaleSaved(String id) async {

    try{
      final String bearerToken = AuthService.token;

      var res = await http.delete(
          Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farmer/crops_on_sale/unsave/${id}"),
          headers: {
            'Authorization': 'Bearer $bearerToken',
            "Accept": "application/json"});
      var resBody = json.decode(res.body);

      print(resBody);


      return res;
    }catch(e){
      print('Error: $e');
      rethrow;
    }


  }



}