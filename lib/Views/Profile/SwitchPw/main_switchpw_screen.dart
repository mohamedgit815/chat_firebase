import 'package:chat_app/Views/Main/responsive_builder.dart';
import 'package:chat_app/Views/Profile/SwitchPw/mobile_switchpw_page.dart';
import 'package:flutter/material.dart';

class MainSwitchPwScreen extends StatelessWidget {
  static const String switchPw = '/MainSwitchPwScreen';
  const MainSwitchPwScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(mobile:MobileSwitchPwPage());
  }
}
