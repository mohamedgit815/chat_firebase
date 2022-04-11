import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:flutter/material.dart';

class DefaultAuthFormField extends StatelessWidget {
  final String hintText;
  final bool? password;
  final Widget? suffixIcon;
  final TextInputAction inputAction ;
  final TextInputType inputType;
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String> validator;

  const DefaultAuthFormField({
    Key? key,
    required this.hintText ,
    required this.controller ,
    required this.validator ,
    required this.inputType ,
    required this.inputAction ,
    this.onSubmitted ,
    this.suffixIcon ,
    this.password
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _outlineInputBorder({double? circle}){
      return OutlineInputBorder(
          borderRadius: BorderRadius.circular(circle ?? 25.0) ,
          borderSide: const BorderSide(
              color:normalWhite
          )
      );
    }

    return TextFormField(
      controller: controller ,
      keyboardType: inputType ,
      textInputAction: inputAction ,
      obscureText: password ?? false ,
      cursorColor: normalWhite ,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      style: const TextStyle(color: normalWhite) ,
      decoration: InputDecoration(
        filled: true ,
        fillColor: Colors.transparent ,
        hintText: hintText ,
        suffixIcon: suffixIcon ,
        focusedBorder: _outlineInputBorder() ,
        border: _outlineInputBorder() ,
        enabledBorder: _outlineInputBorder(),
        focusedErrorBorder: _outlineInputBorder(circle: 0.0) ,
        errorBorder: _outlineInputBorder(circle: 0.0) ,
        disabledBorder: _outlineInputBorder(circle: 0.0)
      ),
    );
  }
}
