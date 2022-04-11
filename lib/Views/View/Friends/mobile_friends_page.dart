import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_functions.dart';
import 'package:chat_app/Helper/Constance/const_state.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Helper/Widgets/Defaults/default_circle_avatar.dart';
import 'package:chat_app/Helper/Widgets/Defaults/defualt_modalsheet.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/ViewModel/Functions/chat_functions.dart';
import 'package:chat_app/Views/Main/condtional_builder.dart';
import 'package:chat_app/Views/Profile/Profile/main_profile_screen.dart';
import 'package:chat_app/Views/Profile/ProfileMe/main_profileme_screen.dart';
import 'package:chat_app/Views/View/Chat/main_chat_page.dart';
import 'package:chat_app/Views/View/Chat/main_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileFriendsPage extends ConsumerStatefulWidget {
  const MobileFriendsPage({Key? key}) : super(key: key);

  @override
  _MobileFriendsPageState createState() => _MobileFriendsPageState();
}

class _MobileFriendsPageState extends ConsumerState<MobileFriendsPage>
    with _MobileFriendsScreen  {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder:(context, constraints) => Column(
          children: [

            Expanded(
                child: Consumer(
                  builder: (context,prov,_) {
                    return prov.watch(_fetchFriendsProv).when(
                        error: (err,stack)=> errorProvider(err),
                        loading: ()=> loadingProvider() ,
                      data: (data) => AnimatedConditionalBuilder(
                        condition: data.docs.isNotEmpty,
                        builder: (buildContext) {
                          return ListView.builder(
                              itemCount: data.docs.length,
                              itemBuilder: (buildContext,i) {
                                final UserModel _userModel = UserModel.fromApp(data.docs.elementAt(i).data());
                                return InkWell(
                                  onTap: (){
                                    Navigator.of(context).pushNamed(MainChatScreen.chat,arguments: _userModel);
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0
                                        ),
                                        child: DefaultCircleAvatar(userModel: _userModel,radius: 25.0,),
                                      ) ,

                                      Expanded(
                                          child: CustomText(
                                              text: '${_userModel.first} ${_userModel.last}',
                                            fontSize: 17.0,
                                          )) ,

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0
                                        ),
                                        child: CustomText(text: _userModel.date.toDate().toString().substring(0,10).toString()),
                                      )
                                    ],
                                  ),
                                );
                              }
                          );
                        } ,
                        fallback: (BuildContext buildContext){
                          return notFoundData('No There The Friends Now');
                        },
                      )
                    );
                  }
                )
            )

          ],
        ),
      ),
    );
  }
}

class _MobileFriendsScreen{
  final _fetchFriendsProv = StreamProvider((ref)=>FriendsFunctions.fetchFriends());
}

// ListTile(
//       contentPadding: const EdgeInsets.all(7.0) ,
//
//       title: CustomText(text: '${_userModel.first} ${_userModel.last}') ,
//
//       onTap: () {
//         Navigator.of(context).pushNamed(MainChatScreen.chat,arguments: _userModel);
//       } ,
//
//       onLongPress: () async {
//         await customModalBottomSheet(widgets: SizedBox(
//           width: double.infinity,
//           height: constraints.maxHeight * 0.24,
//           child: Column(
//             children: [
//               Expanded(
//                 child: DefaultModalBottomSheet(
//                     text: '${context.translate!.translate(MainEnum.textProfile.name)} ${_userModel.first} ${_userModel.last}',
//                     iconData: Icons.person_pin,
//                     onPressed: (){
//                       Navigator.of(context).pushNamed(MainProfileScreen.profile,arguments: _userModel);
//                     }
//                 ),
//               ),
//
//               Expanded(
//                 child: DefaultModalBottomSheet(
//                     text: '${context.translate!.translate(MainEnum.textBlock.name)} ${_userModel.first} ${_userModel.last}',
//                     iconData: Icons.person_add_disabled_outlined,
//                     onPressed: () async {
//                       return await customAlertDialog(
//                           onPressed: () async {
//                             await BlockFunctions.addToBlock(model: _userModel);
//                             await FriendsFunctions.removeFriends(_userModel.id);
//                             Navigator.pop(context);
//                           }, context: context
//                       );
//                     }
//                 ),
//               ),
//             ],
//           ),
//         ), context: context);
//       },
//
//       leading: DefaultCircleAvatar(userModel: _userModel) ,
//
//       trailing: CustomText(text: _userModel.date.toDate().toIso8601String().substring(0,10)) ,
//     )