import 'dart:convert';
import 'dart:io';

import 'package:digifarmer/services/add_Edit_Delete_Update_vendor_services.dart';
import 'package:digifarmer/static/color.dart';
import 'package:digifarmer/views/vendors/farmequipment/view_user_farm_equipment.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:textfields/textfields.dart';

import '../../../../services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../../../../static/static_values.dart';

class AddFarmEquipment extends StatefulWidget {
  const AddFarmEquipment({Key? key}) : super(key: key);

  @override
  State<AddFarmEquipment> createState() => _AddFarmEquipmentState();
}



class _AddFarmEquipmentState extends State<AddFarmEquipment> {

  List address_data = [];
  List seller_category_data = [];
  List animal_sub_category_data = [];

  String? addressid;
  String? animal_cate_id;

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController stock_amount =TextEditingController();
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

  Future<String> selectSellerId() async {

    final String bearerToken = AuthService.token;

    var res = await http.get(
        Uri.parse("https://digifarmer.agrosahas.co/farmerapp/public/api/v1/seller_product_categories"),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          "Accept": "application/json"}); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);
    print(resBody);

    setState(() {
      seller_category_data = resBody['data'];
    });


    return "Sucess";
  }

  // /vendor_categories/{id}/animal_feeds


  // /animal_categories

  selectedCategoryId(String id) async {

    animal_cate_id = id;

  }




  String? path;

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  final List<String> unit = [
    'Kg',
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
    selectSellerId();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.barColor,
        title: const Text("Add Farm Equipment"),
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

                          // stock_amount
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
                              controller: price,
                               keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Price',
                                hintText: 'price',
                              ),
                            ),
                          ),




                          Padding(
                            padding: EdgeInsets.all(15),
                            child: TextField(
                              controller: stock_amount,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Stock',
                                hintText: 'Stock',
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
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text(
                                  'Select Seller Category',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme
                                        .of(context)
                                        .hintColor,
                                  ),
                                ),
                                items: seller_category_data.map((item) {
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
                              controller: discription,
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


                          )



                          ,Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(CustomColors.barColor)
                                ),
                                onPressed: () async {


                                  await addFarmEquipment(context);



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

  Future<void> addFarmEquipment(BuildContext context) async {
        if(price.text.isEmpty){
      StaticValues.errorSnackBar(context, "Price can't be empty");

    }else if(discription.text.isEmpty){
      StaticValues.errorSnackBar(context, "Description can't be empty");
    }else if(selectedAddress == null){
      StaticValues.errorSnackBar(context, "Address can't be empty");
    }else if(selectedCategory == null){
      StaticValues.errorSnackBar(context, "Seller Category can't be empty");
    }else if(image?.path == null){
      StaticValues.errorSnackBar(context, "Please select Image");
    }else{


          showAlertDialog(context);

      http.Response  isUploaded = await AddVendorService.addFarmEquipment(price.text,stock_amount.text,name.text, discription.text, selectedCategory.toString(), selectedAddress.toString(), image?.path);


      Navigator.pop(context);
      Map responseMap = jsonDecode(isUploaded.body);

      if(responseMap['success'] == true){

        StaticValues.successSnackBar(context, responseMap['message']);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ViewUserFarmEquipment() ,)).then(
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
