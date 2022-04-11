import 'package:chat_app/Views/Authentications/Login/mobile_login_page.dart';
import 'package:chat_app/Views/Main/responsive_builder.dart';
import 'package:flutter/material.dart';

class MainLoginScreen extends StatelessWidget {
  static const String login = '/MainLoginScreen';
  const MainLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileLoginPage()
    );
  }
}
