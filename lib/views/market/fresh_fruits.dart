import 'package:flutter/material.dart';

import '../../models/constants.dart';
import '../../models/data.dart';
import '../../models/fruits_and_vegs.dart';


class FreshFruits extends StatelessWidget {


  Widget _buildFreshFruits(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    FruitsAndVegs fruitsAndVegs = freshFruitsList[index];

    return Padding(
      padding: const EdgeInsets.only(left: appPadding),
      child: SizedBox(
        width: size.width * 0.3,
        child: Column(
          children: [
            Image(
              height: size.height * 0.13,
              fit: BoxFit.fitWidth,
              image: AssetImage(fruitsAndVegs.imageUrl),
            ),
            Text(
              fruitsAndVegs.name,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(appPadding),
          child: Text(
            'Latest deals',
            style: TextStyle(
                fontSize: 24, letterSpacing: 1, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: size.height * 0.4,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: freshFruitsList.length,
            itemBuilder: (context, index) {
              return _buildFreshFruits(context, index);
            },
          ),
        )
      ],
    );
  }
}
