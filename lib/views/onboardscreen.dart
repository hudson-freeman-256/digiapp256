
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/bottommenu/bottom_menu.dart';
import 'package:digifarmer/views/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OnBoardScreen extends StatefulWidget {

  const OnBoardScreen({Key? key,}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final PageController _pageController = PageController();









  _checkShowIntro() async {

    SharedPreferences oneTime = await SharedPreferences.getInstance();

    var  _showIntro  = oneTime.getBool("first_time");

    if(!_showIntro! ){
      Get.to(const Splashscreen());
    }


  }




  @override
  void initState() {
    super.initState();
    _checkShowIntro();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: OnBoard(
        pageController: _pageController,
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        onSkip: () {
          // print('skipped');
          // Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => ));
        },
        // Either Provide onDone Callback or nextButton Widget to handle done state
        onDone: () {

          // Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => HomeScreen()));
        },
        onBoardData: onBoardData,

        titleStyles: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.15
      ),
        descriptionStyles: GoogleFonts.poppins(
          color: CustomColors.gary,
          fontSize: 16
        ),
        pageIndicatorStyle: const PageIndicatorStyle(
          width: 100,
          inactiveColor: CustomColors.barColor,
          activeColor: CustomColors.lightBarColor,
          inactiveSize: Size(8, 8),
          activeSize: Size(12, 12),
        ),
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        skipButton: TextButton(
          onPressed: () {
    Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => BottomMenuScreen()));

            // print('skipButton pressed');
          },
          child: const Visibility(
            visible: false,
            child: Text(
              "Skip",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ),
        // Either Provide onDone Callback or nextButton Widget to handle done state
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);


            return InkWell(
              onTap: () => _onNextTap(state),
              child: Container(
                width: 230,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [CustomColors.barColor, CustomColors.lightBarColor,],
                  ),
                ),
                child: Text(
                  state.isLastPage ? "Done" : "Next",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _onNextTap(OnBoardState onBoardState) async {

    if(onBoardState.isLastPage == true){




      Get.off(const Splashscreen());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboardShown', true);

    }


    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {

    }


  }
}

final List<OnBoardModel> onBoardData = [

  // Get access to Markets
  // Post your products to sell to verified buyers
  const OnBoardModel(

    title: "Get access to Markets",
    description: "Post your products to sell to verified buyers",
    imgUrl: "assets/onboard/3.png",
  ),
  // Connect with vendors to increasing productivity
  // We are aligned with your goals to increase crop productivity
  const OnBoardModel(
    title: "Connect with vendors to increasing productivity",
    description:
    "We are aligned with your goals to increase crop productivity",
    imgUrl: 'assets/onboard/1.png',
  ),
  // Manage your Farm
  // Track your farm profitability and output with ease
  const OnBoardModel(
    title: "Manage your Farm",
    description:
    "Track your farm profitability and output with ease",
    imgUrl: 'assets/onboard/2.png',
  ),
];






