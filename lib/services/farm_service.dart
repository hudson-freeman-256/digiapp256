

 import 'dart:convert';

import 'package:digifarmer/models/Farm.dart';
import 'package:digifarmer/models/animal.dart';
import 'package:digifarmer/models/cropharvest.dart';
import 'package:digifarmer/models/harvest.dart';
import 'package:digifarmer/models/task.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../models/Plot.dart';
import '../models/expense.dart';
import '../static/static_values.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class FarmService{

 static String? totalHarvest;
 static int? totalExpense;

 static final String bearerToken = AuthService.token;

static Future<http.Response> addFarm(String name ,String fieldArea,String addressId) async{


 try{
   Map data = {
     "name":name,
     "field_area": fieldArea,
     "address_id":addressId,

   };

   var body = json.encode(data);
   var url = Uri.parse(StaticValues.mainApiUrl+'farms');

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

 static Future<http.Response> addPlot(String name ,int crop_id,int farm_id,int size,String size_unit) async{


  try{

    Map data = {
      "name":name,
      "crop_id": crop_id,
      "farm_id":farm_id,
      "size":size,
      "size_unit":size_unit

    };

    var body = json.encode(data);
    var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm/plots");

    http.Response response  =  await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json;charset=UTF-8',
        },
        body: body
    );



    return response;
  }catch(e){
    print('Error: $e');
    throw e;
  }




 }

 static Future<http.Response> addExpense(int amount ,int plot_id,int category_id) async{


  try{
    Map data = {
      "amount":amount,
      "plot_id": plot_id,
      "expense_category_id":category_id,

    };

    var body = json.encode(data);


    var url = Uri.parse(StaticValues.mainApiUrl+'farm/plot/expenses');

    http.Response response  =  await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json;charset=UTF-8',
        },
        body: body
    );




    return response;

  }catch(e){
    print('Error: $e');
    throw e;
  }



 }


 static Future<http.Response> addAnimal(int amount ,int plot_id,int category_id) async{


  try{
    Map data = {
      "total":amount,
      "plot_id": plot_id,
      "animal_category_id":category_id,

    };

    var body = json.encode(data);
    var url = Uri.parse(StaticValues.mainApiUrl+'farm/plot/animals');

    http.Response response  =  await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json;charset=UTF-8',
        },
        body: body
    );



    return response;
  }catch(e){
    print('Error: $e');
    throw e;
  }




 }

 static Future<http.Response> addTask(String name ,String date,int plot_id) async{


  try{
    Map data = {
      "name":name,
      "task_date": date,
      "plot_id":plot_id,
    };

    var body = json.encode(data);
    var url = Uri.parse(StaticValues.mainApiUrl+'farm/plot/tasks');

    http.Response response  =  await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json;charset=UTF-8',
        },
        body: body
    );

    return response;
  }catch(e){
    print('Error: $e');
    throw e;
  }




 }

 static Future<http.Response> addHarvest(int quantity ,int plot_id) async{

    try{
      Map data = {
        "quantity":quantity,
        "plot_id":plot_id,
      };

      var body = json.encode(data);
      var url = Uri.parse(StaticValues.mainApiUrl+"farm/plot/crop_harvests");

      http.Response response  =  await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $bearerToken',
            'Content-Type': 'application/json;charset=UTF-8',
          },
          body: body
      );

      return response;

    }catch(e){
      print('Error: $e');
      throw e;

    }



 }

 static Future<List<Farm>> getFarms() async {

  try{
    final response = await http.get(
      Uri.parse(StaticValues.mainApiUrl+"farmer/farms"),
      headers: {
        'Authorization': 'Bearer $bearerToken',
      },
    );


    if (response.statusCode == 200) {


      // var result = json.decode(response.body);

      final result = json.decode(response.body);
      Iterable list = result['data']['farms'];


      return list.map((model) => Farm.fromJson(model)).toList();


    } else {
      throw Exception('Failed to load data');
    }
  }catch(e){
    print('Error: $e');
    throw e;
  }


 }

 static Future<List<Expense>> getExpense(String id) async {

  try{
    // https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farmer/plots/expenses
    final response = await http.get(
      Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm/plot/$id/expenses"),
      headers: {
        'Authorization': 'Bearer $bearerToken',
      },
    );



    if (response.statusCode == 200) {



      // var result = json.decode(response.body);

      final result = json.decode(response.body);



      totalExpense  = result['data']["total-expense-cost"];

      Iterable list = result['data']['expenses'];




      // print(list);
      return list.map((model) => Expense.fromJson(model)).toList();


    } else {
      throw Exception('Failed to load data');
    }
  }catch(e){
    print('Error: $e');
    throw e;
  }


 }

 static Future<List<Animal>> getAnimal(String id) async {

  try{
    final response = await http.get(
      Uri.parse(StaticValues.mainApiUrl+"farm/plot/$id/animals"),
      headers: {
        'Authorization': 'Bearer $bearerToken',
      },
    );


    if (response.statusCode == 200) {



      // var result = json.decode(response.body);

      final result = json.decode(response.body);
      List list = result['data']['animals'];

      return list.map((model) => Animal.fromJson(model)).toList();


    } else {
      throw Exception('Failed to load data');
    }
  }catch(e){
    print('Error: $e');
    throw e;
  }

 }

 static Future<List<Plot>> getPlots(String id) async {



  try{

    final response = await http.get(
      Uri.parse(StaticValues.mainApiUrl+"farm/${id}/plots"),
      headers: {
        'Authorization': 'Bearer $bearerToken',
      },
    );

    final result = json.decode(response.body);



    if (response.statusCode == 200) {



      // var result = json.decode(response.body);

      final result = json.decode(response.body);



      List list = result["data"]["plots"];


      return list.map((model) => Plot.fromJson(model)).toList();


    } else {
      throw Exception('Failed to load data');
    }
  }catch(e){
    print('Error: $e');
    throw e;
  }


 }

 static Future<List<Task>> getTask(String id) async {

         try{

           final response = await http.get(
             Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/farm/plot/$id/tasks"),
             headers: {
               'Authorization': 'Bearer $bearerToken',
             },
           );
           final result = json.decode(response.body);



           if (response.statusCode == 200) {


             Iterable list = result['data']['tasks'];

             return list.map((model) => Task.fromJson(model)).toList();


           } else {
             throw Exception('Failed to load data');
           }
         }catch(e){
           print('Error: $e');
           throw e;
         }
   // /farm/plot/{id}/tasks

 }

 static Future<List<CropHarvests>> getHarvest(String id) async {

  try{
    final response = await http.get(
      Uri.parse(StaticValues.mainApiUrl+"farm/plot/$id/crop_harvests"),
      headers: {
        'Authorization': 'Bearer $bearerToken',
      },
    );



    if (response.statusCode == 200) {


      // var result = json.decode(response.body);

      final result = json.decode(response.body);
      Iterable list = result['data']['crop_harvests'];

      totalHarvest = result['data']["total-harvest-amount"];



      return list.map((model) => CropHarvests.fromJson(model)).toList();


    } else {
      throw Exception('Failed to load data');
    }
  }catch(e){
    print('Error: $e');
    throw e;
  }

 }

  static Future<http.Response> deleteFarm(String api) async {

  try{
    final String bearerToken = AuthService.token;

    var res = await http.delete(
        Uri.parse(StaticValues.mainApiUrl+api),
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

  static Future<http.Response> updatedFarm(Map data,String api) async {

  try{

    final String bearerToken = AuthService.token;

    print(data);

    var res = await http.put(
        Uri.parse(StaticValues.mainApiUrl+api),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"},
        body: data

    );
    var resBody = json.decode(res.body);




    return res;
  }catch(e){
    print('Error: $e');
    throw e;
  }

  }

 }