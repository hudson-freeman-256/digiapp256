import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

import '../utils.dart';


class Scene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 414;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // defaultsplash1aUv (1:273)
        width: double.infinity,
        height: 896*fem,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
        ),
        child: Container(
          // group241v2z (1:274)
          width: 1657*fem,
          height: 908*fem,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // imagetitle3dQ (1:275)
                padding: EdgeInsets.fromLTRB(4*fem, 16*fem, 4*fem, 68*fem),
                width: 414*fem,
                height: double.infinity,
                decoration: BoxDecoration (
                  image: DecorationImage (
                    fit: BoxFit.cover,
                    image: AssetImage (
                      'assets/page-1/images/default.png',
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // actionbarL6i (1:306)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 13*fem, 29*fem),
                      width: double.infinity,
                      height: 21*fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // leftsider54 (I1:306;4:68)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 266.09*fem, 0*fem),
                            width: 56.79*fem,
                            height: double.infinity,
                            decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular(24*fem),
                            ),
                            child: Container(
                              // timemxi (I1:306;4:71)
                              padding: EdgeInsets.fromLTRB(7*fem, 1*fem, 9.79*fem, 0*fem),
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration (
                                borderRadius: BorderRadius.circular(24*fem),
                              ),
                              child: Text(
                                '9:41',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont (
                                  'SF Pro Text',
                                  fontSize: 15*ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3333333333*ffem/fem,
                                  letterSpacing: -0.5*fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // rightsideF7C (I1:306;4:61)
                            margin: EdgeInsets.fromLTRB(0*fem, 5*fem, 0*fem, 4.66*fem),
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // mobilesignalNxW (I1:306;4:67)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.29*fem, 0*fem),
                                  width: 17.88*fem,
                                  height: 10.67*fem,
                                  child: Image.asset(
                                    'assets/page-1/images/mobile-signal-tA2.png',
                                    width: 17.88*fem,
                                    height: 10.67*fem,
                                  ),
                                ),
                                Container(
                                  // wifi67p (I1:306;4:66)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.29*fem, 0.37*fem),
                                  width: 16.06*fem,
                                  height: 10.97*fem,
                                  child: Image.asset(
                                    'assets/page-1/images/wifi.png',
                                    width: 16.06*fem,
                                    height: 10.97*fem,
                                  ),
                                ),
                                Container(
                                  // battery1En (I1:306;4:62)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                                  width: 25.59*fem,
                                  height: 11.33*fem,
                                  child: Image.asset(
                                    'assets/page-1/images/battery-RyG.png',
                                    width: 25.59*fem,
                                    height: 11.33*fem,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // premiumfoodatyourdoorstepjRg (I1:280;3:10)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 11*fem, 609*fem),
                      child: Text(
                        'Welcome to',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont (
                          'Poppins',
                          fontSize: 50*ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.3*ffem/fem,
                          letterSpacing: 1.5*fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                    Container(
                      // pointerspxv (1:301)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 32*fem),
                      width: 48*fem,
                      height: 8*fem,
                      child: Image.asset(
                        'assets/page-1/images/pointers.png',
                        width: 48*fem,
                        height: 8*fem,
                      ),
                    ),
                    Container(
                      // primarybutton9EW (1:300)
                      margin: EdgeInsets.fromLTRB(13*fem, 0*fem, 13*fem, 0*fem),
                      width: double.infinity,
                      height: 60*fem,
                      decoration: BoxDecoration (
                        color: Color(0xff30c24f),
                        borderRadius: BorderRadius.circular(5*fem),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3f6cc51d),
                            offset: Offset(0*fem, 10*fem),
                            blurRadius: 4.5*fem,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Get started',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont (
                            'Poppins',
                            fontSize: 15*ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.5*ffem/fem,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // autogroupwc6iAQW (UgsWNaVjFCmrG9UxZrWC6i)
                height: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // autogroupq86rust (UgsWAFWwFHipT3afwKq86r)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 416*fem, 0*fem),
                      width: 827*fem,
                      height: 896*fem,
                      child: Stack(
                        children: [
                          Positioned(
                            // imagetitleEfG (1:282)
                            left: 0*fem,
                            top: 0*fem,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(46*fem, 96*fem, 46*fem, 647*fem),
                              width: 414*fem,
                              height: 896*fem,
                              decoration: BoxDecoration (
                                image: DecorationImage (
                                  fit: BoxFit.cover,
                                  image: AssetImage (
                                    'assets/page-1/images/mask-group-obt.png',
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // buypremiumqualityfruitsX8a (I1:286;3:10)
                                    margin: EdgeInsets.fromLTRB(1*fem, 0*fem, 0*fem, 29*fem),
                                    child: Text(
                                      'Buy Premium\nQuality Fruits',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Poppins',
                                        fontSize: 30*ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.3*ffem/fem,
                                        letterSpacing: 0.9*fem,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    // loremipsumdolorsitametconsetet (I1:287;3:11)
                                    'Lorem ipsum dolor sit amet, consetetur \n\nsadipscing elitr, sed diam nonumy',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont (
                                      'Poppins',
                                      fontSize: 15*ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5*ffem/fem,
                                      letterSpacing: 0.45*fem,
                                      color: Color(0xff868889),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            // imagetitle8eA (1:288)
                            left: 0*fem,
                            top: 0*fem,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(46*fem, 96*fem, 46*fem, 647*fem),
                              width: 414*fem,
                              height: 896*fem,
                              decoration: BoxDecoration (
                                image: DecorationImage (
                                  fit: BoxFit.cover,
                                  image: AssetImage (
                                    'assets/page-1/images/mask-group-eht.png',
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // buypremiumqualityfruits2jY (I1:292;3:10)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 29*fem),
                                    child: Text(
                                      'Get Discounts \nOn All Products',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Poppins',
                                        fontSize: 30*ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.3*ffem/fem,
                                        letterSpacing: 0.9*fem,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    // loremipsumdolorsitametconsetet (I1:293;3:11)
                                    'Lorem ipsum dolor sit amet, consetetur \n\nsadipscing elitr, sed diam nonumy',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont (
                                      'Poppins',
                                      fontSize: 15*ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5*ffem/fem,
                                      letterSpacing: 0.45*fem,
                                      color: Color(0xff868889),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // imagetitle3ee (1:294)
                      padding: EdgeInsets.fromLTRB(46*fem, 96*fem, 46*fem, 647*fem),
                      width: 414*fem,
                      decoration: BoxDecoration (
                        image: DecorationImage (
                          fit: BoxFit.cover,
                          image: AssetImage (
                            'assets/page-1/images/mask-group.png',
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // premiumfoodatyourdoorstepmKk (I1:298;3:10)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 29*fem),
                            child: Text(
                              'Buy Quality \nDairy Products',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont (
                                'Poppins',
                                fontSize: 30*ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3*ffem/fem,
                                letterSpacing: 0.9*fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          Text(
                            // loremipsumdolorsitametconsetet (I1:299;3:11)
                            'Lorem ipsum dolor sit amet, consetetur \n\nsadipscing elitr, sed diam nonumy',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont (
                              'Poppins',
                              fontSize: 15*ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.5*ffem/fem,
                              letterSpacing: 0.45*fem,
                              color: Color(0xff868889),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}