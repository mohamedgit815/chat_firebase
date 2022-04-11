import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_firebase.dart';
import 'package:chat_app/Helper/Constance/const_functions.dart';
import 'package:chat_app/Helper/Constance/const_state.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Helper/Widgets/Defaults/default_add_person.dart';
import 'package:chat_app/Helper/Widgets/Defaults/default_circle_avatar.dart';
import 'package:chat_app/Helper/Widgets/Defaults/defualt_modalsheet.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/ViewModel/Functions/auth_functions.dart';
import 'package:chat_app/ViewModel/Functions/chat_functions.dart';
import 'package:chat_app/Views/Main/condtional_builder.dart';
import 'package:chat_app/Views/Profile/Profile/main_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileUsersPage extends ConsumerStatefulWidget {
  const MobileUsersPage({Key? key}) : super(key: key);

  @override
  _MobileUsersPageState createState() => _MobileUsersPageState();
}

class _MobileUsersPageState extends ConsumerState<MobileUsersPage> {
  @override
  Widget build(BuildContext context) {
    //final _fetchUsers = FutureProvider((ref)=>AuthFunctions.getUserDataById(widget.id));

    return Scaffold(
      body: LayoutBuilder(
        builder:(context, constraints) => Column(
          children: [
            Expanded(
                child: Consumer(
                  builder: (context,prov,_) {
                    return prov.watch(_fetchUsers).when(
                        error: (err,stack)=>errorProvider(err) ,
                        loading: ()=>loadingProvider() ,
                      data: (data)=>AnimatedConditionalBuilder(
                        condition: data.docs.isNotEmpty,
                        builder: (context) {



                          return RefreshIndicator(
                            onRefresh: ()async {
                              return ref.refresh(_fetchUsers);
                            },
                            child: ListView.builder(
                                itemCount: data.docs.length ,
                                itemBuilder: (context,i) {
                                  final UserModel _userModel = UserModel.fromApp(data.docs.elementAt(i).data());
                                  final _checkFriends = StreamProvider((ref)=>FriendsFunctions.checkFriends(data.docs.elementAt(i).id));
                                  final _checkBlock = StreamProvider((ref)=>BlockFunctions.checkUserBlockOrNo(data.docs.elementAt(i).id));

                                  return Consumer(
                                    builder:(context,provCheckFriends,_)=> provCheckFriends.watch(_checkFriends).when(
                                        error: (err,stack)=>errorProvider(err) ,
                                        loading: ()=> loadingVisibilityProvider() ,
                                      data: (checkFriends)=>Consumer(
                                        builder: (context,provCheckBlock,_) {
                                          return provCheckBlock.watch(_checkBlock).when(

                                              error: (err,stack)=>errorProvider(err) ,

                                              loading: ()=> loadingVisibilityProvider() ,

                                            data: (checkBlock)=>Visibility(
                                              visible: _userModel.id == firebaseId || checkFriends.exists || checkBlock.exists? false : true ,
                                              child: ListTile(
                                                key: ValueKey(data.docs.elementAt(i).id),
                                                contentPadding: const EdgeInsets.all(7.0) ,

                                                title: CustomText(text: '${_userModel.first} ${_userModel.last}') ,

                                                subtitle: _userModel.bio.isEmpty ?
                                                CustomText(text: _userModel.email) : CustomText(text: _userModel.bio),

                                                onTap: () async {
                                                  return await customModalBottomSheet(widgets: SizedBox(
                                                    width: double.infinity,
                                                    height: constraints.maxHeight * 0.24,
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          child: DefaultModalBottomSheet(
                                                              text: '${context.translate!.translate(MainEnum.textProfile.name)} ${_userModel.first} ${_userModel.last}',
                                                              iconData: Icons.person_pin,
                                                              onPressed: (){
                                                                Navigator.of(context).pushNamed(MainProfileScreen.profile,arguments: _userModel);
                                                              }
                                                          ),
                                                        ),

                                                        Expanded(
                                                          child: DefaultModalBottomSheet(
                                                              text: '${context.translate!.translate(MainEnum.textBlock.name)} ${_userModel.first} ${_userModel.last}',
                                                              iconData: Icons.person_add_disabled_outlined,
                                                              onPressed: () async {
                                                                return await customAlertDialog(
                                                                    onPressed: () async {
                                                                      await BlockFunctions.addToBlock(model: _userModel);
                                                                      Navigator.pop(context);
                                                                    }, context: context
                                                                );
                                                              }
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ), context: context);
                                                } ,
                                                leading: DefaultCircleAvatar(
                                                    userModel: _userModel ,
                                                  key: ValueKey(data.docs.elementAt(i).id),
                                                ),

                                                trailing: DefaultAddPerson(
                                                    data: _userModel ,
                                                  key: ValueKey(data.docs.elementAt(i).id),
                                                ) ,

                                              ),
                                            )
                                          );
                                        }
                                      )
                                    ),
                                  );
                                }
                            ),
                          );
                        },
                        fallback: (buildContext){
                          return notFoundData('No Users');
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

final _fetchUsers = FutureProvider((ref)=>AuthFunctions.fetchAllUsers());
