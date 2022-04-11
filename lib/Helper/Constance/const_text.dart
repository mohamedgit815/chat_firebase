import 'package:chat_app/Views/Main/localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextTranslate {
  static Locale switchLang(String lang){
    SharedPreferences.getInstance().then((value) async {
      await value.setString('lang', lang);
    });
    if(lang == 'english'){
      lang = 'en';
    } else if(lang == 'arabic'){
      lang = 'ar';
    } else if(lang == 'espanol') {
      lang = 'es';
    }
    return Locale(lang,'');
  }

  static String? translateText(String text,BuildContext context){
    return AppLocalization.of(context)!.translate(text);
  }
}
