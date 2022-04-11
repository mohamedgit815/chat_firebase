import 'package:chat_app/Views/Main/responsive_builder.dart';
import 'package:chat_app/Views/View/Friends/mobile_friends_page.dart';
import 'package:flutter/material.dart';

class MainFriendsScreen extends StatelessWidget {
  static const String friends = '/MainFriendsScreen';


  const MainFriendsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileFriendsPage());
  }
}
