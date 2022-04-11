import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_firebase.dart';
import 'package:chat_app/Helper/Constance/const_functions.dart';
import 'package:chat_app/Helper/Constance/const_state.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileProfileMePage extends StatefulWidget {
  const MobileProfileMePage({Key? key}) : super(key: key);

  @override
  _MobileProfileMePageState createState() => _MobileProfileMePageState();
}

class _MobileProfileMePageState extends State<MobileProfileMePage>
with _MobileProfileMe {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true ,
          title: CustomText(
          text: '${context.translate!.translate(MainEnum.textProfile.name)}' ,
          fontSize: 20.0
      )),
      body: LayoutBuilder(
        builder:(context, constraints) => Consumer(
            builder: (context,prov,_)=> prov.watch(myDataProv).when(
                error: (err,stack)=> errorProvider(err),
                loading: ()=>loadingProvider() ,
              data: (data) {
                  final UserModel _data = UserModel.fromApp(data.data()!);
                return Column(
                children:  [

                  const SizedBox(height: 15.0,),


                  Stack(
                    children: [

                      const CircleAvatar(
                        radius: 60.0,
                      ),

                      Positioned(
                          bottom: 0,
                          left: 0.0,
                          child: CircleAvatar(
                            backgroundColor: lightMainColor,
                            child: IconButton(
                                onPressed: (){
                                  showModalBottomSheet(context: context, builder: (context)=>SizedBox(
                                    height: constraints.maxHeight *0.25,
                                    width: double.infinity,
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const CustomText(
                                                text: 'Profile Picture' ,
                                                fontSize: 18.0,

                                              ),

                                              IconButton(
                                                  onPressed: (){},
                                                  icon: const Icon(Icons.delete_outline,color: lightMainColor,))
                                            ],
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            TextButton.icon(
                                                onPressed: (){},
                                                icon: const Icon(Icons.camera_alt),
                                                label: const Text('Camera')) ,

                                            TextButton.icon(
                                                onPressed: (){},
                                                icon: const Icon(Icons.image),
                                                label: const Text('Gallery')) ,
                                          ],
                                        )
                                      ],
                                    ),
                                  ));
                                },
                                icon: const Icon(Icons.camera_alt,color: normalWhite)
                            ),
                          ))

                    ],
                  ) ,


                  const SizedBox(height: 15.0,),


                  Builder(
                      builder: (context) {
                        return _buildListTile(
                            title: '${context.translate!.translate(MainEnum.textName.name)}',
                            subTitle: '${_data.first} ${_data.last}',
                            iconData: Icons.person ,
                            onTap: () async {
                              _controllerFirst.text = _data.first;
                              _controllerLast.text = _data.last;
                              await showDialog(context: context, builder:(context)=> _buildAlertDialog(
                                  context: context,
                                  title: 'Enter your Name',
                                  onPressed: () async {
                                     await fireStore.collection(fireStoreUser)
                                        .doc(firebaseId).update({
                                      'first': _controllerFirst.text ,
                                      'last' : _controllerLast.text
                                    });
                                     Navigator.pop(context);
                                  },
                                  name: false
                              ));
                            }
                        );
                      }
                  ),



                  Builder(
                      builder: (context) {
                        return _buildListTile(
                            title: '${context.translate!.translate(MainEnum.textBio.name)}',
                            subTitle: _data.bio.isEmpty ? '${context.translate!.translate(MainEnum.textBioHere.name)}' : _data.bio,
                            iconData: Icons.announcement_outlined ,
                            onTap: () async {
                              if(_data.bio.isNotEmpty){
                                _controllerBio.text = _data.bio;
                              }
                              await showDialog(context: context, builder:(context)=> _buildAlertDialog(
                                  context: context ,
                                  title: '${context.translate!.translate(MainEnum.textBioHere.name)}' ,
                                  onPressed: () async {
                                    await fireStore.collection(fireStoreUser)
                                       .doc(firebaseId).update({
                                      'bio': _controllerBio.text
                                    });
                                   Navigator.pop(context);
                                  }, name: true
                              ));
                            }
                        );
                      }
                  ) ,

                ],
              );
              }
            )
        ),
      ),
    );
  }


}

class _MobileProfileMe {
  final TextEditingController _controllerBio = TextEditingController();
  final TextEditingController _controllerFirst = TextEditingController();
  final TextEditingController _controllerLast = TextEditingController();

  ListTile _buildListTile({
    required String title , required String subTitle ,
    required IconData iconData , required VoidCallback onTap
  }) {
    return ListTile(
      title: CustomText(text: title ,fontSize: 15.0,fontWeight: FontWeight.w100,color: normalGrey.shade500),
      subtitle: CustomText(text: subTitle,
        fontSize: 16.0,
        fontWeight: FontWeight.w100,
        color: normalBlack,
      ),
      leading: Icon(iconData,color: normalGrey.shade700,) ,
      trailing: const Icon(CupertinoIcons.pencil),
      onTap: onTap,
    );
  }


  /// Build Alert Dialog

  AlertDialog _buildAlertDialog({
  required BuildContext context , required String title ,
    required VoidCallback onPressed , required bool name
}){
    return AlertDialog(
      title: Text(title),
      actions: [
         TextField(
          controller: name ? _controllerBio : _controllerFirst ,
          decoration: InputDecoration(
              hintText: name ? '${context.translate!.translate(MainEnum.textBioHere.name)}' :'First'
          ),
        ),
         
         Visibility(
           visible: name ? false : true,
           child: TextField(
            controller:  _controllerLast ,
            decoration: const InputDecoration(
                hintText: 'Last'
            ),
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