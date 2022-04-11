import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_functions.dart';
import 'package:chat_app/Helper/Constance/const_state.dart';
import 'package:chat_app/Helper/Widgets/Customs/custom_widgets.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/ViewModel/Functions/auth_functions.dart';
import 'package:chat_app/Views/Main/condtional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class DefaultDrawer extends ConsumerStatefulWidget {
   const DefaultDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<DefaultDrawer> createState() => _DefaultDrawerState();
}


class _DefaultDrawerState extends ConsumerState<DefaultDrawer>  with _DefaultDrawerClass {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Consumer(
            builder: (context,prov,_) => prov.watch(_myData).when(
                  error: (err,stack)=>errorProvider(err),
                  loading: () => loadingProvider() ,
                data: (myData) {
                  final UserModel _data = UserModel.fromApp(myData.data()!);

                  return UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: _data.image.isEmpty ? normalWhite : null,
                      backgroundImage: _data.image.isEmpty ? null: NetworkImage(_data.image),
                      child: AnimatedConditionalBuilder(
                        condition: _data.image.isEmpty,
                        builder: (context)=> CustomText(
                            text: _data.first.substring(0,1).toString() ,
                          fontSize: 24.0,
                          color: normalBlack,
                          fontWeight: FontWeight.bold,
                        ),
                        fallback: null,
                      ),
                    ),
                    accountName: Text('${_data.first} ${_data.last}') ,
                    accountEmail: AnimatedConditionalBuilder(
                      condition: _data.bio.isEmpty,
                      builder: (context)=>Text(_data.email.toString()),
                      fallback: (context)=>Text(_data.bio.toString()),
                    )
                  );
                }
              )
          ),

          Expanded(
            flex: 1,
            child: Card(
              child: InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (context)=>SimpleDialog(
                      alignment: Alignment.center,
                      title: Align(
                          alignment: Alignment.center,
                          child: Text('${context.translate!.translate(MainEnum.textChooseLang.name)}')),

                      children: [

                        const Divider(thickness: 1,),

                        _buildLangButton(langName: 'Arabic', ref: ref, lang: MainEnum.arabic.name),
                        _buildLangButton(langName: 'English', ref: ref, lang: MainEnum.english.name),
                        _buildLangButton(langName: 'Español', ref: ref, lang: MainEnum.espanol.name),
                      ],
                    ));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: _langName!,
                      fontSize: 20.0,
                    ),
                  )
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Card(
              child: InkWell(
                  onTap: (){
                   //ConstNavigator.pushNamedRouter(route: MainPostsScreen.posts, context: context);
                  },
                  child:Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: '${context.translate!.translate(MainEnum.textWrite.name)}',
                      fontSize: 20.0,
                    ),
                  )

              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Card(
              child: InkWell(
                  onTap: (){
                   // ConstNavigator.pushNamedRouter(route: MainChangePwScreen.changePw, context: context);
                  },
                  child:Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: '${context.translate!.translate(MainEnum.textChange.name)}',
                      fontSize: 20.0,
                    ),
                  )

              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Consumer(
              builder: (context,prov,_) {

                return prov.watch(_myData).when(
                    error: (err,stack)=>errorProvider(err),
                    loading: ()=>loadingProvider() ,
                  data: (myData) {
                   // final UserModel _data = UserModel.fromApp(myData.data()!);

                    return Card(
                    child: InkWell(
                        onTap: (){
                        //  Navigator.of(context).pushNamed(MainProfileUpdateScreen.profileUpdate,arguments: _data);
                        },
                        child:Container(
                          margin: const EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            text: '${context.translate!.translate(MainEnum.textUpdate.name)}',
                            fontSize: 20.0,
                          ),
                        )

                    ),
                  );
                  }
                );
              }
            ),
          ),

          Expanded(
            flex: 1,
            child: Card(
              child: InkWell(
                  onTap: () async{
                    return await AuthFunctions.signOut(context);
                  },
                  child:Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: '${context.translate!.translate(MainEnum.textLogOut.name)}',
                      fontSize: 20.0,
                    ),
                  )

              ),
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}


class _DefaultDrawerClass {
  final _myData = StreamProvider((ref)=> AuthFunctions.getUserData() );
  late String? _langName = 'English';

  Widget _buildLangButton({
    required String langName ,
    required WidgetRef ref ,
    required String lang
  }) {
    return InkWell(
        onTap: (){
          ref.read(langProv).toggleLang(lang);
          _langName = langName;
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