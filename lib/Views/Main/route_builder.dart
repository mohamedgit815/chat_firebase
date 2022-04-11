import 'package:chat_app/Views/Authentications/ForgetAccount/main_reset_screen.dart';
import 'package:chat_app/Views/Authentications/Login/main_login_screen.dart';
import 'package:chat_app/Views/Authentications/SignUp/main_signup_screen.dart';
import 'package:chat_app/Views/Main/tabbar_screen.dart';
import 'package:chat_app/Views/Profile/Profile/main_profile_screen.dart';
import 'package:chat_app/Views/Profile/ProfileMe/main_profileme_screen.dart';
import 'package:chat_app/Views/View/Block/main_block_screen.dart';
import 'package:chat_app/Views/View/Chat/main_chat_screen.dart';
import 'package:chat_app/Views/View/Requests/main_requests_screen.dart';
import 'package:flutter/material.dart';

class RouteBuilder {
  static final Map<String , WidgetBuilder> routes = <String , WidgetBuilder>{
    TabBarScreen.tabBar : (BuildContext context)=> const TabBarScreen() ,
    MainRequestsScreen.requests : (BuildContext context)=> const MainRequestsScreen() ,
    MainLoginScreen.login : (BuildContext context)=> const MainLoginScreen() ,
    MainChatScreen.chat : (BuildContext context)=> const MainChatScreen() ,
    MainBlockScreen.block : (BuildContext context)=> const MainBlockScreen() ,
    MainProfileMeScreen.profileMe : (BuildContext context)=> const MainProfileMeScreen() ,
    MainProfileScreen.profile : (BuildContext context)=> const MainProfileScreen() ,
    MainSignUpScreen.signUp : (BuildContext context)=> const MainSignUpScreen() ,
    MainResetScreen.reset : (BuildContext context)=> const MainResetScreen() ,
  };
}