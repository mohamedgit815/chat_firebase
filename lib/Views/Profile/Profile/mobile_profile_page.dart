import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_state.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Helper/Widgets/Defaults/default_add_person.dart';
import 'package:chat_app/Helper/Widgets/Defaults/default_circle_avatar.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    '';

class MobileProfilePage extends StatefulWidget {
  final UserModel userModel;
  const MobileProfilePage({Key? key,required this.userModel}) : super(key: key);

  @override
  _MobileProfilePageState createState() => _MobileProfilePageState();
}

class _MobileProfilePageState extends State<MobileProfilePage> with _MobileProfile{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: '${widget.userModel.first} ${widget.userModel.last}',
        fontSize: 18.0,
        ),
        centerTitle: true,
        actions: [
          SizedBox(
              width: 50.0,height: double.infinity,
              child: DefaultAddPerson(data: widget.userModel,color: normalWhite,))
        ],
      ),
      body: LayoutBuilder(
        builder:(context, constraints) =>  Column(
          children:  [

            const SizedBox(height: 15.0,),


            DefaultCircleAvatar(userModel: widget.userModel,radius: 60.0,),



            const SizedBox(height: 15.0,),


            Builder(
                builder: (context) {
                  return _buildListTile(
                      title: '${context.translate!.translate(MainEnum.textName.name)}',
                      subTitle: '${widget.userModel.first} ${widget.userModel.last}',
                      iconData: Icons.person ,
                  );
                }
            ) ,


            Builder(
                builder: (context) {
                  return _buildListTile(
                      title: '${context.translate!.translate(MainEnum.textEmail.name)}',


                      subTitle: widget.userModel.email ,
                      iconData:  Icons.email_outlined ,

                  );
                }
            ) ,

            Visibility(
              visible: widget.userModel.bio.isEmpty ? false : true,
              child: Builder(
                  builder: (context) {
                    return _buildListTile(
                      title: '${context.translate!.translate(MainEnum.textBio.name)}',

                      subTitle: widget.userModel.bio,
                      iconData: Icons.announcement_outlined ,

                    );
                  }
              ),
            )

          ],
        )
      ),
    );
  }
}

class _MobileProfile {

  ListTile _buildListTile({
    required String title , required String subTitle ,
    required IconData iconData ,
  }) {
    return ListTile(
      title: CustomText(text: title ,fontSize: 15.0,fontWeight: FontWeight.w100,color: normalGrey.shade500),
      subtitle: CustomText(text: subTitle,
        fontSize: 16.0,
        fontWeight: FontWeight.w100,
        color: normalBlack,
      ),
      leading: Icon(iconData,color: normalGrey.shade700,) ,
     // trailing: const Icon(CupertinoIcons.pencil),
    );
  }


  /// Build Alert Dialog

  AlertDialog _buildAlertDialog({
    required BuildContext context , required String title ,
    required VoidCallback onPressed
  }){
    return AlertDialog(
      title: Text(title),
      actions: [
        const TextField(
          decoration: InputDecoration(
              hintText: 'Enter your Name'
          ),
        ),

        Row(
          children: [
            MaterialButton(
              onPressed: onPressed ,
              child: const Text('Save') ,
            ),


            MaterialButton(
              onPressed: (){
                Navigator.maybePop(context);
              },child: const Text('Close'),),
          ],
        ),
      ],
    );
  }
}