import 'package:chat_app/Helper/Constance/const_firebase.dart';
import 'package:chat_app/Helper/Constance/const_state.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/Views/Main/responsive_builder.dart';
import 'package:chat_app/Views/View/Chat/mobile_chat_page.dart';
import 'package:flutter/material.dart';


class MainChatScreen extends StatefulWidget {
  static const String chat = '/MainChatScreen';
  const MainChatScreen({Key? key}) : super(key: key);

  @override
  State<MainChatScreen> createState() => _MainChatScreenState();
}

class _MainChatScreenState extends State<MainChatScreen> with WidgetsBindingObserver{

  @override
  void initState() {
    super.initState();
    _update(true);
  }

  @override
  void dispose() {
    super.dispose();
    _update(false);
  }

  @override
  Widget build(BuildContext context) {
    final UserModel _data = context.modal!.settings.arguments as UserModel;

    return ResponsiveBuilderScreen(
        mobile: MobileChatPage( data: _data )
    );
  }

  Future<void> _update(bool page) async {
    return await fireStore.collection(fireStoreUser).doc(firebaseId).update({
      'page': page
    });
  }
}