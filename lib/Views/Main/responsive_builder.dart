import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

class ResponsiveBuilderScreen extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? deskTop;
  const ResponsiveBuilderScreen({Key? key,required this.mobile,this.tablet,this.deskTop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (BuildContext context,size){
          if(size.deviceScreenType == DeviceScreenType.desktop){
            return deskTop ?? mobile;
          } else if(size.deviceScreenType == DeviceScreenType.tablet){
            return tablet ?? mobile;
          } else {
            return mobile;
          }
        }
    );
  }
}