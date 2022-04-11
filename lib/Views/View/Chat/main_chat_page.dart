import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_firebase.dart';
import 'package:chat_app/Helper/Constance/const_functions.dart';
import 'package:chat_app/Helper/Constance/const_regexp.dart';
import 'package:chat_app/Helper/Constance/const_state.dart';
import 'package:chat_app/Helper/Constance/const_text.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_button.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Model/chat_model.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/ViewModel/Functions/chat_functions.dart';
import 'package:chat_app/ViewModel/State/bottombar_state.dart';
import 'package:chat_app/ViewModel/State/switch_state.dart';
import 'package:chat_app/Views/Main/condtional_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_to/swipe_to.dart';


class MobileChatTest extends ConsumerStatefulWidget {
  final UserModel userModel;
  const MobileChatTest({Key? key,required this.userModel}) : super(key: key);

  @override
  _MobileChatPageState createState() => _MobileChatPageState();
}

class _MobileChatPageState extends ConsumerState<MobileChatTest> with _MobileChat{

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
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _fetchChatProv = StreamProvider((ref)=>ChatFunctions.fetchChat(
        id: widget.userModel.id,
        name: '${widget.userModel.first} ${widget.userModel.last}')
    );


    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: normalGrey.shade50,

        appBar: _buildAppBar(requestsModel: widget.userModel),

        body: Container(
          width: double.infinity ,
          height: double.infinity ,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover ,
                  image: AssetImage('assets/images/back.png')
              )
          ),
          child: LayoutBuilder(
            builder:(context, constraints) => Stack(
              children: [

                Consumer(
                  builder:(context,provMyData,_) {
                    return provMyData.watch(myDataProv).when(
                        error: (err,stack)=> Text(err.toString()) ,
                        loading: ()=> loadingVisibilityProvider() ,
                        data: (myData) {
                          final UserModel _myData = UserModel.fromApp(myData.data()!);
                          return Column(
                            children: [
                              Expanded(
                                child: _buildChatListViewText(
                                    fetchChatProv:_fetchChatProv ,
                                    requestsModel: widget.userModel ,
                                    userModel: _myData ,
                                    ref: ref
                                ),
                              ) ,

                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          _buildTobChatText(_myData),


                                          Row(
                                            children: [

                                              // Build ChatTextField
                                              Expanded(
                                                child: _buildChatTextField(
                                                    requestsModel: widget.userModel,
                                                    userModel: _myData ,
                                                    context: context ,
                                                    ref: ref ,
                                                    isEmpty: _isEmpty
                                                ),
                                              ),

                                              // Build ChatSendTextButton
                                              Builder(
                                                  builder: (context) {
                                                    return _buildSendTextButton(
                                                        myData: _myData ,
                                                        requestsModel: widget.userModel ,
                                                        ref: ref ,
                                                        isEmpty: _isEmpty
                                                    );
                                                  }
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                  ) ,
                                ],
                              )
                            ],
                          );
                        }
                    );
                  },
                ) ,


                _buildDownButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileChat{
  /// Global Variable

  final _loadingProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final _visibleProv = ChangeNotifierProvider<BottomBarState>((ref)=>BottomBarState());
  final _textProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final _subTextProv = ChangeNotifierProvider<SwitchState>((ref)=>SwitchState());
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  bool _isEmpty = false;

  /// Scaffold...

  // AppBar
  AppBar _buildAppBar({
    required UserModel requestsModel
  }) {
    return AppBar(
        title: const CustomText(
            text: 'Chat' ,
            fontSize: 20.0
        ),
        actions: [
          CircleAvatar(
            foregroundColor: lightMainColor,
            backgroundColor: requestsModel.image.isEmpty ? normalWhite : null,
            backgroundImage: requestsModel.image.isEmpty ? null : NetworkImage(requestsModel.image),
            child: requestsModel.image.isEmpty ? Text(requestsModel.first.substring(0,1).toString()) : null,
          ),

          Padding(
            padding: const EdgeInsets.only(right: 5.0,left: 5.0),
            child: Center(child: CustomText(text: '${requestsModel.first} ${requestsModel.last}')),
          )
        ] );
  }


  /// Body... Build Show Chat Text

  // Special to Show Data in ListView
  Consumer _buildChatListViewText({
    required StreamProvider<QuerySnapshot<Map<String, dynamic>>> fetchChatProv ,
    required UserModel requestsModel ,
    required UserModel userModel ,
    required WidgetRef ref
  }) {
    return Consumer(
        builder: (context,prov,_) {
          return prov.watch(fetchChatProv).when(
              error: (err,stack)=>errorProvider(err),
              loading: ()=>loadingVisibilityProvider(),
              data: (data) {
                _isEmpty = data.docs.isEmpty;
                return AnimatedConditionalBuilder(
                    condition: data.docs.isEmpty,
                    builder: (context){
                      return notFoundData('No there Chat with ${requestsModel.first} ${requestsModel.last}');
                    },
                    fallback: (BuildContext context){
                      return ListView.builder(
                        key: ValueKey<String>(requestsModel.id),
                        reverse: true ,
                        controller: _scrollController ,
                        itemCount: data.docs.length ,
                        itemBuilder: (context,i) {
                          final ChatModel _data = ChatModel.fromApp(data.docs.elementAt(i).data());
                          final bool _isMe = firebaseId == _data.id;
                          return Column(
                            children: [

                              Card(
                                  color: _isMe ? Colors.white : normalGrey.shade200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomText(
                                      text: _data.date.toDate().toString().substring(0,19),
                                      color: Colors.black,
                                    ),
                                  )),


                              GestureDetector(
                                onLongPress: (){
                                  if(_isMe && data.docs.elementAt(i).id == data.docs.first.id){
                                    showDialog(context: context, builder: (context)=>AlertDialog(
                                      title: Text('${TextTranslate.translateText(MainEnum.textDelete.name, context)} \'${_data.text}\''),
                                      actions: [

                                        CustomElevatedButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            }, child: CustomText(text: '${TextTranslate.translateText(MainEnum.textNo.name, context)}',)
                                        ),

                                        CustomElevatedButton(
                                            onPressed: () async {
                                              await ChatFunctions.deleteMessageChat(
                                                  id: requestsModel.id ,
                                                  name: '${requestsModel.first} ${requestsModel.last}',
                                                  myName: '${userModel.first} ${userModel.last}',
                                                  deleteId: data.docs.elementAt(i).id
                                              );
                                              Navigator.pop(context);
                                              FocusScope.of(context).unfocus();
                                            }, child: CustomText(text: '${TextTranslate.translateText(MainEnum.textYes.name, context)}',)
                                        ) ,

                                      ],
                                    ));
                                  } else {
                                    return;
                                  }
                                },
                                child: Column(
                                  children: [

                                    Visibility(
                                      visible: _data.subText.isEmpty ? false : true,
                                      child: Align(
                                        alignment: _isMe ? Alignment.centerLeft : Alignment.centerRight,
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 10.0 , left: 10.0 , top: 5.0
                                            ),
                                            padding: const EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                                color: !_isMe ? Colors.white: Colors.grey.shade200,
                                                borderRadius: BorderRadius.circular(0.0)
                                            ),
                                            child: CustomText(
                                              text: _data.subText ,
                                              fontSize: 17.0 ,
                                              color: Colors.black,
                                            )
                                        ),
                                      ),
                                    ),

                                    SwipeTo(
                                      onLeftSwipe: (){
                                        ref.read(_subTextProv).funcChange(_data.text);
                                      },
                                      child: Align(
                                        alignment: _isMe ? Alignment.centerLeft : Alignment.centerRight,
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 15.0 ,
                                                right: 10.0 , left: 10.0
                                            ),
                                            padding: const EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                                color: _isMe ? Colors.white: Colors.grey.shade200,
                                                borderRadius: BorderRadius.circular(0.0)
                                            ),
                                            child: CustomText(
                                              text: _data.text.toString() ,
                                              fontSize: 17.0 ,
                                              color: Colors.black,
                                              maxLine: 120,
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )

                            ],
                          );
                        },


                      );
                    }
                );
              }
          );
        }
    );
  }


  /// Build Chat Text

  // This UI to Get old Results
  Consumer _buildTobChatText(UserModel _myData) {
    return Consumer(
        builder: (context,prov,_) {
          return AnimatedVisibility(
            visible: prov.watch(_subTextProv).value.isEmpty ? false : true,
            switchInCurve: Curves.ease,
            switchOutCurve: Curves.ease,
            child: Card(
              color: normalGrey.shade100,
              child: ListTile(
                title: Text('${_myData.first} ${_myData.last}'),
                subtitle: Text(prov.read(_subTextProv).value.toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: (){
                    prov.watch(_subTextProv).equalNull();
                  },
                ),
              ),
            ),
          );
        }
    );
  }


  // This UI to Send Data
  TextField _buildChatTextField({
    required UserModel userModel ,
    required UserModel requestsModel ,
    required BuildContext context ,
    required WidgetRef ref ,
    required bool isEmpty
  }) {
    const OutlineInputBorder _outLineBorder = OutlineInputBorder(
        borderRadius:  BorderRadius.only(
          topRight: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        borderSide: BorderSide.none
    );

    return TextField(
      controller: _textController,
      focusNode: _focusNode,
      textInputAction: TextInputAction.send,
      onSubmitted: (v) async {
        if(ref.read(_textProv).value.isEmpty){
          FocusScope.of(context).unfocus();
          return;
        } else {

        }
      },
      decoration: InputDecoration(
          border: _outLineBorder ,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
              borderSide: const BorderSide(color: Colors.black,width: 1.0)
          ),
          disabledBorder: _outLineBorder ,
          focusedBorder: _outLineBorder
      ),
      onChanged: (v){
        ref.read(_textProv).funcChange(v);
      },
    );
  }


  // Send Text to DataBase
  Consumer _buildSendTextButton({
    required UserModel myData ,
    required UserModel requestsModel ,
    required WidgetRef ref ,
    required bool isEmpty
  }) {
    return Consumer(
        builder: (context,prov,_) {
          return AnimatedVisibility(
              visible: conditionEegExp.hasMatch(prov.watch(_textProv).value) ||
                  langEnArRegExp.hasMatch(prov.read(_textProv).value),
              child: AnimatedVisibility(
                  duration: const Duration(milliseconds: 100),
                  visible: prov.watch(_loadingProv).varSwitch,
                  child: IconButton(
                      onPressed: () async {
                        return await functionSendMessage(
                            userModel: myData,
                            requestsModel: requestsModel,
                            ref: ref,
                            context: context,
                            isEmpty: isEmpty
                        );
                      }, icon: const Icon(Icons.send))
              )
          );
        }
    );
  }


  /// Build Down Button

  // This Button Used to go Down The Screen
  Consumer _buildDownButton() {
    return Consumer(
        builder: (context,prov,_) {
          return AnimatedVisibility(
              visible: prov.watch(_visibleProv).count > 250 ? true : false,
              child: IconButton(onPressed: () async {
                return await _scrollController
                    .animateTo(0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceIn
                );
              }, icon: const Icon(Icons.vertical_align_bottom)));
        }
    );
  }


  Future<void> functionSendMessage({
    required UserModel userModel ,
    required UserModel requestsModel ,
    required WidgetRef ref ,
    required BuildContext context ,
    required bool isEmpty
}) async {
    FocusScope.of(context).autofocus(_focusNode);
    isEmpty ? null : _scrollController.jumpTo(0);

    _scrollController.jumpTo(0);
    await ChatFunctions.sendMessageChat(
        id: requestsModel.id ,
        text: _textController.text ,
        name: "${requestsModel.first} ${requestsModel.last}" ,
        myName: '${userModel.first} ${userModel.last}' ,
        state: ref ,
        indicatorState: _loadingProv ,
        subText: ref.read(_subTextProv).value,
        subUser: ''
    );
    ref.read(_textProv).equalNull();
    ref.read(_subTextProv).equalNull();
    _textController.clear();
    _scrollController.jumpTo(0);
  }
}