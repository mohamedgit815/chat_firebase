import 'package:flutter/material.dart';

class BottomBarState extends ChangeNotifier {
  int count = 0;

  final List<Widget> pages = const [
    // MainHomeScreen() ,
    // MainFriendsScreen() ,
  ];

  int countState(int v) {
    notifyListeners();
    return count = v;
  }
}