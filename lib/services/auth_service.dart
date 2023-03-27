import 'dart:convert';

import 'package:digifarmer/models/user.dart';
import 'package:digifarmer/static/static_values.dart';
import 'package:digifarmer/views/auth/login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class AuthService{

static String token  = "";

   static String username = '';
  static String firstName = '';
  static String lastName = '';
  static String email = "";
  static String phoneNumber = "";
  static String photo = "";
  static int is_verfiled = 0;
  static int id = 0;
  static bool userLoggedin = false;

  late SharedPreferences pref;

static Future<http.Response> sendNumber(String phone) async{

  try {
    Map data = {
      "phone":phone
    };

    var body = json.encode(data);
    var url = Uri.parse(StaticValues.mainApiUrl+'auth/send-otp');

    http.Response response  =  await http.post(
        url,
        headers: StaticValues.headers,
        body: body
    );

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("fullNumber",phone );

    return response;
  } catch (e) {
    print('Error: $e');
    throw e;
  }
}




  static Future<http.Response> checkNumber(String phone,String code) async{


  try{
    Map data = {
      "phone":phone,
      "otp":code
    };


    var body = json.encode(data);
    var url = Uri.parse(StaticValues.mainApiUrl+'auth/verify-otp');

    http.Response response  =  await http.post(
        url,
        headers: StaticValues.headers,
        body: body
    );

    return response;

  }catch(e){
    print('Error: $e');
    throw e;
  }








 }


static Future<http.Response> registerUser(
    String first_name,
    String last_name,
    String email,
    String password,
    String phone,
    ) async {
  try {
    Map data = {
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
      "password": password,
      "phone": phone,
    };

    var body = json.encode(data);

    var url = Uri.parse(StaticValues.mainApiUrl + 'auth/create-account');

    http.Response response = await http.post(
      url,
      headers: StaticValues.headers,
      body: body,
    );

    var data2 = json.decode(response.body);

    if (response.statusCode == 200) {
      var data = data2['data'];

      // handle success case here if necessary
    } else if (response.statusCode == 400) {
      // handle specific bad request error here if necessary
    } else {
      // handle other error status codes here if necessary
    }

    return response;
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to register user');
  }
}



  static Future<http.Response> editUser(
      String first_name,
      String last_name,
      String email,
      String phone,



      ) async{
    Map data = {
      "first_name":first_name,
      "last_name":last_name,
      "email":email,
      "phone":"0781398341",

    };


    print(first_name);

    print(last_name);
    print(email);
    print(phone);
    var body = json.encode(data);
    var url = Uri.parse('https://digifarmer.agrosahas.co/farmerapp/public/api/v1/user/update-details');

    http.Response response  =  await http.post(
        url,
        headers: {

          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json;charset=UTF-8',
          'X-Requested-With': 'XMLHttpRequest',

        },
        encoding: Encoding.getByName("utf-8"),
        body: body

    );



    print(response.body);
    return response;
  }





static Future<http.Response> loginUser(String phone, String password) async {
  Map data = {
    "phone": phone,
    "password": password,
  };

  var body = json.encode(data);

  var url = Uri.parse(StaticValues.mainApiUrl + 'auth/login');

  try {
    http.Response response = await http.post(
      url,
      headers: StaticValues.headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 400) {
      throw Exception('Invalid request');
    } else {
      throw Exception('Server error');
    }
  } catch (e) {
    throw Exception('Error sending request: $e');
  }
}

  static Future<void> saveUserData(data2) async {
    var data =   data2['data'];



    SharedPreferences pref = await SharedPreferences.getInstance();


    if( data != null){

      String user = jsonEncode(User.fromJson(data));
      pref.setString('userData', user);
    }
  }


static Future<void> deleteUserData() async {

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.remove('userData');

  await preferences.remove("userLogged");

  print('SharedPreferences cleared');

}



 static Future<User> getUserInfo() async {

 SharedPreferences  pref = await SharedPreferences.getInstance();

    String? userInfo =    pref.getString('userData');

    Map userMap = jsonDecode(userInfo!);

    var user1 = User.fromJson(userMap);

  return  user1;



  }

 static Future getToken() async {

    SharedPreferences  pref = await SharedPreferences.getInstance();

    String? userInfo =    pref.getString('userData');

    Map userMap = jsonDecode(userInfo!);

    var user1 = User.fromJson(userMap);

    token  = user1.token!;

    return  user1.token;

  }

  static Future getPhone() async {

    SharedPreferences  pref = await SharedPreferences.getInstance();

    String? userInfo =    pref.getString('userData');

    Map userMap = jsonDecode(userInfo!);

    var user1 = User.fromJson(userMap);

    phoneNumber  = user1.phone!;

    return  user1.phone;

  }


  static Future getFirstname() async {

    SharedPreferences  pref = await SharedPreferences.getInstance();

    String? userInfo =    pref.getString('userData');

    Map userMap = jsonDecode(userInfo!);

    var user1 = User.fromJson(userMap);



    firstName = user1.first_name.toString();

    return  user1.first_name;

  }

  static Future getLastname() async {

    SharedPreferences  pref = await SharedPreferences.getInstance();

    String? userInfo =    pref.getString('userData');

    Map userMap = jsonDecode(userInfo!);

    var user1 = User.fromJson(userMap);

    lastName = user1.last_name.toString();

    return  user1.last_name;

  }

  static Future getEmail() async {

    SharedPreferences  pref = await SharedPreferences.getInstance();

    String? userInfo =    pref.getString('userData');

    Map userMap = jsonDecode(userInfo!);

    var user1 = User.fromJson(userMap);

    email = user1.email.toString();

    return  user1.email;

  }
// https://digifarmer.agrosahas.co/farmerapp/public/api/v1/users/reset-password/email
 static forgotPasswordEmailSend(String email) async{
   Map data = {
     "email":email,


   };


   var body = json.encode(data);
   var url = Uri.parse('https://digifarmer.agrosahas.co/farmerapp/public/api/v1/users/reset-password/email');

   http.Response response  =  await http.post(
       url,
       headers: {
         'Content-Type': "application/json",


       },
       encoding: Encoding.getByName("utf-8"),
       body: body

   );



   print(response.body);
   return response;
  }















  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  // Future<String> signInWithGoogle() async {
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //   await googleSignInAccount.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //
  //   final AuthResult authResult = await _auth.signInWithCredential(credential);
  //   final FirebaseUser user = authResult.user;
  //
  //   assert(!user.isAnonymous);
  //   assert(await user.getIdToken() != null);
  //
  //   final FirebaseUser currentUser = await _auth.currentUser();
  //   assert(user.uid == currentUser.uid);
  //
  //   return 'signInWithGoogle succeeded: $user';
  // }
  //
  // void signOutGoogle() async{
  //   await googleSignIn.signOut();
  //
  //   print("User Sign Out");
  // }













}