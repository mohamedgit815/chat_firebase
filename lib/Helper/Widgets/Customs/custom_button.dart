import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed ;
  final Widget child ;
  final EdgeInsets? padding ;
  final double? elevation ;
  final BorderRadius? borderRadius ;
  final Size? size ;
  final Color? backGroundColor ;

  const CustomTextButton({
    Key? key,
    this.padding,
    this.elevation,
    this.borderRadius,
    this.size,
    this.backGroundColor ,
    required this.onPressed,
    required this.child
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: padding,
          elevation: elevation,
          minimumSize: size,
          backgroundColor: backGroundColor,
          textStyle: const TextStyle(fontSize: 17.0),
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(0)
          ),
        ),
        onPressed: onPressed ,
        child: child
    );
  }
}



class CustomTextIconButton extends StatelessWidget {
  final VoidCallback onPressed ;
  final Widget child ;
  final Icon icon ;
  final EdgeInsets? padding ;
  final double? elevation ;
  final BorderRadius? borderRadius ;
  final Size? size ;
  final Color? backGroundColor ;

  const CustomTextIconButton({
    Key? key ,
    this.padding ,
    this.elevation ,
    this.borderRadius ,
    this.size ,
    this.backGroundColor ,
    required this.onPressed,
    required this.child ,
    required this.icon ,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: TextButton.styleFrom(
          padding: padding,
          elevation: elevation,
          minimumSize: size,
          backgroundColor: backGroundColor,
          textStyle: const TextStyle(fontSize: 17.0),
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(0)
          ),
        ),
        onPressed: onPressed ,
        icon: icon,
        label: child
    );
  }
}



class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed ;
  final Widget child ;
  final EdgeInsets? padding ;
  final double? elevation ;
  final BorderRadius? borderRadius ;
  final Size? size ;
  final Color? backGroundColor ;
  final BorderSide? borderSide ;

  const CustomOutlinedButton({
    Key? key,
    this.padding,
    this.elevation,
    this.borderRadius,
    this.size,
    this.backGroundColor ,
    required this.onPressed,
    required this.child,
    this.borderSide
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: padding,
          elevation: elevation,
          minimumSize: size,
          side: borderSide,
          backgroundColor: backGroundColor,
          textStyle: const TextStyle(fontSize: 17.0),
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(0)
          ),
        ),
        onPressed: onPressed ,
        child: child
    );
  }
}



class CustomOutlinedIconButton extends StatelessWidget {
  final VoidCallback onPressed ;
  final Widget child ;
  final Icon icon ;
  final EdgeInsets? padding ;
  final double? elevation ;
  final BorderRadius? borderRadius ;
  final Size? size ;
  final Color? backGroundColor ;
  final BorderSide? borderSide;

  const CustomOutlinedIconButton({
    Key? key,
    this.padding,
    this.elevation,
    this.borderRadius,
    this.size,
    this.backGroundColor ,
    required this.onPressed,
    required this.child,
    this.borderSide ,
    required this.icon
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        padding: padding,
        elevation: elevation,
        minimumSize: size,
        side: borderSide,
        backgroundColor: backGroundColor,
        textStyle: const TextStyle(fontSize: 17.0),
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(0)
        ),
      ) ,
      onPressed: onPressed ,
      icon: icon ,
      label: child ,
    );
  }
}



class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed ;
  final Widget child ;
  final EdgeInsets? padding ;
  final double? elevation ;
  final BorderRadius? borderRadius ;
  final Color? backGroundColor ;
  final Size? size ;

  const CustomElevatedButton({
    Key? key,
    this.padding,
    this.backGroundColor,
    this.elevation,
    this.borderRadius,
    this.size,
    required this.onPressed,
    required this.child,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          elevation: elevation,
          minimumSize: size,
          textStyle: const TextStyle(fontSize: 17.0),
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(0)
          ),
        ),
        onPressed: onPressed ,
        child: child
    );

  }
}



class CustomElevatedIconButton extends StatelessWidget {
  final VoidCallback onPressed ;
  final Widget child ;
  final Icon icon ;
  final EdgeInsets? padding ;
  final double? elevation ;
  final BorderRadius? borderRadius ;
  final Size? size ;
  final Color? backGroundColor ;
  final BorderSide? borderSide;


  const CustomElevatedIconButton({
    Key? key ,
    this.padding ,
    this.elevation ,
    this.borderRadius ,
    this.size ,
    this.backGroundColor ,
    required this.onPressed ,
    required this.child ,
    this.borderSide ,
    required this.icon
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: padding,
          elevation: elevation,
          minimumSize: size,
          textStyle: const TextStyle(fontSize: 17.0),
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(0)
          ),
        ),
        onPressed: onPressed ,
        icon: icon ,
        label: child
    );
  }
}