import 'package:chat_app/Helper/Constance/const_state.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomText extends StatelessWidget {
  final String text;
  final int? maxLine;
  final TextStyle? style;
  final TextOverflow? overflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? decoration;

  const CustomText({
    Key? key,
    this.decoration,
    required this.text,
    this.maxLine,
    this.style,
    this.overflow,
    this.fontSize,
    this.fontWeight,
    this.color,
  }) : super(key: key);

  @override
  Text build(BuildContext context) {

    return Text(
          text ,
          //textDirection: TextDirection.ltr,
          style: style ??  TextStyle(
              fontFamily: 'lato',
              fontSize: fontSize ?? 15.0,
              fontWeight: fontWeight ,
              color: color,
              decoration: decoration ?? TextDecoration.none
          ),
          textScaleFactor: 1.0 ,
          maxLines: maxLine ?? 1 ,
          overflow: overflow ?? TextOverflow.ellipsis
    );
  }
}

class AnimatedText extends StatelessWidget {
  final String text;
  final int? maxLine;
  final TextStyle? style;
  final TextOverflow? overflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? decoration;
  const AnimatedText({Key? key,this.decoration,required this.text, this.maxLine, this.style, this.overflow, this.fontSize, this.fontWeight, this.color,}) : super(key: key);

  @override
  AnimatedDefaultTextStyle build(BuildContext context) {
    return AnimatedDefaultTextStyle(
        child: Text(
            text,
          textScaleFactor: 1.0 ,
        ),

        maxLines: maxLine ?? 1 ,
        style: style ?? TextStyle(
            fontFamily: 'Poppins',
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight ,
            overflow: overflow ?? TextOverflow.ellipsis ,
            decoration: decoration ?? TextDecoration.none
        ),
        duration: const Duration(milliseconds: 300),
    );
  }

}


ScaffoldMessengerState customSnackBar({
  required String text,
  required BuildContext context ,
  final BorderRadius? borderRadius ,
  final EdgeInsets? padding ,
  final Duration? duration ,
  final SnackBarAction? snackBarAction
}) {
  return ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(
      SnackBar(
          content: CustomText(text: text),
          shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(0.0)),
          padding: padding ,
          duration: duration ?? const Duration(seconds: 1) ,
          action: snackBarAction
      ));
}


Future<void> customAlertDialog({
  required VoidCallback onPressed ,
  required BuildContext context
}){
  return showDialog(context: context, builder: (buildContext)=>AlertDialog(
    title: CustomText(text: '${context.translate!.translate(MainEnum.textSure.name)}'),
    actions: [
      CustomElevatedButton(
          onPressed: (){
        Navigator.pop(context);
      }, child: Text('${context.translate!.translate(MainEnum.textNo.name)}')),
      CustomElevatedButton(
          onPressed: onPressed, child: Text('${context.translate!.translate(MainEnum.textYes.name)}')),
    ],
  ));
}

Future<void> customModalBottomSheet({
  required Widget widgets ,
  required BuildContext context
}) async {
  return await showModalBottomSheet(context: context, builder: (buildContext)=>widgets);
}

ScaffoldMessengerState customMaterialBanner({
  required BuildContext context ,
  required String text ,
  required List<Widget> actions ,
  Widget? leading
}) {
  return ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(MaterialBanner(
        leading: leading ,
        content: Text(text) ,
        actions: actions
    ));
}


Future<bool> customExitApp({required DateTime dateTime}) async {
  final Duration varDifference = DateTime.now().difference(dateTime);
  final isExitWarning = varDifference >= const Duration(seconds: 2);
  dateTime = DateTime.now();

  if(isExitWarning){
    await Fluttertoast.showToast(msg: 'Press back again to exit',fontSize: 17.0);
    return false;
  }else{
    await Fluttertoast.cancel();
    return true;
  }
}