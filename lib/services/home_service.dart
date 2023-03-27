import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:digifarmer/models/animal_feeds.dart';
import 'package:digifarmer/models/farmeq.dart';
import 'package:digifarmer/models/veterianry.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../models/VendorCategories.dart';
import '../models/agronomist.dart';
import '../models/cart.dart';
import '../models/insuarance.dart';
import '../models/rent.dart';
import '../models/training.dart';
import '../static/static_values.dart';
import 'auth_service.dart';


class HomeService{

 static final String bearerToken = AuthService.token;


static late final String totalCartItems;




 static Future<http.Response> homeSearch(String search) async{


   var url = Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/search/home?search=$search");

   http.Response response  =  await http.get(
       url,
       headers: StaticValues.headers,

   );


   //





   return response;



 }




 static Future<List<VendorCategories>> getVendorCategories() async {

   File file = await saveData("vendorCategories.json");



   if(file.existsSync()){


    var jsonData =  file.readAsStringSync();




   final result = json.decode(jsonData);
   Iterable list = result['data'];
   return list.map((model) => VendorCategories.fromJson(model)).toList();



   }else {
     final response = await http.get(
       Uri.parse(
           "https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendor_categories"),
       headers: {
         'Authorization': 'Bearer $bearerToken',
       },
     );




     if (response.statusCode == 200) {
       // var result = json.decode(response.body);

       final result = json.decode(response.body);
       Iterable list = result['data'];


       file.writeAsString(response.body);
       return list.map((model) => VendorCategories.fromJson(model)).toList();
     } else {
       throw Exception('Failed to load data');
     }
   }

 }

static Future<File> saveData(String name) async {

  String fileName = name;

  var dir = await getTemporaryDirectory();

  File file = new File(dir.path+"/"+fileName);
  return file;
}

 static Future<List<Rent>> getRent() async {


   try{
     final response = await http.get(
       Uri.parse(StaticValues.mainApiUrl+'/vendor_categories/1/rent/'),
       headers: {
         'Authorization': 'Bearer $bearerToken',
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
     print('Error: $e');
     rethrow;
   }







 }

 static Future<List<VetServices>> getVeterinary() async {

   try{

     ///veterinaries/all
     final response = await http.get(
       Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/veterinaries/all"),
       headers: {
         'Authorization': 'Bearer $bearerToken',
       },
     );



     if (response.statusCode == 200) {


       // var result = json.decode(response.body);

       final result = json.decode(response.body);
       List list = result['data'];



       return list.map((model) => VetServices.fromJson(model)).toList();



     }else {
       throw Exception('Failed to load data');
     }
   }catch(e){
     print('Error: $e');
     rethrow;
   }






 }

 static Future<List<TrainingVendor>> getTraining() async {


   try{
     final response = await http.get(
       Uri.parse(StaticValues.mainApiUrl+'vendor_categories/2/farmer_trainings'),
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
     print('Error: $e');
     throw e;
   }






 }


 static Future<List<AnimalFeed>> getAnimalFeeds() async {

   https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/animal_feeds/all


   final response = await http.get(
     Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/animal_feeds/all"),
     headers: {
       'Authorization': 'Bearer $bearerToken',
     },
   );

   try{


     if (response.statusCode == 200) {


       // var result = json.decode(response.body);

       final result = json.decode(response.body);

       List list = result['data']["animal-feeds"];



       return list.map((model) => AnimalFeed.fromJson(model)).toList();



     }else {
       throw Exception('Failed to load data');
     }

   }catch(e){
     print('Error: $e');
     throw e;
   }







 }

 static Future<List<Agronomist>> getAgronomist() async {

   // /seller_products/all

   try{

     final response = await http.get(
       Uri.parse('https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/agronomist_vendor_services/all'),
       headers: {
         'Authorization': 'Bearer $bearerToken',
       },
     );



     if (response.statusCode == 200) {


       // var result = json.decode(response.body);

       final result = json.decode(response.body);

       List list = result['data'];


       return list.map((model) => Agronomist.fromJson(model)).toList();



     }else {
       throw Exception('Failed to load data');
     }


   }catch(e){
     print('Error: $e');
     throw e;
   }





 }



 static Future<List<FarmEquipment>> getFarmEquipment() async {

   try{

     // /seller_products/all
     final response = await http.get(
       Uri.parse('https://digifarmer.agrosahas.co/farmerapp/public/api/v1/seller_products/all'),
       headers: {
         'Authorization': 'Bearer $bearerToken',
       },
     );




     if (response.statusCode == 200) {


       // var result = json.decode(response.body);

       final result = json.decode(response.body);

       List list = result['data'];


       return list.map((model) => FarmEquipment.fromJson(model)).toList();



     }else {
       throw Exception('Failed to load data');
     }


   }catch(e){
     print('Error: $e');
     throw e;
   }




 }


 static Future<List<Insuarance>> getInsurance() async {

   try{

     // /vendors/insuarance_vendor_services/all

     final response = await http.get(
       Uri.parse('https://digifarmer.agrosahas.co/farmerapp/public/api/v1/vendors/insuarance_vendor_services/all'),
       headers: {
         'Authorization': 'Bearer $bearerToken',
       },
     );


     if (response.statusCode == 200) {


       // var result = json.decode(response.body);

       final result = json.decode(response.body);

       List list = result['data']["insurance-vendor-services"];



       return list.map((model) => Insuarance.fromJson(model)).toList();



     }else {
       throw Exception('Failed to load data');
     }

   }catch(e){
     print('Error: $e');
     rethrow;
   }





 }










 // https://digifarmer.agrosahas.co/farmerapp/public/api/v1/user/seller-product/cart/add-qty/
 static Future<List<Insuarance>> getHomeInsurance() async {
   try {
     final response = await http.get(
       Uri.parse('https://digifarmer.agrosahas.co/farmerapp/public/api/v1/home/insurance_services'),
       headers: {
         'Authorization': 'Bearer $bearerToken',
       },
     );

     if (response.statusCode == 200) {
       final result = json.decode(response.body);
       List list = result['data']["insurance-vendor-services"];




       return list.map((model) => Insuarance.fromJson(model)).toList();
     } else {
       throw Exception('Failed to load data');
     }
   } catch (e) {
     print('Error: $e');
     rethrow;
   }
 }


 static Future<List<Rent>> getHomeRent() async {
   try {


       final response = await http.get(
         Uri.parse('https://digifarmer.agrosahas.co/farmerapp/public/api/v1/home/rent_services'),
         headers: {
           'Authorization': 'Bearer $bearerToken',
         },
       );
       if (response.statusCode == 200) {
         final result = json.decode(response.body);
         List list = result['data']["rent-vendor-services"];

         return list.map((model) => Rent.fromJson(model)).toList();
       } else {
         throw Exception('Failed to load data');
       }




   } catch (e) {
     print('Error: $e');
     throw e;
   }
 }

 static Future<List<AnimalFeed>> getHomeAnimalFeeds() async {
   try {

       final response = await http.get(
         Uri.parse('https://digifarmer.agrosahas.co/farmerapp/public/api/v1/home/animal_feeds'),
         headers: {
           'Authorization': 'Bearer $bearerToken',
         },
       );

       if (response.statusCode == 200) {
         final result = json.decode(response.body);
         List list = result['data']["feeds"];


         Timer.periodic(const Duration(minutes: 2), (timer) async {
           try {
             final response = await http.get(
               Uri.parse('https://digifarmer.agrosahas.co/farmerapp/public/api/v1/home/animal_feeds'),
               headers: {
                 'Authorization': 'Bearer $bearerToken',
               },
             );
             if (response.statusCode == 200) {
               final result = json.decode(response.body);
               List list = result['data']["feeds"];

             }
           } catch (e) {
             print('Error while auto-updating file: $e');
           }
         });

         return list.map((model) => AnimalFeed.fromJson(model)).toList();
       } else {
         throw Exception('Failed to load data');
       }

   } catch (e) {
     print('Error: $e');
     rethrow;
   }
 }



}