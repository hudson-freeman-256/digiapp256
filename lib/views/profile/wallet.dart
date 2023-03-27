import 'dart:ui';


import 'package:digifarmer/services/auth_service.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../bottommenu/bottom_menu.dart';

class Wallet extends StatelessWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Wallet"),
            backgroundColor: CustomColors.barColor,
          ),
          backgroundColor: const Color(0XFFF3F8FE),
          body: SingleChildScrollView(
            child: Column(


              children: [


                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                          onTap: (){
                                            Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) =>  BottomMenuScreen()));
                                          },
                                          child: Text("Home")),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 100,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFF7C8CE),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            AuthService.photo
                                     ),
                                          fit: BoxFit.cover)),
                                ),
                                Column(
                                  children:  [
                                    Text(
                                      AuthService.username.toUpperCase(),
                                      style: TextStyle(
                                          color: Color(0xFF565D94),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Farmer')
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      TransactionsWidget(
                                        balance: '\$4m',
                                        balanceTitle: 'Income',
                                        thikness: 1,
                                      ),
                                      TransactionsWidget(
                                        balance: '\$500k',
                                        balanceTitle: 'Expenses',
                                        thikness: 1,
                                      ),
                                      TransactionsWidget(
                                        balance: '\$8m',
                                        balanceTitle: 'Loan',
                                        thikness: 0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Overview',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Color(0xFF4D548E)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.notification_add)
                              ],
                            ),
                            const Text(
                              'Sept 13,2018',
                              style: TextStyle(
                                color: Color(0xFF4D548E),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const CustomContainer(
                          subtitle: 'Sending Payment to Clients',
                          subfixtext: '\$150',
                          icon: AntDesign.arrowup,
                          title: 'Sent',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const CustomContainer(
                          subtitle: 'Receiving Salary from Company',
                          subfixtext: '\$1450',
                          icon: AntDesign.arrowdown,
                          title: 'Receive',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const CustomContainer(
                          subtitle: 'Loan for the Car',
                          subfixtext: '\$400',
                          icon: FontAwesome.dollar,
                          title: 'Loan',
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {Key? key,
        required this.icon,
        required this.title,
        required this.subfixtext,
        required this.subtitle})
      : super(key: key);
  final IconData icon;
  final String title;
  final String subtitle;
  final String subfixtext;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E8F8),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                size: 20,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              subfixtext,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class TransactionsWidget extends StatelessWidget {
  const TransactionsWidget(
      {Key? key,
        required this.balance,
        required this.balanceTitle,
        required this.thikness})
      : super(key: key);
  final String balance;
  final String balanceTitle;
  final double? thikness;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                balance,
                style: const TextStyle(
                    color: Color(0xFF565D94),
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                balanceTitle,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: thikness,
            color: const Color(0xFF565D94),
          ),
        ],
      ),
    );
  }
}