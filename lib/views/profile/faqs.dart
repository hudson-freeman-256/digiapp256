import 'dart:convert';

import 'package:digifarmer/models/Faqs.dart';
import 'package:digifarmer/views/auth/register.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

import '../../services/auth_service.dart';
import '../../services/profile_service.dart';
import '../../static/color.dart';
import '../../static/static_values.dart';

class Faqs extends StatefulWidget {



  const Faqs({Key? key}) : super(key: key);


  @override
  State<Faqs> createState() => _FaqsState();


}






class _FaqsState extends State<Faqs> {

  static final String bearerToken = AuthService.token;


 Future<List<Data>> getFaqs() async {

    var response = await http.get(
        Uri.parse(StaticValues.mainApiUrl+'support/faqs')
        ,headers: {
    'Authorization': 'Bearer $bearerToken',
    });

    var jsonData = jsonDecode(response.body);





    List<Data> faqsData = [];

    print(jsonData['data']);

    for(var faqs in  jsonData['data']){
      Data faqsDataOne = Data( faqs["question"], faqs["answer"]);

      faqsData.add(faqsDataOne);
    }


  



      return faqsData;

  }




  @override
  void initState() {
    super.initState();



  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Faqs",style: StaticValues.customFonts(Colors.white, 20, FontWeight.w700),),
        backgroundColor: CustomColors.barColor,
      ),
      body:


      FutureBuilder<List<Data>>(
        future: getFaqs(),
        builder: ( context,  snapshot){
          if(snapshot.connectionState == ConnectionState.done){

            if(snapshot.hasData){

             return ListView.separated(
                 itemBuilder: (context,index){

                   var data = snapshot.data?[index];
                   // return Container(
                   //   child: Text('${data?.question}'),
                   // );

                   return ExpansionTile(
                       title: Container(
                           width: double.infinity,

                           child: Text('${data?.question}',style: StaticValues.customFonts(Colors.black, 18, FontWeight.w700),),


                       )

                           ,children: [
                             Padding(
                               padding: const EdgeInsets.all(15.0),
                               child: Text('${data?.answer}',style: StaticValues.customFonts(Colors.grey, 15, FontWeight.w700),),
                             )
                     ],
                   );
                 },
                 separatorBuilder: (context,index){
                   return Divider(thickness: 0.5,height: 0.5,);
                 },
                 itemCount: snapshot.data?.length ?? 0);


            



            }else{
              return Text("No Faqs");
            }

            //Build you UI
          }else{
            return Center(child: CircularProgressIndicator(color: CustomColors.barColor,));
          }
        },
      )
      ,
    );
  }


}


class Data{
   final String question , answer;
  Data(this.question, this.answer);
}








