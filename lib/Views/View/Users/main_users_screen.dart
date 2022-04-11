import 'package:chat_app/Views/Main/responsive_builder.dart';
import 'package:chat_app/Views/View/Users/mobile_users_page.dart';
import 'package:flutter/material.dart';

class MainUsersScreen extends StatelessWidget {
//  final String id;
  static const String users = '/MainPeopleScreen';
  const MainUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileUsersPage()
    );
  }
}
