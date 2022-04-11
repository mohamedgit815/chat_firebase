import 'package:flutter/material.dart';


class SwitchState extends ChangeNotifier{
  bool varSwitch = true;
  late String value = '';
  int maxLine = 3;

  int switchMaxLine(){
    notifyListeners();

    if(maxLine == 3){
      return maxLine = 1024;
    } else if(maxLine == 1024) {
      return maxLine = 3;
    }
    return maxLine;
  }

  int maxLine1024() {
    notifyListeners();
    return maxLine = 1024;
  }

  int maxLine3() {
    notifyListeners();
    return maxLine = 3;
  }

  String funcChange(String v){
    notifyListeners() ;
    return value = v;
  }

  void equalNull(){
     value = '';
     notifyListeners();
  }

  bool funcSwitch(){
   notifyListeners();
    return varSwitch = !varSwitch;
  }

  bool trueSwitch(){
   notifyListeners();
   return varSwitch = true;
  }

  bool falseSwitch(){
    notifyListeners();
    return varSwitch = false;
  }

}