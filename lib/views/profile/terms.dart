import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../static/color.dart';
import '../../static/static_values.dart';

class Terms extends StatefulWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {

  Future<List<Term>> getFaqs() async {

    var response = await http.get(
        Uri.parse(StaticValues.mainApiUrl+'app/terms&conditions')
        ,headers: StaticValues.headers);

    var jsonData = jsonDecode(response.body);





    List<Term> termData = [];

    print(jsonData['data']);

    for(var faqs in  jsonData['data']){
      Term faqsDataOne = Term( faqs["title"], faqs["description"]);

      termData.add(faqsDataOne);
    }






    return termData;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms & Conditions",style: StaticValues.customFonts(Colors.white, 20, FontWeight.w700),),
        backgroundColor: CustomColors.barColor,

      ),
      body:  FutureBuilder<List<Term>>(
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

                    // Text('${data?.title}',style: TextStyle(fontSize: 18),),

                    return Card(
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${data?.title}',style:StaticValues.customFonts(Colors.black, 18, FontWeight.w700),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('${data?.description}',style: StaticValues.customFonts(Colors.grey, 15, FontWeight.w400),),
                          ],
                        ) ,

                      ),


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
      ),
    );
  }
}

class Term{
  final String title , description;
  Term(this.title, this.description);
}
