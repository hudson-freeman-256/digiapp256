
import 'dart:convert';

import 'package:digifarmer/views/chat/inbox.dart';
import 'package:digifarmer/views/farm/farmui/viewfarm.dart';
import 'package:digifarmer/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../static/color.dart';
import '../../static/static_values.dart';
import '../farm/farm.dart';

import '../market/market.dart';
import '../profile/profile.dart';

class BottomMenuScreen extends StatefulWidget {
  const BottomMenuScreen({Key? key}) : super(key: key);



  @override
  State<BottomMenuScreen> createState() => _BottomMenuScreenState();


}



class _BottomMenuScreenState extends State<BottomMenuScreen> {


  void changeSelectedItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }


  @override
  void initState() {
    super.initState();




  }


  int selectedIndex = 0;

  Widget _home = HomeScreen();

  Widget _market = Market();
  Widget _farm = ViewFarm();
  Widget _inbox = InboxScreen();
  Widget _profile = Profile();






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.getBody(),



    bottomNavigationBar: BottomNavigationBar(
      selectedItemColor: CustomColors.barColor,
      selectedLabelStyle: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),
      unselectedLabelStyle: StaticValues.customFonts(Colors.black, 15, FontWeight.w700),

      iconSize: 30.0,
      backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(


            backgroundColor: CustomColors.barColor,
            icon: Icon(Icons.home),
            label: 'Home',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.landslide_outlined),
            label: 'Farm',


          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.warehouse_outlined),
            label: 'Market',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forward_to_inbox),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
          ),

        ],
        onTap: (int index){
          this.onTapHandler(index);
        },
      ),


    );
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });

  }

  getBody() {

    if(this.selectedIndex == 0) {
     return this._home;
    } else if(this.selectedIndex==1) {
      return this._farm;
    }
  if(this.selectedIndex == 2){
      return this._market;
    }else  if(this.selectedIndex == 3){
      return this._inbox;
    }else  if(this.selectedIndex == 4){
      return this._profile;
    }


    // }else  if(this.selectedIndex == 3){
    //   return this._inbox;
    // }else  if(this.selectedIndex == 4){
    //   return this._profile;
    // }
  }


}
