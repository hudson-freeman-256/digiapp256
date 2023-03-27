import 'dart:convert';

import '../static/static_values.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

class ContactUsService{

  static final String bearerToken = AuthService.token;

 static createContact(
      String subject,
      String message,
      ) async {

    Map data = {
      "subject":subject,
      "message":message,
    };

    var body = json.encode(data);
    var url = Uri.parse(StaticValues.mainApiUrl+'support/contact-us');


    http.Response response  =  await http.post(
        url,
        headers: {
          'Content-Type': "application/json",
          'Authorization': 'Bearer $bearerToken',
        },
        encoding: Encoding.getByName("utf-8"),
        body: body
    );



    print(response.body);
    return response;



  }

}