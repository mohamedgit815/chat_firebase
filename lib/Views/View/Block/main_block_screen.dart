import 'package:chat_app/Views/Main/responsive_builder.dart';
import 'package:chat_app/Views/View/Block/mobile_block_page.dart';
import 'package:flutter/material.dart';

class MainBlockScreen extends StatelessWidget {
  static const String block = '/MainBlockScreen';
  const MainBlockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileBlockPage()
    );
  }
}
