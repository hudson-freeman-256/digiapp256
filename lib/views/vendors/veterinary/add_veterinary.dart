import 'dart:convert';
import 'dart:io';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/vendors/veterinary/view_user_veterinary.dart';
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
import '../animalfeed/view_animal_feeds.dart';

class AddVeterinary extends StatefulWidget {
  const AddVeterinary({Key? key}) : super(key: key);

  @override
  State<AddVeterinary> createState() => _AddVeterinaryState();
}



class _AddVeterinaryState extends State<AddVeterinary> {




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
  TextEditingController expertise = TextEditingController();
  TextEditingController availability = TextEditingController();
  TextEditingController description = TextEditingController();

  // ,price,weight,description;

  List crop_data = [];


  String? cropid;


  //variable for choosed file


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











  Future<String> selectCrop() async {

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"animal_categories"),
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
  void initState()  {
    super.initState();

    selectCrop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.barColor,
        title: const Text("Add Veterinary"),
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
                              controller: charge,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'charge',
                                hintText: 'charge',
                              ),
                            ),
                          ),




                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text(
                                  'Select Availability',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme
                                        .of(context)
                                        .hintColor,
                                  ),
                                ),
                                items: ava
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
                                value: selectedAvailability,
                                onChanged: (value) {
                                  setState(() {
                                    selectedAvailability = value as String;
                                  });
                                },
                                buttonHeight: 40,
                                buttonWidth: MediaQuery.of(context).size.width,
                                itemHeight: 40,
                              ),
                            ),
                          ),


                          // availability

                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text(
                                  'Select Animal Category',
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
                                        item['name'],    //Names that the api dropdown contains
                                        style: TextStyle(
                                          fontSize: 13.0,
                                        ),
                                      ),
                                      value: item['id'].toString()       //Id that has to be passed that the dropdown has.....
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
                                buttonWidth: MediaQuery.of(context).size.width,
                                itemHeight: 40,
                              ),
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: MultiLineTextField(
                              controller: expertise,
                              maxLines:5,
                              bordercolor: Colors.grey,
                              label: "Expertise",
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
                                      : GestureDetector(child: Image.asset("assets/upload.png", height: 100),
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


                          )



                          ,Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                                ),
                                onPressed: () async {


                                  await AddAnimalFeeds(context);



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

  Future<void> AddAnimalFeeds(BuildContext context) async {
    if(name.text.isEmpty){
      StaticValues.errorSnackBar(context, "Name can't be empty");

    } else    if(charge.text.isEmpty){
      StaticValues.errorSnackBar(context, "Charge can't be empty");

    }else    if(expertise.text.isEmpty){
      StaticValues.errorSnackBar(context, "Expertise can't be empty");

    }else    if(description.text.isEmpty){
      StaticValues.errorSnackBar(context, "Description can't be empty");

    }else    if(selectedAvailability == null){
      StaticValues.errorSnackBar(context, "Availability can't be empty");

    }
    else{



      showAlertDialog(context);


      // String name,String price,String weight,String description,String selectedSubCategory,String selectedUnit,String selectedAddressId,String imagePath

      http.Response  isUploaded = await AddVendorService.addVeterinary(name.text, expertise.text, charge.text, description.text, selectedAvailability!, selectedCrop!, image?.path);


      Navigator.pop(context);

      Map responseMap = jsonDecode(isUploaded.body);


      if(responseMap['success'] == true){

        StaticValues.successSnackBar(context, responseMap['message']);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ViewUserVeterinary() ,)).then(
                (value) =>
                setState(() {
                  // Call setState to refresh the page.
                })
        );

      }else{
        StaticValues.successSnackBar(context, responseMap['message']);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ViewUserVeterinary() ,)).then(
                (value) =>
                setState(() {
                  // Call setState to refresh the page.
                }));
      }

    }
  }

// Widget _buildImage() {
//   if (_image == null) {
//     return Padding(
//
//       padding: EdgeInsets.all(5),
//       child: Icon(
//         Icons.add,
//         color: Colors.grey,
//       ),
//     );
//   } else {
//     return Text(_image.path);
//   }
// }
}


