import 'dart:convert';

import 'package:digifarmer/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digifarmer/static/static_values.dart';

import '../models/Faqs.dart';

class ProfileService{



static var apiEndpoint = Uri.parse(StaticValues.mainApiUrl+"/support/faqs/");
 static final String bearerToken = AuthService.token;


static Future<Faqs> getFaqs() async {


  final response = await http.get(
    apiEndpoint,
    headers: {
      'Authorization': 'Bearer $bearerToken',
    },
  );

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.

    var data2 = json.decode(response.body);


    var data =   data2['data'];

    return Faqs.fromJson(data);

  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to get Faqs');
  }
}




}