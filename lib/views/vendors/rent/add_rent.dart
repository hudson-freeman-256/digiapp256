import 'dart:convert';
import 'dart:io';
import 'package:digifarmer/static/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:textfields/textfields.dart';

import '../../../../services/add_Edit_Delete_Update_vendor_services.dart';
import '../../../../services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../../../../static/static_values.dart';

class AddRent extends StatefulWidget {
  const AddRent ({Key? key}) : super(key: key);

  @override
  State<AddRent > createState() => _AddRentState();
}



class _AddRentState extends State<AddRent> {




  File? image;
  PickedFile? _pickedFile;
  final _picker = ImagePicker();
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


  TextEditingController name = TextEditingController();
  TextEditingController charge = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController description = TextEditingController();

  // ,price,weight,description;

  List address_data = [];
  List animal_category_data = [];
  List animal_sub_category_data = [];

   String? addressid;
  String? animal_cate_id;
  String? selectedDays;

  // int? selected_days;
 //variable for choosed file





  List _images = [];


  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
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


  addFarm() async{


    if(name.text.isEmpty ){
      StaticValues.errorSnackBar(context, "Please Enter your  Name");
    }else if(charge.text.isEmpty){
      StaticValues.errorSnackBar(context, "Please Enter your Charge");
    }else if(selectedCategory == null){
      StaticValues.errorSnackBar(context, "Please Enter your Category");
    }else if(description.text.isEmpty ){
      StaticValues.errorSnackBar(context, "Please Enter your Description");
    }
    else if(quantity.text.isEmpty){
      StaticValues.errorSnackBar(context, "Please Enter your Quantity");
    }
    else if(selectedSubCategory == null){
      StaticValues.errorSnackBar(context, "Please Enter your Sub-Category");
    }else {
      // farm = await FarmService.addFarm(name.text, field.text, selectedSize!, selectedAddress!);


      showAlertDialog(context);


      http.Response response = await AddVendorService.addRent("",name.text,selectedAddress!,charge.text,quantity.text,description.text,selectedSubCategory!,image!.path);

      Navigator.pop(context);
      Map responseMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseMap['success'] == false) {
          StaticValues.errorSnackBar(context, responseMap['message']);
        }


        if (responseMap['success'] == true) {

          StaticValues.successSnackBar(context, responseMap['message']);

          return  Get.back();
        }

      } else {
        StaticValues.errorSnackBar(context, responseMap['message']);
      }



    }



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

  // /vendor_categories/{id}/animal_feeds

  Future<String> selectSubCategory(String id) async {

    final String bearerToken = AuthService.token;


    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"rent_category/${id}/sub_category"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

 //   print(resBody['data']['name']);

    setState(() {
      animal_sub_category_data = resBody['rent-sub-categories'];

      print(animal_sub_category_data);

    });



    return "Sucess";
  }

  Future<String> selectVendors(String id) async {

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"animal-category/${id}/feeds"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    //   print(resBody['data']['name']);

    setState(() {
      animal_sub_category_data = resBody['animal_feed_categories'];

      print(animal_sub_category_data);

    });



    return "Sucess";
  }



  Future<String> selectCategory() async {

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"rent_vendor_categories"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    setState(() {
      animal_category_data = resBody['data'];
    });


    return "Sucess";
  }

  // /animal_categories





  String? path;



  final List<String> unit = [
    'kg',
    'g',
    'ml',
  ];



  String? selectedUnit;
  String? selectedValue;


  String? selectedAddress;
    String? selectedCategory;
  String? selectedSubCategory;


  final controller = MultiImagePickerController(
    maxImages: 1,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );



  @override
  void initState()  {
    super.initState();

    selectAddress();

    selectCategory();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.barColor,
        title: const Text("Add Rent"),
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
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              hintText: 'Name',
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(15),
                          child: TextField(
                            controller: charge,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'charge',
                              hintText: 'charge',
                            ),
                          ),
                        ),



                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text(
                                'Select Rent Category',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme
                                      .of(context)
                                      .hintColor,
                                ),
                              ),
                              items: animal_category_data.map((item) {
                                return new DropdownMenuItem(
                                    child: new Text(
                                      item['name'],    //Names that the api dropdown contains
                                      style: TextStyle(
                                        fontSize: 13.0,
                                      ),
                                    ),
                                    value: item['id'].toString()       //Id that has to be passed that the dropdown has.....
                                  //e.g   India (Name)    and   its   ID (55fgf5f6frf56f) somethimg like that....
                                );
                              }).toList(),
                              value: selectedCategory,
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory = value as String;
                                });

                                selectSubCategory(value as String);
                              },
                              buttonHeight: 40,
                              buttonWidth: MediaQuery.of(context).size.width,
                              itemHeight: 40,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text(
                                'Select Rent Sub-Category',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme
                                      .of(context)
                                      .hintColor,
                                ),
                              ),
                              items: animal_sub_category_data.map((item) {
                                return new DropdownMenuItem(
                                    child: new Text(
                                      item['name'],    //Names that the api dropdown contains
                                      style: TextStyle(
                                        fontSize: 13.0,
                                      ),
                                    ),
                                    value: item['id'].toString()       //Id that has to be passed that the dropdown has.....
                                  //e.g   India (Name)    and   its   ID (55fgf5f6frf56f) somethimg like that....
                                );
                              }).toList(),
                              value: selectedSubCategory,
                              onChanged: (value) {

                                print("jj");
                                setState(() {
                                  selectedSubCategory = value as String;
                                });

                              },
                              buttonHeight: 40,
                              buttonWidth: MediaQuery.of(context).size.width,
                              itemHeight: 40,
                            ),
                          ),
                        ),

                        Padding(
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

                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text(
                                'Select Charge Frequency',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme
                                      .of(context)
                                      .hintColor,
                                ),
                              ),
                              items: StaticValues.days
                              
                                  .map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                                  .toList(),
                              value: selectedDays,
                              onChanged: (value) {
                                setState(() {
                                  selectedDays = value as String;
                                });
                              },
                              buttonHeight: 40,
                              buttonWidth: MediaQuery.of(context).size.width,
                              itemHeight: 40,
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(15),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: quantity,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Quantity',
                              hintText: 'Quantity',
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
                              onPressed: () async {

                       addFarm();


                                // addAnimalFeed();
                              },
                              child: Text("Save"),
                            ),
                          ),
                        )

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


