import 'dart:convert';
import 'dart:io';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/vendors/insuarance/view_user_insurance.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:textfields/textfields.dart';

import '../../../../services/add_Edit_Delete_Update_vendor_services.dart';
import '../../../../services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../../../../static/static_values.dart';

class AddInsurance extends StatefulWidget {
  const AddInsurance({Key? key}) : super(key: key);

  @override
  State<AddInsurance> createState() => _AddInsuranceState();
}



class _AddInsuranceState extends State<AddInsurance> {




  TextEditingController terms = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController name = TextEditingController();
  String? selectedAddress;
  List address_data = [];


  Future<String> selectAddress() async {

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse(StaticValues.mainApiUrl+"user/my-addresses"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    print(resBody);

    setState(() {
      address_data = resBody['data'];
    });


    return "Sucess";
  }


  String? path;

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




  final controller = MultiImagePickerController(
    maxImages: 1,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );


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




  @override
  void initState()  {
    super.initState();

    selectAddress();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.barColor,
        title: const Text("Add Insurance"),
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
                                labelText: 'Company name',
                                hintText: 'Company name',
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(15),
                            child: TextField(
controller: terms,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Terms',
                                hintText: 'Terms',
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
                            padding: const EdgeInsets.all(15.0),
                            child: MultiLineTextField(
                              maxLines: 10,
                              controller: description,
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


                          )



                          ,Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                                ),
                                onPressed: () async {
                                  await addInsurance(context);



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

  Future<void> addInsurance(BuildContext context) async {
       showAlertDialog(context);

                                  if(terms.text.isEmpty){
      StaticValues.errorSnackBar(context, "Terms can't be empty");
    }else if(description.text.isEmpty){
      StaticValues.errorSnackBar(context, "Descriptions can't be empty");
    }else if(image?.path! == null){
      StaticValues.errorSnackBar(context, "Image can't be empty");
    }
      else if(selectedAddress == null){
      StaticValues.errorSnackBar(context, "Address can't be empty");
       }

      else{



      // String name,String price,String weight,String description,String selectedSubCategory,String selectedUnit,String selectedAddressId,String imagePath

      http.Response isUploaded = await AddVendorService.addInsurance(name.text,terms.text, description.text, image?.path,selectedAddress.toString());


      Navigator.pop(context);


      Map responseMap = jsonDecode(isUploaded.body);


      if(responseMap['success'] == true){

        StaticValues.successSnackBar(context, responseMap['message']);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ViewUserInsurance() ,)).then(
                (value) =>
                setState(() {
                  // Call setState to refresh the page.
                })
        );

      }else{
        StaticValues.errorSnackBar(context, responseMap['message']);
      }

    }
  }
}
