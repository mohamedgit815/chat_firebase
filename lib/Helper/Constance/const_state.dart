import 'dart:async';
import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_firebase.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/ViewModel/Functions/auth_functions.dart';
import 'package:chat_app/ViewModel/Functions/home_functions.dart';
import 'package:chat_app/ViewModel/State/lang_state.dart';
import 'package:chat_app/ViewModel/State/theme_state.dart';
import 'package:chat_app/Views/Main/localizations.dart';
import 'package:chat_app/Views/Main/tabbar_screen.dart';
import 'package:chat_app/Views/View/Chat/main_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// Main Enum Applications
enum MainEnum{
  /// The Main Languages in The Application
  english , arabic , espanol ,

  /// Text Languages
  textProfile , textHome , textAccount , textLogOut , textChange , textUpdate ,
  textSetting , textSure , textYes , textNo , textChooseLang , textChat , textPost ,
  textWrite , textDelete , textPeople , textAccept , textRefused , textRequests ,
  textFriends , textMessage , textBlock , textName , textBio , textEmail , textBioHere,
  textYou ,

}

/// Extension
extension MainContext on BuildContext {
  AppLocalization? get translate => AppLocalization.of(this);
  ThemeData get theme => Theme.of(this);
  ModalRoute<Object?>? get modal => ModalRoute.of(this);
  bool get keyBoard => MediaQuery.of(this).viewInsets.bottom == 0;
  Size get mainSize => MediaQuery.of(this).size;
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}


/// Firebase Message
class FirebaseMessage {

  static StreamSubscription<RemoteMessage> onMessage(BuildContext context ) {
    return FirebaseMessaging.onMessage.listen((event) {

      fireStore.collection(fireStoreUser).doc(event.notification!.body)
          .snapshots().listen((DocumentSnapshot<Map<String,dynamic>> value) {
            final UserModel _userModel = UserModel.fromApp(value.data()!);


        if(value.data()!['page'] == true) {return;}


        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                backgroundColor: Colors.teal,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text:'${event.notification!.title}' , color: normalWhite,),
                    CustomText(text:'${event.notification!.body}',color: normalWhite,),
                  ],
                ), actions: [
              IconButton(onPressed: (){
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              }, icon: const Icon(Icons.close,color: normalWhite,)) ,


              IconButton(
                  onPressed: () {

                    Navigator.pushNamed(context, MainChatScreen.chat,arguments: _userModel);

                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

                  }, icon: const Icon(Icons.navigate_next,color: normalWhite)) ,
            ]
            ));


      });

    });
  }

  static StreamSubscription<RemoteMessage> onMessageOpenedApp(BuildContext context) {
    return FirebaseMessaging.onMessageOpenedApp.listen((event) {

      Navigator.of(context).pushNamedAndRemoveUntil(TabBarScreen.tabBar, (route) => false);


    });
  }

}

/// State
final themeProv = ChangeNotifierProvider((ref)=>ThemeState());
final langProv = ChangeNotifierProvider((ref)=>LangState());
final myDataProv = StreamProvider((ref)=>AuthFunctions.getUserData());
final fetchHomeProv = FutureProvider((ref)=>HomeFunctions.fetchHomeData());
