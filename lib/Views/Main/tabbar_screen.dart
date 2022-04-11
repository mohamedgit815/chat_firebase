import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_functions.dart';
import 'package:chat_app/Helper/Constance/const_state.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_button.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Helper/Widgets/Defaults/defualt_modalsheet.dart';
import 'package:chat_app/ViewModel/Functions/auth_functions.dart';
import 'package:chat_app/ViewModel/Functions/chat_functions.dart';
import 'package:chat_app/Views/Profile/ProfileMe/main_profileme_screen.dart';
import 'package:chat_app/Views/View/Block/main_block_screen.dart';
import 'package:chat_app/Views/View/Friends/main_friends_screen.dart';
import 'package:chat_app/Views/View/Requests/main_requests_screen.dart';
import 'package:chat_app/Views/View/Users/main_search_users_screen.dart';
import 'package:chat_app/Views/View/Users/main_users_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class TabBarScreen extends ConsumerStatefulWidget {
  static const String tabBar = '/TabBarScreen';
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends ConsumerState<TabBarScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();



    _tabController = TabController(length: 2 , vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      FirebaseMessage.onMessage(context);

      FirebaseMessage.onMessageOpenedApp(context);
    });
    AuthFunctions.updateToken();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }


  @override
    Widget build(BuildContext context) {

      return Scaffold(

        body: NestedScrollView(
          headerSliverBuilder: (context,inner)=>[
            SliverAppBar(
              elevation: 0 ,
                floating: true ,
                snap: true ,
                title: CustomText(text: '${context.translate!.translate(MainEnum.textHome.name)}',fontSize: 18.0,),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search) ,
                    onPressed: (){
                      showSearch(context: context, delegate: SearchUsers());
                    },
                  ),

                  IconButton(
                    icon: Icon(Icons.adaptive.more),
                    onPressed: (){
                      customModalBottomSheet(widgets: Column(
                        children: [
                          Container(
                            height: 5.0 ,
                            width: 20.0 ,
                            color: normalBlack ,
                          ),


                          Expanded(
                            child: DefaultModalBottomSheet(
                                text: '${context.translate!.translate(MainEnum.textProfile.name)}',
                                iconData: Icons.person,
                                onPressed: () async {
                                   await Navigator.of(context).pushNamed(MainProfileMeScreen.profileMe);
                                }
                            ),
                          ) ,


                          Expanded(
                            child: DefaultModalBottomSheet(
                                text: '${context.translate!.translate(MainEnum.textChooseLang.name)}' ,
                                iconData: Icons.language_outlined,
                                onPressed: () async {
                                  showDialog(context: context, builder: (buildContext)=>SimpleDialog(
                                    title: CustomText(text: '${context.translate!.translate(MainEnum.textChooseLang.name)}',),
                                    children: [
                                      const Divider(thickness: 1,),

                                      _buildLangButton(langName: 'Arabic', ref: ref, lang: MainEnum.arabic.name),
                                      _buildLangButton(langName: 'English', ref: ref, lang: MainEnum.english.name),
                                      _buildLangButton(langName: 'Español', ref: ref, lang: MainEnum.espanol.name),
                                    ],
                                  ));
                                }
                            ),
                          ) ,


                          Expanded(
                            child: DefaultModalBottomSheet(
                                text: '${context.translate!.translate(MainEnum.textBlock.name)}' ,
                                iconData: Icons.person_add_disabled_outlined ,
                                onPressed: () async {
                                  Navigator.of(context).pushNamed(MainBlockScreen.block);
                                }
                            ),
                          ) ,

                          const Spacer(flex: 2)
                        ],
                      ), context: context);
                    },
                  ),
                ]
            )
          ],
          body: Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor ,
                width: double.infinity ,
                height: 50.0 ,
                child: TabBar(
                    indicatorColor: Colors.white,
                    unselectedLabelColor: Colors.grey.shade400,
                    controller: _tabController,
                    tabs: [
                      CustomText(text: '${context.translate!.translate(MainEnum.textChat.name)}'),
                      CustomText(text: '${context.translate!.translate(MainEnum.textPeople.name)}'),
                     // Text('People'),
                    ]),
              ) ,

              Expanded(
                child: TabBarView(
                    controller: _tabController ,
                    children: const [
                      MainFriendsScreen() ,
                      MainUsersScreen()
                    ]
                ),
              )
            ],
          ),
        ) ,


        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.chat_outlined,color: normalWhite,),
          onPressed: () {
            ConstNavigator.pushNamedRouter(
                route: MainRequestsScreen.requests, context: context);
          },
        )
      );
  }

  Widget _buildLangButton({
    required String langName ,
    required WidgetRef ref ,
    required String lang
  }) {
    return InkWell(
        onTap: (){
          ref.read(langProv).toggleLang(lang);
          Navigator.maybePop(context);
        },
        child: Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: CustomText(text: langName,
              fontSize: 18.0,
            ))
    );
  }
}