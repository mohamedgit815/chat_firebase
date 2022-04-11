import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization{
  final Locale locale;


  AppLocalization(this.locale);


  static AppLocalization? of(BuildContext context){
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }


  static const LocalizationsDelegate<AppLocalization> delegate = _AppLocalizationsDelegate();


  late Map<String,String> _localizationStrings;


  Future<bool> loadLang()async{
    String jsonString = await rootBundle.loadString("assets/lang/${locale.languageCode}.json");
    Map<String,dynamic> jsonMap = jsonDecode(jsonString);
    _localizationStrings = jsonMap.map((key, value){
      return MapEntry(key, value.toString());
    });
    return true;
  }


  String? translate(String key){
    return _localizationStrings[key];
  }


  static const LocalizationsDelegate<AppLocalization> delegateNew = _AppLocalizationsDelegate();

}


class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization>{

  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en","ar","es"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async{
    AppLocalization localization = AppLocalization(locale);
    await localization.loadLang();
    return localization;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}