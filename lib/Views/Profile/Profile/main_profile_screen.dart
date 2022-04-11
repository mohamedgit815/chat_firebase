import 'package:chat_app/Helper/Constance/const_state.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/Views/Main/responsive_builder.dart';
import 'package:chat_app/Views/Profile/Profile/mobile_profile_page.dart';
import 'package:flutter/material.dart';

class MainProfileScreen extends StatelessWidget {
  static const String profile = '/MainProfileScreen';
  const MainProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModel _data = context.modal!.settings.arguments as UserModel;
    return ResponsiveBuilderScreen(
        mobile:MobileProfilePage(userModel: _data,)
    );
  }
}
