import 'package:chat_app/Views/Main/responsive_builder.dart';
import 'package:chat_app/Views/View/Requests/mobile_requests_page.dart';
import 'package:flutter/material.dart';

class MainRequestsScreen extends StatelessWidget {
  static const String requests = '/MainRequestsScreen';
  const MainRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveBuilderScreen(
        mobile: MobileRequestsPage()
    );
  }
}
