import 'dart:io';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageState extends ChangeNotifier {
  File? fileImage;

  Future<void> getImagePicker({required BuildContext context,required ImageSource imageSource}) async {
    try {
      final XFile? _image = await ImagePicker().pickImage(source: imageSource);

      if (_image != null) {
        fileImage = File(_image.path);
      }
      else{
        customSnackBar(text: 'your arn\'t selected Image', context: context);
      }
      notifyListeners();
    }on PlatformException catch(_){
      customSnackBar(text: 'your arn\'t selected Image', context: context);
    }
  }

  void deleteImagePicker(){
    fileImage = null;
    notifyListeners();
  }
}