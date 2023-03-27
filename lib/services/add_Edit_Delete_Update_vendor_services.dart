
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digifarmer/models/UserRent.dart';
import 'package:digifarmer/models/agronomist.dart';
import 'package:digifarmer/models/farmeq.dart';
import 'package:digifarmer/models/insuarance.dart';
import 'package:digifarmer/models/training.dart';
import 'package:digifarmer/models/veterianry.dart';

import '../models/UserAnimalFeed.dart';
import '../models/UserVeterinary.dart';
import '../models/animal_feeds.dart';
import '../models/rent.dart';
import '../static/static_values.dart';
import 'auth_service.dart';
import 'package:http/http.dart' as http;

class AddVendorService{


  static final String bearerToken = AuthService.token;


  static Future<http.Response> addAnimalFeeds(String stock_amount,String name,String price,String weight,String description,String selectedSubCategory,String selectedUnit,String selectedAddressId,String? imagePath) async {

    Map<String,String> data = {
      'name': name,
      'stock_amount':stock_amount,
      'animal_feed_category_id': selectedSubCategory,
      'price': price,
      'description': description,
      'weight': weight,
      'address_id': selectedAddressId,
      'weight_unit':selectedUnit,
      'image':imagePath!
    };

    var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/animal-feeds");

    Map<String, String> headers = {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json;charset=UTF-8',
      'X-Requested-With': 'XMLHttpRequest',
    };

    try {
      var request = http.MultipartRequest('POST', url)
        ..fields.addAll(data)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', imagePath));
      var response = await request.send();

      http.Response response1 = await http.Response.fromStream(response);


      if (response.statusCode == 201) {
        return response1;
      } else {
        return response1;
      }
    } catch (e) {
      // Handle errors here
      print("Error: $e");
      rethrow;
    }
  }


  static Future<http.Response> addAgronomist(String name, String expertise, String charge, String description, String availability, String crops, String? imagePath) async {
    try {
      Map<String, String> data = {
        'name': name,
        'expertise': expertise,
        'charge': charge,
        'description': description,
        'availability': availability,
        'crops': crops,
        'image': imagePath!
      };

      var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/agronomist_vendor_services");

      Map<String, String> headers = {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json;charset=UTF-8',
        'X-Requested-With': 'XMLHttpRequest',
      };
      var request = http.MultipartRequest('POST', url)
        ..fields.addAll(data)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', imagePath));
      var response = await request.send();

      http.Response response1 = await http.Response.fromStream(response);
      print("Result: ${response1.body}");

      if (response.statusCode == 201) {
        return response1;
      } else {
        return response1;
      }
    } catch (error) {
      throw error;
    }
  }



  static Future<http.Response> addVeterinary(String name, String expertise, String charge, String description, String availability, String crops, String? imagePath) async {
    try {
      Map<String, String> data = {
        'name': name,
        'expertise': expertise,
        'charge': charge,
        'description': description,
        'availability': availability,
        'animal_categories': crops,
        'image': imagePath!
      };

      var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/veterinaries");

      Map<String, String> headers = {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json;charset=UTF-8',
        'X-Requested-With': 'XMLHttpRequest',
      };
      var request = http.MultipartRequest('POST', url)
        ..fields.addAll(data)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', imagePath));
      var response = await request.send();

      http.Response response1 = await http.Response.fromStream(response);
      print("Result: ${response1.body}");

      if (response.statusCode == 201) {
        return response1;
      } else {
        return response1;
      }
    } catch (error) {
      throw error;
    }
  }

  static Future<http.Response> addFarmEquipment(String price,String stock_amount,String name,String description,String seller_product_category_id,String address_id,String? imagePath) async {


  try{


    Map<String,String> data = {

      'name': name,
      'price': price,
      'description': description,
      "stock_amount": stock_amount,
      'seller_product_category_id': seller_product_category_id,
      'address_id':address_id,
      'image':imagePath!
    };



    var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/farm_equipments");

    Map<String, String> headers = {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json;charset=UTF-8',
      'X-Requested-With': 'XMLHttpRequest',
    };
    var request = http.MultipartRequest('POST', url)
      ..fields.addAll(data)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', imagePath));
    var response = await request.send();

    http.Response response1 = await http.Response.fromStream(response);
    print("Result: ${response1.body}");

    if (response.statusCode == 201) {
      return response1;
    } else {

      return response1;
    }
  }catch(e){
    // Handle errors here
    print("Error: $e");
    rethrow;
  }




  }


  static Future<http.Response> addTraining(String name,String charge,String access,String description,String startingDate,String endingDate,String startingTime,String endingTime,String? imagePath,String zoom_link,String address_id) async {


    try{
      Map<String,String> data = {
        'name': name,
        'charge': charge,
        'access': access,
        'description': description,
        'starting_date': startingDate,
        'ending_date': endingDate,
        'starting_time':startingTime,
        'ending_time':endingTime,
        'zoom_details':zoom_link,
        'address_id':address_id,
        'image':imagePath!
      };

      // var body = json.encode(data);






      var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/training-vendor-services");

      Map<String, String> headers = {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json;charset=UTF-8',
        'X-Requested-With': 'XMLHttpRequest',
      };
      var request = http.MultipartRequest('POST', url)
        ..fields.addAll(data)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', imagePath));
      var response = await request.send();

      http.Response response1 = await http.Response.fromStream(response);
      print("Result: ${response1.body}");

      if (response.statusCode == 201) {
        return response1;
      } else {

        return response1;
      }


    }catch(e){
      print("Error: $e");
      rethrow;
    }





  }


  static Future<http.Response> addSchedule(String agronomistId,String timeInterval,String date,String startingTime,String endingTime) async {

    try{


      Map<String,String> data = {
        'agronomist_id': agronomistId,
        'date': date,
        'starting_time':startingTime,
        'ending_time':endingTime,
        'time_interval':timeInterval
      };

      // var body = json.encode(data);






      var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/agronomist_shedules");


      var body = json.encode(data);


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
      print("Error: $e");
      rethrow;
    }



  }


  static Future<http.Response> addInsurance(String name, String terms, String description, String? imagePath, String addressId) async {
    try {
      Map<String, String> data = {
        'name': name,
        'terms': terms,
        'description': description,
        'image': imagePath!,
        'address_id': addressId
      };

      var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/insuarance_vendor_services");

      Map<String, String> headers = {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json;charset=UTF-8',
        'X-Requested-With': 'XMLHttpRequest',
      };

      var request = http.MultipartRequest('POST', url)
        ..fields.addAll(data)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', imagePath));

      var response = await request.send();
      http.Response response1 = await http.Response.fromStream(response);
      print("Result: ${response1.body}");

      if (response.statusCode == 201) {
        return response1;
      } else {
        return response1;
      }
    } catch (e) {
      print("Error: $e");
      throw e;
    }
  }


  static Future<http.Response> addRent(String charge_frequency,String name,String address_id,String charge,String quantity,String description,String selectedSubCategory,String? imagePath) async{


    try{
      Map<String,String> data = {
        'charge_frequency':"1 Day",
        'name': name,
        'address_id':address_id,
        'rent_vendor_sub_category_id': selectedSubCategory,
        'charge': charge,
        'description': description,
        'quantity': quantity,
        'image':imagePath!,
      };


      var body = json.encode(data);
      var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/rent_vendor_services");

      Map<String, String> headers = {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json;charset=UTF-8',
        'X-Requested-With': 'XMLHttpRequest',
      };

      var request = http.MultipartRequest('POST', url)
        ..fields.addAll(data)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', imagePath));
      var response = await request.send();

      http.Response response1 = await http.Response.fromStream(response);
      print("Result: ${response1.body}");

      if (response.statusCode == 201) {
        return response1;
      } else {
        return response1;
      }
    }catch(e){
      print("Error: $e");
      rethrow;
    }






  }

  static Future<List<AnimalFeed>> getUserAnimalFeeds() async {


    try{


      final response = await http.get(
        Uri.parse(StaticValues.mainApiUrl+'vendors/vendor/animal-feeds'),
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      );




      if (response.statusCode == 200) {


        // var result = json.decode(response.body);

        final result = json.decode(response.body);

        List list = result['data']["animal-feeds"];



        return list.map((model) => AnimalFeed.fromJson(model)).toList();



      }else {
        throw Exception('Failed to load data');
      }


    }catch(e){
      print("Error: $e");
      rethrow;
    }




  }

  static Future<List<TrainingVendor>> getUserTraining() async {


    try{
      final response = await http.get(
        Uri.parse(StaticValues.mainApiUrl+'vendors/vendor/training-vendor-services'),
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      );




      if (response.statusCode == 200) {


        // var result = json.decode(response.body);

        final result = json.decode(response.body);

        List list = result['data']["training-vendor-services"];



        return list.map((model) => TrainingVendor.fromJson(model)).toList();



      }else {
        throw Exception('Failed to load data');
      }



    }catch(e){
      print("Error: $e");
      rethrow;
    }





  }


  static Future<List<Insuarance>> getUserInsurance() async {


    try{
      final response = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/vendor/insuarance_vendor_services"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      );



      print(response.body);


      if (response.statusCode == 200) {


        // var result = json.decode(response.body);

        final result = json.decode(response.body);

        List list = result['data']['insurance-services'];



        return list.map((model) => Insuarance.fromJson(model)).toList();



      }else {
        throw Exception('Failed to load data');
      }

    }catch(e){
      print("Error: $e");
      rethrow;
    }







  }

  static Future<List<VetServices >> getUserVeterinaries() async {


    try{


      final response = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/user/vet_services"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      );



      print(response.body);


      if (response.statusCode == 200) {


        // var result = json.decode(response.body);

        final result = json.decode(response.body);

        List list = result['data']['vet-services'];



        return list.map((model) =>  VetServices .fromJson(model)).toList();



      }else {
        throw Exception('Failed to load data');
      }


    }catch(e){
      print("Error: $e");
      rethrow;
    }




  }



  static Future<List<Rent>> getUserRent() async {

    // https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/vendor/rent_vendor_services

    try{
      final response = await http.get(
        Uri.parse('https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/vendor/rent_vendor_services'),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Content-Type": "application/json"
        },
      );




      if (response.statusCode == 200) {


        // var result = json.decode(response.body);

        final result = json.decode(response.body);

        List list = result['data']["rent-services"];



        return list.map((model) => Rent.fromJson(model)).toList();



      }else {
        throw Exception('Failed to load data');
      }

    }catch(e){
      print("Error: $e");
      rethrow;
    }






  }


  static Future<List<Agronomist>> getUserAgronomist() async {

    // https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/vendor/rent_vendor_services

    try{


      final response = await http.get(
        Uri.parse('https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/user/agronomist_services'),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Content-Type": "application/json"
        },
      );




      if (response.statusCode == 200) {


        // var result = json.decode(response.body);

        final result = json.decode(response.body);

        List list = result['data']["agro-services"];



        return list.map((model) => Agronomist.fromJson(model)).toList();



      }else {
        throw Exception('Failed to load data');
      }
    }catch(e){
      print("Error: $e");
      rethrow;
    }






  }

  static Future<List<FarmEquipment>> getUserFarmEquipment() async {

    // https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/vendor/rent_vendor_services

    try{
      final response = await http.get(
        Uri.parse('https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/vendor/farm_equipments'),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Content-Type": "application/json"
        },
      );

      print(response.body);


      if (response.statusCode == 200) {


        // var result = json.decode(response.body);

        final result = json.decode(response.body);

        List list = result['data']["farm-equipments"];



        return list.map((model) => FarmEquipment.fromJson(model)).toList();



      }else {
        throw Exception('Failed to load data');
      }



    }catch(e){
      print("Error: $e");
      rethrow;
    }





  }



  // static Future<Map<String, dynamic>> fetchVendorsById(String api,
  //     {required Map<String, String> headers,
  //       Duration timeout = const Duration(seconds: 2)}) async {
  //   try {
  //     final response = await http.get(Uri.parse(StaticValues.mainApiUrl + api),
  //         headers:  {
  //           'Authorization': 'Bearer $bearerToken',
  //           "Content-Type": "application/json"
  //         }).timeout(timeout);
  //
  //     if (response.statusCode == 200) {
  //       // If the call to the server was successful, parse the JSON
  //       return json.decode(response.body);
  //     } else {
  //       // If that call was not successful, throw an error.
  //       throw HttpException('Failed to load data: ${response.statusCode}');
  //     }
  //   } on SocketException {
  //     throw SocketException('Network error');
  //   } on HttpException catch (e) {
  //     throw HttpException('Http error: ${e.message}');
  //   } on TimeoutException {
  //     throw TimeoutException('Request timed out');
  //   } catch (e) {
  //     throw Exception('Unknown error: $e');
  //   }
  // }

  static Future<Map<String, dynamic>> fetchVendorsById(String api) async {

    print(StaticValues.mainApiUrl+api);

    try{
      final response = await http.get(Uri.parse(StaticValues.mainApiUrl+api),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Content-Type": "application/json"
        },
      );

      print( response.body);
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        return json.decode(response.body);
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load data');
      }
    }catch(e){
      print("Error: $e");
      rethrow;
    }


  }

  static Future<http.Response> buy(String amount, String pay_type, String payment_id,) async {
    try {
      Map<String, dynamic> data = {
        'amount': int.parse(amount),
        'pay_type': pay_type,
        'payment_id': payment_id,
      };

      var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/collect");

      var body = json.encode(data);


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
    } catch (error) {
      throw error;
    }
  }










}