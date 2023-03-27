import 'dart:convert';
import 'dart:io';
import 'package:csc_picker/csc_picker.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/market/add_crop_sale/view_user_crop_on_sale.dart';
import 'package:digifarmer/views/vendors/agronomist/view_user_agronomist.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:textfields/textfields.dart';

import '../../../../services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../../../../static/static_values.dart';
import '../../../services/market.dart';

class AddCropOnSale extends StatefulWidget {
  const AddCropOnSale({Key? key}) : super(key: key);

  @override
  State<AddCropOnSale> createState() => _AddCropOnSaleState();
}



class _AddCropOnSaleState extends State<AddCropOnSale> {

  List address_data = [];
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  String? selectedAddress;

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


  // TextEditingController name = TextEditingController();
  TextEditingController charge = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController description = TextEditingController();

  // ,price,weight,description;

  List crop_data = [];


   String? cropid;


 //variable for choosed file


  List _images = [];

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




  @override
  void initState()  {
    super.initState();


    selectCrop();
    selectAddress();


  }






  Future<String> selectCrop() async {

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"crops"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    setState(() {
      crop_data = resBody['data'];
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

  final List<String> ava = [
    'Online',
    'Call',
    'In-Person',
    'Chat'
  ];

  String? selectedAvailability;
  String?  selectedCrop;



  final controller = MultiImagePickerController(
    maxImages: 1,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );






  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.barColor,
          title: const Text("Add Crop On Sale"),
        ),
        body: Container(
            color: Colors.grey.shade200,
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
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
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,

                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    //
                                    // Padding(
                                    //   padding: EdgeInsets.all(15),
                                    //   child: TextField(
                                    //      controller: name,
                                    //     decoration: InputDecoration(
                                    //       border: OutlineInputBorder(),
                                    //       labelText: 'Name',
                                    //       hintText: 'Name',
                                    //     ),
                                    //   ),
                                    // ),

                                    ///selected item style [OPTIONAL PARAMETER]

                                    //
                                    // ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                                    // dropdownHeadingStyle: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                                    //
                                    // ///DropdownDialog Item style [OPTIONAL PARAMETER]
                                    // dropdownItemStyle: TextStyle(color: Colors.black,fontSize: 14, ),
                                    //
                                    // ///Dialog box radius [OPTIONAL PARAMETER]
                                    // dropdownDialogRadius: 10.0,
                                    //
                                    // ///Search bar radius [OPTIONAL PARAMETER]
                                    // searchBarRadius: 10.0,
                                    //
                                    //       // availability

                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          hint: Text(
                                            'Select Crop',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme
                                                  .of(context)
                                                  .hintColor,
                                            ),
                                          ),
                                          items: crop_data.map((item) {
                                            return new DropdownMenuItem(
                                                child: new Text(
                                                  item['name'],
                                                  //Names that the api dropdown contains
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                  ),
                                                ),
                                                value: item['id']
                                                    .toString() //Id that has to be passed that the dropdown has.....
                                              //e.g   India (Name)    and   its   ID (55fgf5f6frf56f) somethimg like that....
                                            );
                                          }).toList(),
                                          value: selectedCrop,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedCrop = value as String;
                                            });
                                          },
                                          buttonHeight: 40,
                                          buttonWidth: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          itemHeight: 40,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
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
                                                  item['district_name'],
                                                  //Names that the api dropdown contains
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                  ),
                                                ),
                                                value: item['id']
                                                    .toString() //Id that has to be passed that the dropdown has.....
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
                                          buttonWidth: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          itemHeight: 40,
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
                                      padding: EdgeInsets.all(15),
                                      child: TextField(
                                        controller: quantity,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'quantity',
                                          hintText: 'quantity',
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
                                    // Padding(
                                    //   padding: const EdgeInsets.all(15.0),
                                    //   child:
                                    //   Column(
                                    //     children: [
                                    //       Container(
                                    //         alignment: Alignment.center,
                                    //         width: double.infinity,
                                    //         height: 200,
                                    //         color: Colors.grey[300],
                                    //         child: image != null
                                    //             ? Image.file(
                                    //           File(_pickedFile!
                                    //               .path), width:MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height
                                    //           , fit: BoxFit.cover,
                                    //         )
                                    //             : GestureDetector(child: Image.asset("assets/upload.png",height: 100,),
                                    //         onTap: (){
                                    //                _pickImage();
                                    //         },
                                    //         ),
                                    //       ),
                                    //
                                    //       const SizedBox(height: 32),
                                    //       // IconButton(
                                    //       //   icon: Icon(Icons.arrow_upward),
                                    //       //   onPressed: () {
                                    //       //     final images = controller.images;
                                    //       //     // use these images
                                    //       //     print(images);
                                    //       //   },
                                    //       // )
                                    //
                                    //     ],
                                    //   ),
                                    //
                                    //
                                    // )



                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                              ),
                              onPressed: () async {


                               await AddCropsOnSale(context);



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
  Future<void> AddCropsOnSale(BuildContext context) async {
    if(charge.text.isEmpty){
      StaticValues.errorSnackBar(context, "Charge can't be empty");

    }else   if(description.text.isEmpty){
      StaticValues.errorSnackBar(context, "Description can't be empty");

    }else if(selectedAddress == null){
      StaticValues.errorSnackBar(context, "Address can't be empty");

    }else if(selectedCrop == null){
      StaticValues.errorSnackBar(context, "Crop can't be empty");

    }
    else{



      showAlertDialog(context);


      // String name,String price,String weight,String description,String selectedSubCategory,String selectedUnit,String selectedAddressId,String imagePath

      http.Response  isUploaded = await ServiceMarket.addCropOnSale(quantity.text, charge.text, selectedAddress!, description.text, selectedCrop!);


      Navigator.pop(context);

      Map responseMap = jsonDecode(isUploaded.body);


      if(responseMap['success'] == true){

        StaticValues.successSnackBar(context, responseMap['message']);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ViewUserCropOnSale() ,)).then(
                (value) =>
                setState(() {
                  // Call setState to refresh the page.
                })
        );

      }else{

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ViewUserAgronomist() ,)).then(
                (value) =>
                setState(() {
                  // Call setState to refresh the page.
                })
        );


        StaticValues.successSnackBar(context, responseMap['message']);
      }

    }
  }

}


