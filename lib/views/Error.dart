import 'package:flutter/material.dart';


class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Image.asset("assets/404.png",height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,));
  }
}
