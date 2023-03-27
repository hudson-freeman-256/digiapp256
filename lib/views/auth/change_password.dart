import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../static/color.dart';
class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   GestureDetector(
    onTap: (){
      Get.back();
    },
    child: const
                Icon(Icons.arrow_back_ios),
  ),
),
            SizedBox(height: 30,),

            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                // controller: total,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Current Password',
                  hintText: 'Current Password',
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                // controller: total,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Password',
                  hintText: 'New Password',
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                // controller: total,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm New Password',
                  hintText: 'Confirm New Password',
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                  ),
                  onPressed: (){

                  },
                  child: Text("Update Password")),
            )

          ],
        ),
      ),
    );
  }
}
