import 'package:chat_app/Views/Authentications/SignUp/mobile_signup_page.dart';
import 'package:chat_app/Views/Main/responsive_builder.dart';
import 'package:flutter/material.dart';

class MainSignUpScreen extends StatelessWidget {
  static const String signUp = '/MainSignUpScreen';
  const MainSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileSignUpPage()
    );
  }
}
