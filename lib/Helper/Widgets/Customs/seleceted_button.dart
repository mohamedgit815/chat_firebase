import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:flutter/material.dart';

class SelectedButton extends StatelessWidget {
  final bool select ;
  final ValueChanged<bool>? onSelected ;
  final Widget child;
  const SelectedButton({Key? key,required this.child,required this.onSelected,required this.select}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: const Visibility(
          visible: false,
          child: CustomText(text: '')) ,
      selected: select ,
      onSelected: onSelected
    );
  }
}