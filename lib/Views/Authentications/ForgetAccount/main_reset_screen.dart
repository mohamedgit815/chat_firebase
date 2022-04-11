import 'package:chat_app/Views/Authentications/ForgetAccount/mobile_reset_page.dart';
import 'package:chat_app/Views/Main/responsive_builder.dart';
import 'package:flutter/material.dart';

class MainResetScreen extends StatelessWidget {
  static const String reset = '/MainResetScreen';
  const MainResetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileResetPage()
    );
  }
}
