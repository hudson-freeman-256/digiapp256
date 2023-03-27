import 'dart:convert';
import 'dart:io';
import 'package:digifarmer/static/color.dart';
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

class AddTraining extends StatefulWidget {
  const AddTraining({Key? key}) : super(key: key);

  @override
  State<AddTraining> createState() => _AddTrainingState();
}



class _AddTrainingState extends State<AddTraining> {




  TimeOfDay _timeOfDay = TimeOfDay(hour: 8, minute: 30);

  bool? isOnline = false;
  File? image;
  PickedFile? _pickedFile;
  final _picker = ImagePicker();

  String? startDate,endDate,startTime,endTime;



  TextEditingController name = TextEditingController();
  TextEditingController charge = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController zoomLink = TextEditingController();



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
      
      if(name.text.isEmpty){
        StaticValues.errorSnackBar(context, "Name can't be empty");
      }else if(charge.text.isEmpty){
        StaticValues.errorSnackBar(context, "Charge can't be empty");
      }else if(description.text.isEmpty){
        StaticValues.errorSnackBar(context, "Description can't be empty");
      }else if(_startTime.contains("Not set")){
        StaticValues.errorSnackBar(context, "Please select Start Time");
      }else if(_endTime.contains("Not set")){
        StaticValues.errorSnackBar(context, "Please select End Time");
      }else if(_startDate.contains("Not set")){
        StaticValues.errorSnackBar(context, "Please select Start Date");
      }else if(_endDate.contains("Not set")){
        StaticValues.errorSnackBar(context, "Please select End Date");
      }else{

        await SendTrainingData();




      }
      // print(selectedAddress);
  }

  Future<void> SendTrainingData() async {
         showAlertDialog(context);



    http.Response  isUploaded = await AddVendorService.addTraining(name.text,charge.text,selectedAccess.toString(),
        description.text,_startDate,_endDate,_startTime,_endTime,image?.path,zoomLink.text,selectedAddress.toString());


    Navigator.pop(context);

    Map responseMap = jsonDecode(isUploaded.body);


    if(responseMap['success'] == true){

      StaticValues.successSnackBar(context, responseMap['message']);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ViewUserTraining() ,)).then(
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
        title: const Text("Add Training"),
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


                        Padding(
                          padding: EdgeInsets.all(15),
                          child: TextField(
                             controller: name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              hintText: 'Name',
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(15),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller:charge,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Charge',
                              hintText: 'Charge',
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: MultiLineTextField(
                            controller: description,
                            maxLines: 10,
                            bordercolor: Colors.grey,
                            label: "Description",
                          ),
                        ),




                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text(
                                'Select Access',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme
                                      .of(context)
                                      .hintColor,
                                ),
                              ),
                              items: access
                                  .map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ))
                                  .toList(),
                              value: selectedAccess,
                              onChanged: (value) {
                                setState(() {
                                  selectedAccess = value as String;
                                  if(selectedAccess == "Online"){
                                    isOnline = true;
                                  }else{
                                    isOnline = false;
                                  }
                                });
                              },
                              buttonHeight: 40,
                              buttonWidth: MediaQuery.of(context).size.width,
                              itemHeight: 40,
                            ),
                          ),
                        ),


                        Visibility(
                          visible: isOnline!,
                          child:   Padding(
                            padding: EdgeInsets.all(15),
                            child: TextField(
                              controller: zoomLink,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Zoom Link',
                                hintText: 'Zoom Link',
                              ),
                            ),
                          ),
                        ),

                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text("Start Date",style: GoogleFonts.poppins(color: CustomColors.barColor,fontWeight: FontWeight.w600),),
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
                            SizedBox(height: 10,),
                            Text("End Date",style: GoogleFonts.poppins(color: Colors.red,fontWeight: FontWeight.w600)),
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

                                      _endDate = '${date.year}-${date.month}-${date.day}';
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
                                                " $_endDate",
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
                          ],
                        ),
                      )),

                    Visibility(
                      visible: !isOnline!,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text(
                              'Select Address',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme
                                    .of(context)
                                    .hintColor,
                              ),
                            ),
                            items: address_data.map((item) {
                              return new DropdownMenuItem(
                                  child: new Text(
                                    item['address_name'],    //Names that the api dropdown contains
                                    style: TextStyle(
                                      fontSize: 13.0,
                                    ),
                                  ),
                                  value: item['id'].toString()       //Id that has to be passed that the dropdown has.....
                                //e.g   India (Name)    and   its   ID (55fgf5f6frf56f) somethimg like that....
                              );
                            }).toList(),
                            value: selectedAddress,
                            onChanged: (value) {
                              setState(() {
                                selectedAddress = value as String;
                              });
                            },
                            buttonHeight: 40,
                            buttonWidth: MediaQuery.of(context).size.width,
                            itemHeight: 40,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey[300],
                            child: image != null
                                ? Image.file(
                              File(_pickedFile!
                                  .path), width:MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height
                              , fit: BoxFit.cover,
                            )
                                : GestureDetector(child: Image.asset("assets/upload.png",height: 100,),
                            onTap: (){
                                   _pickImage();
                            },
                            ),
                          ),

                          const SizedBox(height: 32),
                          // IconButton(
                          //   icon: Icon(Icons.arrow_upward),
                          //   onPressed: () {
                          //     final images = controller.images;
                          //     // use these images
                          //     print(images);
                          //   },
                          // )

                        ],
                      ),


                    ),






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


