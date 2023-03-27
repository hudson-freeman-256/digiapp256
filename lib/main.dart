import 'package:digifarmer/providers/crop_on_sale_provider.dart';
import 'package:digifarmer/providers/home_screen_provider.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/auth/forget_password.dart';
import 'package:digifarmer/views/auth/login.dart';
import 'package:digifarmer/views/onboardscreen.dart';
import 'package:digifarmer/views/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor:  CustomColors.white, // navigation bar color
    statusBarColor: CustomColors.barColor, // status bar color
    statusBarIconBrightness: Brightness.light, // status bar icon color
    systemNavigationBarIconBrightness: Brightness.dark, // color of navigation controls
  ));

  WidgetsFlutterBinding.ensureInitialized();

  // Get the instance of SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();


  // Get the value of onboardShown from SharedPreferences
  bool onboardShown = prefs.getBool('onboardShown') ?? false;

      runApp( ChangeNotifierProvider<HomeScreenProvider>(
      child:  MyApp(onboardShown) ,
      create: (_) => HomeScreenProvider() ) );

  // runApp(MyApp(onboardShown));
}

class MyApp extends StatelessWidget {
  final bool onboardShown;

  const MyApp(this.onboardShown, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

        return  GetMaterialApp(
      debugShowCheckedModeBanner: false,

      color: CustomColors.barColor,
       // home: MyLogin(),
        home: onboardShown ? const Splashscreen() : const OnBoardScreen(),

    );


  }
}




