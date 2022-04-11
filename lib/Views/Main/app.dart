import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_firebase.dart';
import 'package:chat_app/Helper/Constance/const_functions.dart';
import 'package:chat_app/Helper/Constance/const_state.dart';
import 'package:chat_app/Views/Authentications/Login/main_login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:chat_app/Views/Main/localizations.dart';
import 'package:chat_app/Views/Main/route_builder.dart';
import 'package:chat_app/Views/Main/tabbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Helper/Constance/const_text.dart';



class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'Chat App' ,

      restorationScopeId: 'root' ,

      debugShowCheckedModeBanner: false ,

      themeMode: ThemeMode.light ,

      routes: RouteBuilder.routes ,

      theme: ThemeData(
            primaryColor: const Color(0xff075E55) ,
            colorScheme: const ColorScheme.light().copyWith(
            primary: lightMainColor ,
            secondary: Colors.white ,
            brightness: Brightness.light
          ),
          iconTheme: const IconThemeData(
            color: normalWhite ,

          ) ,

          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xff075E55)
          )
        ) ,

      home: Consumer(
          builder: (context, prov, child) => prov.watch(_checkAuth).when(
              error: (err,stack)=>errorProvider(err),
              loading: ()=>loadingVisibilityProvider() ,
            data: (data)=> data == null ? const MainLoginScreen() : const TabBarScreen()
          ),
          child: const MainLoginScreen()) ,


      locale: TextTranslate.switchLang(ref.watch(langProv).lang),

      supportedLocales: const [
        Locale("en","")  ,
        Locale("ar","") ,
        Locale('es','')
      ] ,

      localizationsDelegates: const [
        AppLocalization.delegate ,
        GlobalWidgetsLocalizations.delegate ,
        GlobalMaterialLocalizations.delegate ,
        GlobalCupertinoLocalizations.delegate
      ],
      localeResolutionCallback: ( currentLocal , supportedLocal ) {
        if( currentLocal != null ) {
          for( Locale loopLocal in supportedLocal ) {
            if( currentLocal.languageCode == loopLocal.languageCode ){
              return currentLocal;
            }
          }
        }
        return supportedLocal.first ;
      },
    );
  }
}

final _checkAuth = StreamProvider((ref)=>firebaseAuth.authStateChanges());