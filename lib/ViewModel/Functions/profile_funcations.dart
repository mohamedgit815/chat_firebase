import 'dart:io';
import 'dart:math';
import 'package:chat_app/Helper/Constance/const_firebase.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_button.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/ViewModel/State/image_state.dart';
import 'package:chat_app/ViewModel/State/switch_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class FunctionsProfile {
  /// Names
  static Future<void> _updateNames({required String first, required String last ,required String bio}) async {

    await fireStore.collection(fireStoreUser).doc(firebaseId).update({
      "first": first ,
      "last": last ,
      'bio' : bio
    });
  }

  static Future<void> _updateLastBio({required String last ,required String bio}) async {
    await fireStore.collection(fireStoreUser).doc(firebaseId).update({
      "last": last ,
      'bio' : bio
    });
  }

  static Future<void> _updateFirstBio({required String first,required String bio}) async {
    await fireStore.collection(fireStoreUser).doc(firebaseId).update({
      "first": first ,
      'bio' : bio
    });
  }

  static Future<void> _updateFirstLast({required String first, required String last}) async {
    await fireStore.collection(fireStoreUser).doc(firebaseId).update({
      "first": first ,
      "last": last ,
    });
  }

  static Future<void> _updateFirst(String first) async {
    await fireStore.collection(fireStoreUser).doc(firebaseId).update({
      "first": first
    });
  }

  static Future<void> _updateLast(String last) async {
    await fireStore.collection(fireStoreUser).doc(firebaseId).update({
      "last": last
    });
  }

  static Future<void> _updateBio(String bio) async {
    await fireStore.collection(fireStoreUser).doc(firebaseId).update({
      'bio' : bio
    });
  }
  /// Names


  /// Images
  static Future<void> _uploadImage({required File file}) async {
    final int _random = Random().nextInt(100000);
    late String _image = '';

    final Reference _storage = fireStorage.ref('$fireStoreUser/$firebaseId/$_random${file.path.split('/').last}');
    final UploadTask _getUrl = _storage.putFile(file);
    _image = await (await _getUrl).ref.getDownloadURL();
    await fireStore.collection(fireStoreUser).doc(firebaseId).update({
      "image": _image
    });
  }
  /// Images


  /// Router
  static Future<void> _nextRouter(BuildContext context) async {
     await Navigator.pushNamedAndRemoveUntil(context, '', (route) => false);
  }
  /// Router


  /// Uploaded Profile
    static Future<void> uploadedProfile({
      required BuildContext context,required String first ,
      required String last, required String bio,
      required WidgetRef widgetRef , required GlobalKey<FormState> globalKey ,
      required ChangeNotifierProvider<ImageState> provImage ,
      required UserModel userModel ,
      required ChangeNotifierProvider<SwitchState> indicatorState
}) async {
    FocusScope.of(context).unfocus();
    if(globalKey.currentState!.validate()){
      widgetRef.read(indicatorState).falseSwitch();
      if(
      widgetRef.read(provImage).fileImage != null
          && bio != userModel.bio
          && first != userModel.first
          && last != userModel.last
      ){
        await _uploadImage(file: widgetRef.read(provImage).fileImage!);
        await _updateNames(first: first, last: last, bio: bio);
        customSnackBar(text: 'Data Uploaded', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);
      } else if(
      widgetRef.read(provImage).fileImage == null
          && bio != userModel.bio
          && first != userModel.first
          && last != userModel.last
      ){
        await _updateNames(first: first, last: last, bio: bio);
        customSnackBar(text: 'Data Uploaded', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);
      } else if(
      widgetRef.read(provImage).fileImage != null
          && bio == userModel.bio
          && first != userModel.first
          && last != userModel.last
      ){
        await _uploadImage(file: widgetRef.read(provImage).fileImage!);
        await _updateFirstLast(first: first, last: last);
        customSnackBar(text: 'First Last and Image Uploaded', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);
      } else if(
      widgetRef.read(provImage).fileImage != null
          && bio != userModel.bio
          && first == userModel.first
          && last != userModel.last
      ){
        await _uploadImage(file: widgetRef.read(provImage).fileImage!);
        await _updateLastBio(last: last, bio: bio);
        customSnackBar(text: 'Last Bio and Image Uploaded', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);
      } else if(
      widgetRef.read(provImage).fileImage != null
          && bio != userModel.bio
          && first != userModel.first
          && last == userModel.last
      ) {
        await _uploadImage(file: widgetRef.read(provImage).fileImage!);
        await _updateFirstBio(first: first, bio: bio);
        customSnackBar(text: 'First Bio and Image Uploaded', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);
      } else if(
      widgetRef.read(provImage).fileImage == null
          && bio == userModel.bio
          && first != userModel.first
          && last != userModel.last
      ){
        await _updateFirstLast(first: first, last: last);
        customSnackBar(text: 'First and Last Uploaded', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);
      } else if(
      widgetRef.read(provImage).fileImage == null
          && bio != userModel.bio
          && first == userModel.first
          && last != userModel.last
      ){
        await _updateLastBio(last: last, bio: bio);
        customSnackBar(text: 'Last and Bio Uploaded', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);
      } else if(
      widgetRef.read(provImage).fileImage == null
          && bio != userModel.bio
          && first != userModel.first
          && last == userModel.last
      ){
        await _updateFirstBio(first: first, bio: bio);
        customSnackBar(text: 'First and Bio Uploaded', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);
      } else if(
      widgetRef.read(provImage).fileImage != null
          && bio == userModel.bio
          && first == userModel.first
          && last != userModel.last
      ){
        await _uploadImage(file: widgetRef.read(provImage).fileImage!);
        await _updateLast(last);
        customSnackBar(text: 'Image and Last Uploaded', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);
      } else if (
      widgetRef.read(provImage).fileImage != null
          && bio == userModel.bio
          && first != userModel.first
          && last == userModel.last
      ){
        await _uploadImage(file: widgetRef.read(provImage).fileImage!);
        await _updateFirst(first);
        customSnackBar(text: 'Image and First Uploaded ', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);
      } else if(
      widgetRef.read(provImage).fileImage != null
          && bio != userModel.bio
          && first == userModel.first
          && last == userModel.last
      ){
        await _uploadImage(file: widgetRef.read(provImage).fileImage!);
        await _updateBio(bio);
        customSnackBar(text: 'Image and Bio Uploaded', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);
      } else if(
      widgetRef.read(provImage).fileImage != null
          && bio == userModel.bio
          && first == userModel.first
          && last == userModel.last
      ){
        await _uploadImage(file: widgetRef.read(provImage).fileImage!);
        customSnackBar(text: 'Image Uploaded', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);
      } else if(
      widgetRef.read(provImage).fileImage == null
          && bio != userModel.bio
          && first == userModel.first
          && last == userModel.last
      ){
        await _updateBio(bio);
        customSnackBar(text: 'Bio Uploaded', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);
      } else if(
      widgetRef.read(provImage).fileImage == null
          && bio == userModel.bio
          && first != userModel.first
          && last == userModel.last
      ){
        await _updateFirst(first);
        customSnackBar(text: 'First Uploaded', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);
      } else if(
      widgetRef.read(provImage).fileImage == null
          && bio == userModel.bio
          && first == userModel.first
          && last != userModel.last
      ){
        await _updateLast(last);
        customSnackBar(text: 'Last Uploaded', context: context);
        widgetRef.read(indicatorState).trueSwitch();
        return await _nextRouter(context);

      }else {
        widgetRef.read(indicatorState).trueSwitch();
        customSnackBar(text: 'Not Uploaded', context: context);
         return await _nextRouter(context);
      }

    }
    widgetRef.read(indicatorState).trueSwitch();
    }
  /// Uploaded Profile




  static Future<void> deleteProfile({
    required ChangeNotifierProvider<ImageState> provImage,
    required WidgetRef imageProv, required BuildContext context
  }) async {
    if(imageProv.read(provImage).fileImage != null){
      showDialog(context: context, builder:(BuildContext context){
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceAround,
          title: const CustomText(text: 'Are your sure ?',),
          actions: [
            Center(
              child: CustomElevatedButton(onPressed: (){
                imageProv.read(provImage).deleteImagePicker();
                Navigator.maybePop(context);
              }, child: const CustomText(text: 'Delete All',)),
            ),


            Center(
              child: CustomElevatedButton(onPressed: (){
                imageProv.read(provImage).deleteImagePicker();
                Navigator.maybePop(context);
              }, child: const CustomText(text: 'Delete Image',)),
            ),


            Center(
              child: CustomElevatedButton(onPressed: (){
                Navigator.maybePop(context);
              }, child: const CustomText(text: 'Delete BigImage',)),
            ),
          ],
        );
      });
    } else if(imageProv.read(provImage).fileImage != null){
      imageProv.read(provImage).deleteImagePicker();
    }
  }


  static Future<bool> willPopScope({
    required BuildContext context,required WidgetRef ref,
    required ChangeNotifierProvider<ImageState> provImage ,
    required String  first, required String last,
    required GlobalKey<FormState> globalKey ,
    required String bio, required UserModel userModel ,
    required ChangeNotifierProvider<SwitchState> indicatorState

  }) async {
    if(ref.read(provImage).fileImage == null){
      return true;
    } else {
      return await showDialog(
          context: context,
          builder: (BuildContext context) {
              return AlertDialog(
                title: const CustomText(text: 'Are your Sure?'),
                actions: [
                  CustomElevatedButton(
                    onPressed: () async {
                      ref.read(provImage).deleteImagePicker();
                       await Navigator.pushNamedAndRemoveUntil(context,
                           'MainBottomBarScreen.bottomBar', (route) => false);
                     },
                    child: const CustomText(text: 'Back and Cancel',),
                  ),

                  CustomElevatedButton(
                    onPressed: () async {
                      return await FunctionsProfile.uploadedProfile(
                        context: context,
                        first: first,
                        last: last,
                        widgetRef: ref,
                        globalKey: globalKey,
                        provImage: provImage,
                        bio: bio ,
                        userModel: userModel ,
                        indicatorState: indicatorState
                      );
                    },
                    child: const CustomText(text: 'Update',),
                  )
                ],
              );
          }
      );
    }
  }
}