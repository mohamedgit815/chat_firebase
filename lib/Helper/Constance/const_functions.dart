import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_regexp.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


Future<void> messageBackGround(RemoteMessage message) async {
  await Fluttertoast.showToast(msg: 'Google');
}

// initailMessage() async {
//   final RemoteMessage? _message = await firebaseMessaging.getInitialMessage();
//
// }

StreamSubscription<RemoteMessage> firebaseOnMessage(BuildContext context){
 return FirebaseMessaging.onMessage.listen((event) {
    if(event.notification != null) {
      Fluttertoast.showToast(msg: event.notification!.body.toString());
    }
      // ScaffoldMessenger.of(context).showMaterialBanner(
      //     MaterialBanner(
      //         backgroundColor: Colors.red,
      //         content: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             Visibility(
      //               visible: event.notification!.title!.isEmpty ? false : true,
      //               child: CustomText(
      //                   text: event.notification!.title.toString(),
      //                 fontSize: 15.0,
      //
      //               ),
      //             ) ,
      //
      //             Visibility(
      //                 visible: event.notification!.body!.isEmpty ? false : true,
      //                 child: CustomText(text: event.notification!.body.toString())) ,
      //
      //           ],
      //         ),
      //         actions: [
      //           CustomElevatedButton(onPressed: (){
      //         ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      //       }, child: const Text('close')) ,
      //         ])
      // );}
});
}


Future<http.Response> sendMessage({
  required String id , required String title ,
  required String body , required String userToken}) async {
  const String _token = 'AAAAgyLrYvw:APA91bFj_9gGfoVAPIYsBdvmTYFke7MFp2otn_KKl1xzBklPWYXZ9KNohnoCFra-JieBZ34b08Ey435MuY5lKB_Ws97yeLPFFslEnDYv7QCrnS0IoB9H93sc6gI4ap7PePR00R7-OZpb';
  return await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  headers: <String,String>{
    'Content-Type':'application/json',
    'Authorization': 'key=$_token'
  },
  body: jsonEncode(<String,dynamic>{
    'notification': <String,String>{
      'title': title.toString(),
      'body': body.toString(),
    } ,
    'priority': 'high' ,
    'data' : {
      'click_action' : 'FLUTTER_NOTIFICATION_CLICK',
      'id': id.toString() ,
      'name': 'Mohamed',
      'last': 'Ragab',
    },
    'to': userToken
   // 'to': 'fTQQelA0RnWBfzdL76A-sk:APA91bH-6Lp9dHAnzJIjQP_25l9zWW2yQPCiYleMSMeiKUStmUJ39oThC_hkhzNH2V7-eAzzPqNUDl_Hz_26MrgMYtByN9kDvvThh9e3WbffiJ54hotJAAQSMH4nDjscod5B_GDZzyTA'
   // 'to': 'f-__WICVTt-jE-gvJfsx88:APA91bHFysPzK-aBr5Q7DZZjASD6IyyCYGgiCQEKOWpADvOqvtwSvDv-feuVANQNkwNte6_BL-HyJkdJ58RUIl_rFpqgqVcrb5ruFYrmpW7OZk0Red-CBco0iSPSHS2VHlNR_je3b2G5'
  })
  );
}

MaterialStateProperty<Color> materialStateColor(Color color){
  return MaterialStateProperty.all<Color>(color);
}

Center errorProvider(Object err){
  return Center(child: FittedBox(
      fit: BoxFit.scaleDown,
      child: CustomText(text: err.toString())),);
}

Center loadingProvider(){
  return const Center(child: CircularProgressIndicator.adaptive(),);
}

Visibility loadingVisibilityProvider(){
  return const Visibility(
    visible: false,
    child: CircularProgressIndicator.adaptive());
}

Center notFoundData(String text){
  return Center(child: FittedBox(
    fit: BoxFit.scaleDown,
    child: CustomText(
        text: text ,
      fontSize: 20.0,
      color: lightMainColor,
    ),
  ),);
}

class ConstNavigator {

  static Future<dynamic> backPageRouter(BuildContext context) async {
    return await Navigator.of(context).maybePop();
  }

  static Future<dynamic> pushNamedRouter({required String route ,required BuildContext context}) async {
    return await Navigator.of(context).pushNamed(route,);
  }

  static Future<dynamic> pushNamedAndReplaceRouter({required String route ,required BuildContext context}) async {
    return await Navigator.of(context).pushReplacementNamed(route);
  }

  static Future<dynamic> pushNamedAndRemoveRouter({required String route ,required BuildContext context}) async {
    return await Navigator.of(context).pushNamedAndRemoveUntil(route , (route) => false);
  }

}

class ConstValidator {
  static String? validatorName(String? v) {
    return !v!.contains(regExpName) ? 'Enter your Name by write form' : null ;
  }

  static String? validatorEmail(String? v) {
    return !v!.contains(regExpEmail) ? 'Enter your Email by write form' : null ;
  }

  static String? validatorPhone(String? v) {
    return !v!.contains(regExpPhone) ? 'Enter your Phone by write form' : null;
  }

  static String? validatorPw(String? v) {
    return !v!.contains(regExpPw) ? '[UpperCase , LowerCase , \$ ,# ,%]' : null;
  }
}