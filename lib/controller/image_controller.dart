import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class ImageController extends GetxController{

  File? _image;
  PickedFile? _pickedFile;
  PickedFile? get pickedFile => _pickedFile;
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _pickImage() async {
    _pickedFile=
    await _picker.getImage(source: ImageSource.gallery);
        update();
    }


}