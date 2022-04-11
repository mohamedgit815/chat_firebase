import 'package:chat_app/Helper/Constance/const_functions.dart';
import 'package:chat_app/Helper/Constance/const_state.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_button.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Helper/Widgets/Defaults/default_circle_avatar.dart';
import 'package:chat_app/Helper/Widgets/Defaults/defualt_modalsheet.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/ViewModel/Functions/chat_functions.dart';
import 'package:chat_app/Views/Main/condtional_builder.dart';
import 'package:chat_app/Views/Profile/Profile/main_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileRequestsPage extends StatefulWidget {
  const MobileRequestsPage({Key? key}) : super(key: key);

  @override
  _MobileRequestsPageState createState() => _MobileRequestsPageState();
}

class _MobileRequestsPageState extends State<MobileRequestsPage> with _MobileRequests{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${context.translate!.translate(MainEnum.textRequests.name)}'),
        centerTitle: true ,
      ),

      body: LayoutBuilder(
        builder: (context,constraints) => Column(
            children: [
              Expanded(
                child: Consumer(
                  builder: (context,prov,_) {
                    return prov.watch(_fetchRequests).when(
                        error: (err,stack)=> errorProvider(err),
                        loading: ()=> loadingProvider() ,
                      data: (data)=> AnimatedConditionalBuilder(
                        condition: data.docs.isNotEmpty,
                        builder: (BuildContext buildContext) {
                          return ListView.builder(
                              itemCount: data.docs.length ,
                              itemBuilder: (context,i) {
                                final UserModel _data = UserModel.fromApp(data.docs.elementAt(i).data());
                                final _knowFriends = StreamProvider((ref)=>FriendsFunctions.fetchUserFriends(_data.id));

                                return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Consumer(
                                  builder: (context,provMyData,_) {
                                    return provMyData.watch(myDataProv).when(
                                        error: (err,stack)=> errorProvider(err) ,
                                        loading: ()=> loadingVisibilityProvider() ,
                                      data: (myData) {
                                        final UserModel _myData = UserModel.fromApp(myData.data()!);


                                        return InkWell(
                                          onTap: () async {
                                            return await customModalBottomSheet(widgets: SizedBox(
                                              width: double.infinity,
                                              height: constraints.maxHeight * 0.24,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: DefaultModalBottomSheet(
                                                        text: '${context.translate!.translate(MainEnum.textProfile.name)} ${_data.first} ${_data.last}',
                                                        iconData: Icons.person_pin,
                                                        onPressed: (){
                                                          Navigator.of(context).pushNamed(MainProfileScreen.profile,arguments: _data);
                                                        }
                                                    ),
                                                  ),

                                                  Expanded(
                                                    child: DefaultModalBottomSheet(
                                                        text: '${context.translate!.translate(MainEnum.textBlock.name)} ${_data.first} ${_data.last}',
                                                        iconData: Icons.person_add_disabled_outlined,
                                                        onPressed: () async {
                                                          return await customAlertDialog(
                                                              onPressed: () async {
                                                                await BlockFunctions.addToBlock(model: _data);
                                                                Navigator.pop(context);
                                                              }, context: context
                                                          );
                                                        }
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ), context: context);

                                          },
                                          child: Row(
                                          children: [
                                            DefaultCircleAvatar(userModel: _data) ,

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10.0,left: 10.0
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(text: '${_data.first} ${_data.last}'),


                                                  Consumer(
                                                    builder: (context,provFriends,_) {
                                                      return provFriends.watch(_knowFriends).when(
                                                          error: (err,stack)=> errorProvider(err) ,
                                                          loading: ()=> loadingVisibilityProvider() ,
                                                        data: (lengthData)=> CustomText(text: '${lengthData.docs.length} ${context.translate!.translate(MainEnum.textFriends.name)}')
                                                      );
                                                    }
                                                  ) ,


                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [

                                                      CustomOutlinedButton(
                                                          onPressed: () async {
                                                            return await _refusedRequests(context, _data.id);
                                                          },
                                                          child: Text('${context.translate!.translate(MainEnum.textRefused.name)}') ,
                                                          borderRadius: BorderRadius.circular(10.0)
                                                      ),


                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            right: 10.0,left: 10.0
                                                        ),
                                                        child: CustomElevatedButton(
                                                          onPressed: () async {
                                                            return await _acceptRequests(data: _data, myData: _myData);
                                                          },
                                                          child: Text('${context.translate!.translate(MainEnum.textAccept.name)}') ,
                                                          borderRadius: BorderRadius.circular(10.0),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                      ),
                                        );
                                      }
                                    );
                                  }
                                ),
                              );
                              }
                          );
                        },
                        fallback: (BuildContext buildContext){
                          return notFoundData('No There Friends Requests');
                        },
                      )
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

class _MobileRequests {
  final _fetchRequests = StreamProvider((ref)=>RequestsFunction.fetchRequests());




  /// Functions
  Future<void> _refusedRequests(BuildContext context ,String id) async {
    return await showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text('${context.translate!.translate(MainEnum.textSure.name)}'),
      actions: [
        CustomElevatedButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('${context.translate!.translate(MainEnum.textNo.name)}')),
        CustomElevatedButton(onPressed: () async {
          await RequestsFunction.refusedRequests(id);
          Navigator.of(context).pop();
        }, child: Text('${context.translate!.translate(MainEnum.textYes.name)}')),
      ],
    ));
  }

  Future<void> _acceptRequests({required UserModel data , required UserModel myData}) async {
    await RequestsFunction.acceptRequests(
        id: data.id,
        model: data ,
        myModel: myData
    );
    await RequestsFunction.refusedRequests(data.id);
  }

}
