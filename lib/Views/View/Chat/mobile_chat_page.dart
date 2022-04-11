import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_firebase.dart';
import 'package:chat_app/Helper/Constance/const_functions.dart';
import 'package:chat_app/Helper/Constance/const_regexp.dart';
import 'package:chat_app/Helper/Constance/const_state.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_button.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Helper/Widgets/Defaults/default_circle_avatar.dart';
import 'package:chat_app/Model/chat_model.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/ViewModel/Functions/chat_functions.dart';
import 'package:chat_app/ViewModel/State/bottombar_state.dart';
import 'package:chat_app/ViewModel/State/switch_state.dart';
import 'package:chat_app/Views/Main/condtional_builder.dart';
import 'package:chat_app/Views/Main/tabbar_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_to/swipe_to.dart';

class MobileChatPage extends ConsumerStatefulWidget {
  final UserModel data;
  const MobileChatPage({Key? key,required this.data}) : super(key: key);

  @override
  _MobileChatPageState createState() => _MobileChatPageState();
}

class _MobileChatPageState extends ConsumerState<MobileChatPage> with _MobileChatPage{

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).unfocus();
    });

    _scrollController.addListener(() {
      ref.read(_visibleProv).countState(_scrollController.offset.toInt());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool _keyBoard = MediaQuery.of(context).viewInsets.bottom == 0;

    final _fetchChat = StreamProvider((ref)=>ChatFunctions.fetchChat(
        id: widget.data.id, name: '${widget.data.first} ${widget.data.last}'));


    return Builder(
      builder: (buildContext) {
        return Scaffold(

          appBar: _buildAppBar(context:context, userModel: widget.data),

          body: LayoutBuilder(
            builder:(context, constraints) => Container(
              width: double.infinity ,

              height: double.infinity ,

              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover ,
                  image: AssetImage('assets/images/back.png')
                )
              ),

              child: Stack(
                children: [
                  Column(
                        children: [

                          Expanded(
                              child: Consumer(
                                builder: (context,prov,_) {
                                  return prov.watch(_fetchChat).when(
                                      error: (err,stack)=> errorProvider(err),
                                      loading: ()=> loadingVisibilityProvider() ,
                                      data: (data)=>ListView.builder(
                                        controller: _scrollController ,
                                        reverse: true,
                                          itemCount: data.docs.length ,
                                          itemBuilder: (buildContext , int i) {
                                            final ChatModel _chatModel = ChatModel.fromApp(data.docs.elementAt(i).data());
                                            final bool _isMe = firebaseId != _chatModel.id;
                                            _isEmpty = data.docs.isEmpty;
                                            final ValueKey _valueKey = ValueKey(data.docs.elementAt(i).id);

                                            return SwipeTo(
                                              key: _valueKey,
                                              onLeftSwipe: (){
                                                ref.read(_subTextProv).funcChange(_chatModel.text);
                                                _subText = _chatModel.text;
                                                ref.read(_checkSubTextProv).funcChange(_chatModel.id);
                                              },
                                              child: Column(
                                                children: [

                                                  Card(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: CustomText(text: _chatModel.date.toDate().toString().substring(0,19),),
                                                    ),
                                                  ) ,


                                                  Visibility(
                                                    visible: _chatModel.subText.isNotEmpty ? false : true,
                                                    child: Align(
                                                      alignment: _isMe ? Alignment.centerRight: Alignment.centerLeft,
                                                      child: Container(

                                                        padding: const EdgeInsets.all(10.0),
                                                        margin: const EdgeInsets.all(10.0),
                                                        decoration:  BoxDecoration(
                                                            color: _isMe ? normalWhite : _color,
                                                          borderRadius: BorderRadius.only(
                                                            topRight: const Radius.circular(10.0),
                                                            topLeft: const Radius.circular(10.0),
                                                            bottomRight:  Radius.circular(!_isMe ? 10.0: 0.0),
                                                            bottomLeft: Radius.circular(_isMe ? 10.0: 0.0),
                                                          )
                                                        ),
                                                        child: CustomText(
                                                          key: _valueKey,
                                                            fontSize: 17.0,
                                                            maxLine: 1024,
                                                          text: _chatModel.text,
                                                      ),
                                                  ),
                                                    ) ,
                                                  ) ,


                                                  Visibility(
                                                    visible: _chatModel.subText.isEmpty ? false : true,
                                                    child: Align(
                                                      alignment: Alignment.centerLeft ,
                                                      child: Container(
                                                        margin: const EdgeInsets.all(8.0) ,
                                                        decoration: BoxDecoration(
                                                            color: _isMe ? normalWhite : _color ,
                                                          borderRadius: const BorderRadius.only(
                                                            topRight: Radius.circular(15.0) ,
                                                            bottomRight: Radius.circular(15.0) ,
                                                          )
                                                        ) ,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start ,
                                                          children: [
                                                            SizedBox(
                                                              height: _keyBoard ? constraints.maxHeight * 0.12 : context.height * 0.12 ,
                                                              child: Card(
                                                                color: normalWhite.withOpacity(0.5) ,
                                                                child: Row(
                                                                  children: [

                                                                    Container(
                                                                      height: double.infinity,
                                                                      width: 5.0,
                                                                      decoration: const BoxDecoration(
                                                                          color: lightMainColor ,
                                                                          borderRadius: BorderRadius.only(
                                                                            topRight: Radius.circular(5.0) ,
                                                                            bottomRight: Radius.circular(5.0) ,
                                                                          )
                                                                      ),
                                                                    ) ,


                                                                    const SizedBox(width: 5.0) ,


                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children:  [

                                                                        Expanded(
                                                                           child: Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                top: 5.0
                                                                            ),
                                                                            child: CustomText(
                                                                              key: ValueKey(_chatModel.text),
                                                                              color: lightMainColor ,
                                                                              text: _chatModel.subChat != '${widget.data.first} ${widget.data.last}' ? '${context.translate!.translate(MainEnum.textYou.name)}' : _chatModel.subChat ,
                                                                              fontSize: 12.0,),
                                                                        ),
                                                                         ) ,

                                                                        Expanded(
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                bottom: 5.0
                                                                            ),
                                                                            child: CustomText(
                                                                                key: ValueKey<String>(_chatModel.subText.toString()),
                                                                                text: _chatModel.subText.toString()),
                                                                          ),
                                                                        )

                                                                      ],
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                            ),

                                                            Padding(
                                                              padding: const EdgeInsets.all(7.0),
                                                              child: CustomText(
                                                                key: ValueKey<String>(_chatModel.text.toString()),
                                                                  maxLine: 1024,
                                                                  text: _chatModel.text.toString()
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )

                                                ]),
                                            );
                                          }

                                      )
                                  );



                                }
                              )
                          ) ,


                          Consumer(
                            builder: (context,myData,_)=> _buildSendMessageUI(
                                context: context ,
                                constraints: constraints ,
                                userModel: widget.data ,
                                ref: ref ,
                              isEmpty: _isEmpty ,
                              keyBoard: _keyBoard
                            ),
                          )
                        ],
                      ),

                  Positioned(
                      right: 10.0,
                      top: 10.0,
                      child: _buildDownButton())
                ],
              )
            ),
          ),
        );
      }
    );
  }



}

class _MobileChatPage {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final _visibleProv = ChangeNotifierProvider<BottomBarState>((ref)=>BottomBarState());
  final _loadingProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final _textProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final _subTextProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final _checkSubTextProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  bool _isEmpty = false;
  String _mainText = '';
  String _subText = '';
  final Color _color = const Color(0xffE2FFC7);


  /// Appbar
  AppBar _buildAppBar({
  required BuildContext context , required UserModel userModel
}) {
    return AppBar(

      leading: BackButton(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(TabBarScreen.tabBar, (route) => false);


          // Navigator.maybePop(context);
        },
      ),

      title: CustomText(
        text: '${userModel.first} ${userModel.last}',
        fontSize: 18.0,fontWeight: FontWeight.w100,),

      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultCircleAvatar(userModel: userModel,color: normalWhite,textColor: lightMainColor,),
        ) ,
      ],

      centerTitle: true,
    );
  }


  /// Build ListView Chat With Users
  Widget _buildListViewChat({
    required UserModel userModel ,
    required StreamProvider<QuerySnapshot<Map<String, dynamic>>> fetchChatProv ,
    required WidgetRef ref ,
    required BoxConstraints constraints ,
    required bool keyBoard
  }){

    return Consumer(
      builder: (BuildContext buildContext,prov,_) {

        return prov.watch(fetchChatProv).when(
            error: (err,stack)=> errorProvider(err) ,
            loading: ()=> loadingVisibilityProvider() ,
            data: (data)=> AnimatedConditionalBuilder(
              condition: data.docs.isNotEmpty,
              builder: (context) {
                _isEmpty = data.docs.isEmpty;

                return ListView.builder(
                    itemCount: data.docs.length ,
                    controller: _scrollController ,
                    reverse: true ,
                    itemBuilder: (context,i) {
                      final ChatModel _chatModel = ChatModel.fromApp(data.docs.elementAt(i).data());
                      final bool _isMe = firebaseId != _chatModel.id;
                    return GestureDetector(
                      onLongPress: () async {
                        return await deleteMessage(
                            isMe: _isMe,
                            context: context,
                            chatModel: _chatModel,
                            userModel: userModel,
                            i: i,
                            data: data
                        );
                      },
                      onDoubleTap: (){
                         ref.read(_subTextProv).funcChange(_chatModel.text);
                         _subText = _chatModel.text;
                         ref.read(_checkSubTextProv).funcChange(_chatModel.id);
                        },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0) ,
                        child: SizedBox(
                          //height: _chatModel.subText.isEmpty ? keyBoard ? context.height * 0.08: constraints.maxHeight * 0.08: keyBoard ? context.height * 0.15: constraints.maxHeight * 0.15 ,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                           // crossAxisAlignment: !_isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            children: [

                              Visibility(
                                  visible: _chatModel.subText.isEmpty ? false : true,
                                  child: Container(
                                    width: double.infinity,
                                    decoration:  BoxDecoration(
                                        color: _isMe ? Colors.white : const Color(0xffE2FFC7),
                                        borderRadius: BorderRadius.only(
                                            topRight: const Radius.circular(12.0) ,
                                            topLeft: const Radius.circular(15.0) ,
                                            bottomRight: Radius.circular(_isMe ? 0.0: _chatModel.subText.isEmpty? 15.0 : 0.0) ,
                                            bottomLeft: Radius.circular(_isMe ? 15.0: 0.0)
                                        )
                                    ) ,
                                    child: Card(
                                        color: normalWhite.withOpacity(0.5),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: CustomText(text: _chatModel.subText,maxLine: 1,),
                                        )),
                                  )
                              ),


                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10.0) ,
                                alignment: !_isMe ? Alignment.centerLeft: Alignment.centerRight,
                                decoration:  BoxDecoration(
                                    color: _isMe ? Colors.white : const Color(0xffE2FFC7) ,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(_chatModel.subText.isEmpty ?12.0 : 0.0) ,
                                        topLeft: Radius.circular(_chatModel.subText.isEmpty ?15.0 : 0.0) ,
                                        bottomRight: Radius.circular(_isMe ? 0.0: 15.0) ,
                                        bottomLeft: Radius.circular(_isMe ? 15.0: 0.0)
                                    )
                                ) ,
                                child: CustomText(text: _chatModel.text,maxLine: 1024,),
                              )

                          ],
                    ),
                        ),
                      ),
                  );
                  }
              );
            } ,
            fallback: (BuildContext buildContext){
              return notFoundData('No There Chat with ${userModel.first} ${userModel.last}');
            },
          )
        );
      }
    );
  }


  /// Build Send Message UI
  Consumer _buildSendMessageUI({
    required BuildContext context ,
    required BoxConstraints constraints ,
    required WidgetRef ref ,
    required UserModel userModel ,
    required bool isEmpty ,
    required bool keyBoard
  }) {
    return Consumer(
      builder: (context,provCheck,_) {
        return SizedBox(
          height: provCheck.watch(_subTextProv).value.isEmpty ? keyBoard ? constraints.maxHeight * 0.11: context.height * 0.10 : keyBoard ? constraints.maxHeight * 0.17 : context.height * 0.15 ,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [

                      Consumer(
                        builder: (context,provCheck,_) {
                          return Visibility(
                            visible: provCheck.watch(_subTextProv).value.isEmpty ? false : true,
                            child: Container(
                              height: provCheck.watch(_subTextProv).value.isEmpty ? 0.0: 50.0 ,
                              width: double.infinity ,
                              decoration: const BoxDecoration(
                                  color: normalWhite ,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5.0),
                                      topLeft: Radius.circular(5.0)
                                  )
                              ),
                              child: Card(
                                color: Colors.grey.shade300,
                                child: Row(
                                  children: [
                                    Container(
                                      height: double.infinity,
                                      width: 5.0,
                                      decoration: const BoxDecoration(
                                          color: Color(0xff075E55) ,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(7.0) ,
                                              bottomLeft: Radius.circular(7.0)
                                          )
                                      ),
                                    ) ,

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:  [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.0,right: 3.0
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children:  [
                                                 Expanded(
                                                   child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10.0
                                                    ),
                                                    child: Consumer(
                                                      builder:(context,prov,_)=> CustomText(
                                                        text: prov.watch(_checkSubTextProv).value != firebaseId ? '${userModel.first} ${userModel.last}' : 'You',
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w100,
                                                        color: lightMainColor,
                                                      ),
                                                    ),
                                                ),
                                                 ),


                                                GestureDetector(
                                                    onTap: (){
                                                      ref.read(_subTextProv).equalNull();
                                                    },
                                                    child: const Icon(Icons.close,size: 15.0))
                                              ],
                                            ),
                                          ) ,

                                          Consumer(
                                            builder: (context,prov,_) {
                                              return Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 5.0
                                                  ),
                                                  child: CustomText(
                                                    text: prov.watch(_subTextProv).value ,
                                                    fontSize: 15.0 ,
                                                    color: Colors.grey.shade600 ,
                                                    fontWeight: FontWeight.w100 ,
                                                    overflow: TextOverflow.ellipsis ,
                                                    maxLine: 1 ,
                                                  ),
                                                ),
                                              );
                                            }
                                          ) ,
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      ) ,


                      Expanded(
                        child: Consumer(
                          builder: (context,provMyData,_) {
                            return provMyData.watch(myDataProv).when(
                                error: (err,stack)=> errorProvider(err) ,
                                loading: ()=> loadingVisibilityProvider() ,
                              data: (myData) {
                                  final UserModel _myData = UserModel.fromApp(myData.data()!);
                                return TextField(
                                controller: _textController ,
                                textDirection: TextDirection.ltr ,
                                onChanged: (String v) {
                                  ref.read(_textProv).funcChange(v);
                                  _mainText = v;
                                },
                                onSubmitted: (v){
                                  if(v.isNotEmpty){
                                    _functionsSendMessage(
                                        isEmpty: isEmpty,
                                        ref: ref,
                                        userModel: userModel,
                                        myData: _myData
                                    );
                                  } else {
                                    return;
                                  }
                                },
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.send,
                                decoration:  InputDecoration(
                                    filled: true ,
                                    fillColor: Colors.white ,
                                    hintText: '${context.translate!.translate(MainEnum.textMessage.name)}',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: const Radius.circular(10.0),
                                          bottomRight: const Radius.circular(10.0),
                                          topRight:  Radius.circular(ref.read(_subTextProv).value.isEmpty ? 10.0: 0.0) ,
                                          topLeft: Radius.circular(ref.read(_subTextProv).value.isEmpty ? 10.0: 0.0) ,
                                        ),
                                        borderSide: BorderSide.none
                                    )
                                ),
                              );
                              }
                            );
                          }
                        ),
                      ) ,
                    ],
                  ),
                ),

                Consumer(
                    builder: (context,prov,_) {
                      return AnimatedVisibility(
                        duration: const Duration(milliseconds: 50),
                        visible: !langEnArRegExp.hasMatch(prov.watch(_textProv).value) &&
                            !conditionEegExp.hasMatch(prov.watch(_textProv).value) ? false : true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: lightMainColor ,
                            child: Consumer(
                                builder: (context,provMyData,_) {
                                  return provMyData.watch(myDataProv).when(
                                      error: (err,stack)=> errorProvider(err) ,
                                      loading: ()=> loadingVisibilityProvider() ,
                                      data: (myData) {
                                        final UserModel _myData = UserModel.fromApp(myData.data()!);
                                        return IconButton(
                                            onPressed: () async {
                                              return await _functionsSendMessage(
                                                  isEmpty: isEmpty, ref: ref, userModel: userModel, myData: _myData);
                                            }, icon: const Icon(Icons.send , color: Colors.white,textDirection: TextDirection.ltr,));
                                      }
                                  );
                                }
                            ),
                          ),
                        ),
                      );
                    }
                ) ,
              ],
            ),
          ),
        );
      }
    );
  }


  // This Button Used to go Down The Screen
  Consumer _buildDownButton() {
    return Consumer(
        builder: (context,prov,_) {
          return AnimatedVisibility(
              visible: prov.watch(_visibleProv).count > 300 ? true : false,
              child: CircleAvatar(
                backgroundColor: lightMainColor,
                child: IconButton(
                    onPressed: () async {
                      return await _scrollController.animateTo(0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.bounceIn
                  );
                }, icon: const Icon(Icons.keyboard_arrow_down_outlined,color: normalWhite,)),
              ));
        }
    );
  }


  /// Functions Screens
  Future<void> _functionsSendMessage({
    required bool isEmpty ,
    required WidgetRef ref ,
    required UserModel userModel ,
    required UserModel myData ,
  }) async {
    !isEmpty ? null : _scrollController.jumpTo(0);
    ref.read(_textProv).equalNull();
    _textController.clear();
    ref.read(_subTextProv).equalNull();

    await ChatFunctions.sendMessageChat(
        id: userModel.id ,
        text: _mainText ,
        name: "${userModel.first} ${userModel.last}" ,
        myName: '${myData.first} ${myData.last}' ,
        state: ref ,
        indicatorState: _loadingProv ,
        subText: _subText,
        subUser: ref.read(_checkSubTextProv).value != firebaseId ? '${userModel.first} ${userModel.last}' : '${myData.first} ${myData.last} '
    ).then((value) {
      _mainText = '';
      _subText = '';
      _scrollController.jumpTo(0);
    });
  }


  // DeleteMessage
  Future<void> deleteMessage({
    required bool isMe ,
    required BuildContext context ,
    required ChatModel chatModel ,
    required UserModel userModel ,
    required int i ,
    required QuerySnapshot<Map<String,dynamic>> data
}) async {
    if(!isMe && data.docs.elementAt(i).id == data.docs.first.id){
      await showDialog(context: context, builder: (context)=> AlertDialog(
        title: Text('${context.translate!.translate(MainEnum.textDelete.name)} \'${chatModel.text}\''),
        actions: [

          CustomElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
              }, child: CustomText(text: '${context.translate!.translate(MainEnum.textNo.name)}',)
          ),

          Consumer(
              builder: (context,provMyData,_) {
                return provMyData.watch(myDataProv).when(
                    error: (err,stack)=>errorProvider(err) ,
                    loading: ()=> loadingVisibilityProvider() ,
                    data: (myData)=>CustomElevatedButton(
                        onPressed: () async {
                          final UserModel _myData = UserModel.fromApp(myData.data()!);
                          await ChatFunctions.deleteMessageChat(
                              id: userModel.id ,
                              name: '${userModel.first} ${userModel.last}' ,
                              myName: '${_myData.first} ${_myData.last}' ,
                              deleteId: data.docs.elementAt(i).id
                          );
                          Navigator.pop(context);
                          FocusScope.of(context).unfocus();
                        }, child: CustomText(text: '${context.translate!.translate(MainEnum.textYes.name)}',)
                    )
                );
              }
          ) ,

        ],
      ));
    } else {
      return;
    }
  }
}