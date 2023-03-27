

import 'package:flutter/cupertino.dart';

class FadeImage extends StatelessWidget{

  String image;
  FadeImage({Key? key, required this.image}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return FadeInImage(

     placeholder: AssetImage('assets/LOADING_ANIMATION.gif'),
     image: NetworkImage(image),



   );
  }


}