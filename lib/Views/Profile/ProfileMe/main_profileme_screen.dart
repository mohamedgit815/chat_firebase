import 'package:chat_app/Views/Main/responsive_builder.dart';
import 'package:chat_app/Views/Profile/ProfileMe/mobile_profileme_page.dart';
import 'package:flutter/material.dart';


class MainProfileMeScreen extends StatelessWidget {
  static const String profileMe = '/MainProfileMeScreen';
  const MainProfileMeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileProfileMePage()
    );
  }
}
