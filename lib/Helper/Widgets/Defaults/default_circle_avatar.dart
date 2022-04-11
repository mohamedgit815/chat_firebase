import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:flutter/material.dart';

class DefaultCircleAvatar extends StatelessWidget {
  final UserModel userModel;
  final Color? color , textColor;
  final double? radius;
  final ValueKey? valueKey;

  const DefaultCircleAvatar({Key? key,
    required this.userModel,
    this.color,
    this.textColor ,
    this.radius ,
    this.valueKey
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      key: valueKey,
      radius: radius ?? 40.0,
      backgroundColor: userModel.image.isEmpty ? color ?? lightMainColor : null,
      backgroundImage: userModel.image.isEmpty ? null : NetworkImage(userModel.image) ,
      child: CustomText(
          text: userModel.first.substring(0,1).toString(),fontSize: 20.0,
          color: textColor??normalWhite ,
        key: valueKey,
      ),
    );
  }
}
