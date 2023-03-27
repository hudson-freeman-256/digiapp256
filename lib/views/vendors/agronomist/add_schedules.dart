import 'dart:convert';
import 'dart:io';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/vendors/agronomist/view_user_agronomist.dart';
import 'package:digifarmer/views/vendors/training/view_user_training.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:textfields/textfields.dart';

import '../../../../services/add_Edit_Delete_Update_vendor_services.dart';
import '../../../../services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../../../../static/static_values.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddSchedules extends StatefulWidget {
  final int id;
  const AddSchedules({Key? key, required this.id}) : super(key: key);

  @override
  State<AddSchedules> createState() => _AddSchedulesState();
}



class _AddSchedulesState extends State<AddSchedules> {




  TimeOfDay _timeOfDay = TimeOfDay(hour: 8, minute: 30);

  bool? isOnline = false;
  File? image;
  PickedFile? _pickedFile;
  final _picker = ImagePicker();

  String? startDate,endDate,startTime,endTime;



  TextEditingController time_interval = TextEditingController();




  from25to12hours(String time){
    var twentyFourHourTime = time;
    var format = DateFormat.jm();
    var twelveHourTime = format.format(DateTime.parse('2022-01-01 $twentyFourHourTime'));

    return twelveHourTime; // 12:00 AM

  }



  List address_data = [];

  // show time picker method
  void _showTimePicker(String value1) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {

      setState(() {
        if(value1.contains("startTime")){


          startDate =  from25to12hours('${value?.hour.toString()}${value?.minute.toString()}');


        }else if(value1.contains("endTime")){



          endTime =  from25to12hours("${value?.hour.toString()}${value?.minute.toString()}");
        }
      });
    });
  }

  void pickDate(BuildContext context,String value) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(2023, 1, 1),
        maxTime: DateTime(2050, 1, 1),
        theme: DatePickerTheme(
            headerColor: Colors.white70,
            backgroundColor: Colors.white70,
            itemStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 18),
            doneStyle:
            TextStyle(color: CustomColors.barColor, fontSize: 16)),
        onChanged: (date) {
          print('change $date in time zone ' +
              date.timeZoneOffset.inHours.toString());
        }, onConfirm: (date) {

          // String? startDate,endDate,startTime,endTime;

          if(startDate!.contains("startDate")){
            setState(() {
              startDate = date.toString().trim();
            });
          }

          if(startDate!.contains("endDate")){
            setState(() {
              endDate = date.toString().trim();
            });
          }


        }, currentTime: DateTime.now(), locale: LocaleType.en);

  }




  // Implementing the image picker
  Future<void> _pickImage() async {
    _pickedFile=
    await _picker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      setState(() {
        image = File(_pickedFile!.path);
      });
    }
  }




  // ,price,weight,description;




  String? addressid;
  String? animal_cate_id;

  String _startDate = "Not set";
  String _endDate = "Not set";
  String _startTime = "Not set";
  String _endTime = "Not set";
  // create TimeOfDay variable


  //variable for choosed file
  TimeOfDay? _selectedTime;

  List _images = [];


  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(color: CustomColors.barColor,),
          Container(margin: EdgeInsets.only(left: 5),child:Text("Loading" )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }


  Future<String> selectAddress() async {

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"user/my-addresses"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    setState(() {
      address_data = resBody['data'];
    });


    return "Sucess";
  }




  String? path;




  final List<String> access = [
    'Online',
    'Offline',
  ];

  String? selectedAccess;



  String? selectedAddress;



  final controller = MultiImagePickerController(
    maxImages: 1,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );



  @override
  void initState()  {
    super.initState();

    selectAddress();



  }


  addTraining() async {


    print(_startDate);
    print(_endDate);
         if(_startTime.contains("Not set")){
      StaticValues.errorSnackBar(context, "Please select Start Time");
    }else if(_endTime.contains("Not set")){
      StaticValues.errorSnackBar(context, "Please select End Time");
    }else if(_startDate.contains("Not set")){
      StaticValues.errorSnackBar(context, "Please select Start Date");
    }else{

      await SendTrainingData();




    }
    // print(selectedAddress);
  }

  Future<void> SendTrainingData() async {
    showAlertDialog(context);



    http.Response  isUploaded = await AddVendorService.addSchedule(widget.id.toString(), time_interval.text, startDate!, startTime!, endTime!);

    Navigator.pop(context);

    Map responseMap = jsonDecode(isUploaded.body);


    if(responseMap['success'] == true){

      StaticValues.successSnackBar(context, responseMap['message']);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ViewUserAgronomist() ,)).then(
              (value) =>
              setState(() {
                // Call setState to refresh the page.
              })
      );

    }else{
      StaticValues.errorSnackBar(context, responseMap['message']);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.barColor,
        title: const Text("Add Schedule"),
      ),
      body: Container(
          color: Colors.grey.shade200,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Center(child: Text("Add Animal Feed",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 25))),
                // ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,

                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          // Padding(
                          //   padding: EdgeInsets.all(15),
                          //   child: TextField(
                          //     controller: name,
                          //     decoration: InputDecoration(
                          //       border: OutlineInputBorder(),
                          //       labelText: 'Name',
                          //       hintText: 'Name',
                          //     ),
                          //   ),
                          // ),






                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text("Date",style: GoogleFonts.poppins(color: CustomColors.barColor,fontWeight: FontWeight.w600),),
                                    SizedBox(height: 5,),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Color(0xfff5f5f5)),
                                      ),

                                      onPressed: () {
                                        DatePicker.showDatePicker(context,
                                            theme: DatePickerTheme(
                                              containerHeight: 210.0,
                                            ),
                                            showTitleActions: true,
                                            minTime: DateTime(2023, 1, 1),
                                            maxTime: DateTime(2050, 12, 31), onConfirm: (date) {

                                              _startDate = '${date.year}-${date.month}-${date.day}';
                                              setState(() {});
                                            }, currentTime: DateTime.now(), locale: LocaleType.en);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.date_range,
                                                        size: 18.0,
                                                        color: Colors.grey,
                                                      ),
                                                      Text(
                                                        " $_startDate",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18.0),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              "  Change",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ),

                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text("Start Time",style: GoogleFonts.poppins(color: CustomColors.barColor,fontWeight: FontWeight.w600),),
                                    SizedBox(height: 5,),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Color(0xfff5f5f5)),
                                      ),
                                      onPressed: () {
                                        DatePicker.showTime12hPicker(context,
                                            theme: const DatePickerTheme(
                                              containerHeight: 210.0,


                                            ),

                                            showTitleActions: true, onConfirm: (time) {

                                              _startTime = from25to12hours('${time.hour}:${time.minute}');
                                              setState(() {});
                                            }, currentTime: DateTime.now(), locale: LocaleType.en);
                                        setState(() {});
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.access_time,
                                                        size: 18.0,
                                                        color: Colors.grey,
                                                      ),
                                                      Text(
                                                        " $_startTime",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18.0),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              "  Change",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ),

                                    SizedBox(height: 5,),
                                    Text("End Time",style: GoogleFonts.poppins(color: Colors.red,fontWeight: FontWeight.w600)),
                                    SizedBox(height: 5,),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Color(0xfff5f5f5)),
                                      ),
                                      onPressed: () {
                                        DatePicker.showTime12hPicker(context,
                                            theme: const DatePickerTheme(
                                              containerHeight: 210.0,


                                            ),

                                            showTitleActions: true, onConfirm: (time) {

                                              _endTime = from25to12hours('${time.hour}:${time.minute}');
                                              setState(() {});
                                            }, currentTime: DateTime.now(), locale: LocaleType.en);
                                        setState(() {});
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.access_time,
                                                        size: 18.0,
                                                        color: Colors.grey,
                                                      ),
                                                      Text(
                                                        " $_endTime",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18.0),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              "  Change",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ),
                                    // time_interval
                                    Padding(
                                      padding: EdgeInsets.all(15),
                                      child: TextField(
                                        controller: time_interval,
                                        keyboardType: TextInputType.datetime,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Time Interval',
                                          hintText: 'Time Interval',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),









                          Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                                ),
                                onPressed: ()  {
                                  addTraining();
                                },
                                child: Text("Save"),
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),

                  ),
                )
              ],
            ),
          )

      ),
    )
    ;
  }




}


