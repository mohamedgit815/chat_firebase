import 'package:chat_app/Helper/Constance/const_colors.dart';
import 'package:chat_app/Helper/Constance/const_functions.dart';
import 'package:flutter/material.dart';


final ThemeData lightTheme = ThemeData(
  /// Properties
  useMaterial3: false ,
  primaryColor: lightMainColor,
  unselectedWidgetColor: lightColorThree,
  scaffoldBackgroundColor: normalWhite,
  backgroundColor: lightMainColor,
  cardColor: helperColorOne,
  indicatorColor: normalBlack ,
  drawerTheme: DrawerThemeData(
    scrimColor: normalBlack.withOpacity(0.5),
  ),

  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light ,
    seedColor: const Color(0xff333333),
    primary: Colors.indigo ,
    secondary: lightMainColor
  ),


  /// Normal Widgets
  appBarTheme: const AppBarTheme(
      backgroundColor: normalBlack ,

      foregroundColor: normalWhite ,

      actionsIconTheme: IconThemeData(
          color: normalWhite,
          size: 24.0,
      ) ,

      iconTheme: IconThemeData(
          color: normalWhite,
          size: 20.0
      ) ,

      titleTextStyle: TextStyle(
      color: normalWhite,
      fontSize: 24.0,
      fontWeight: FontWeight.w400
    )
  ),
  iconTheme: const IconThemeData(
      color: normalBlack,
      size: 30.0
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: helperColorOne,
    circularTrackColor: lightMainColor ,
    linearTrackColor: lightMainColor
  ),
  dividerTheme: const DividerThemeData(
      color: normalBlack,
      thickness: 1.5) ,
  switchTheme: SwitchThemeData(
    trackColor: materialStateColor(helperColorOne),
    thumbColor: materialStateColor(lightMainColor),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(lightMainColor),
    checkColor: MaterialStateProperty.all(normalWhite),
    // overlayColor: MaterialStateProperty.all(Colors.white)
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: normalWhite,
    iconColor: normalBlack,
    suffixIconColor: lightColorThree,
    prefixIconColor: lightColorThree,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: normalBlack),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: lightColorThree),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: lightColorThree),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: lightColorThree),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: lightColorThree),
    ),

  ) ,


  /// Alerts
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: normalBlack ,
    actionTextColor: normalWhite ,
  ) ,
  bannerTheme: const MaterialBannerThemeData(
      backgroundColor: normalBlack,
      contentTextStyle: TextStyle( color: normalWhite , fontSize: 17.0 )
  ) ,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: normalWhite,
    modalBackgroundColor: normalWhite,
    elevation: 10.0,
    modalElevation: 10.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0),
      )
    )
  ) ,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: normalWhite,
      elevation: 9.0,
      selectedItemColor: lightMainColor ,
      unselectedItemColor: lightColorThree
  ),


  /// Buttons
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: lightMainColor ,
      foregroundColor: normalWhite
    ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: normalBlack,
      primary: normalWhite,
    )
  ) ,
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          primary: normalBlack ,
          backgroundColor: normalWhite ,
          textStyle: const TextStyle(fontSize: 17.0,) ,
          side: const BorderSide(color: helperColorOne)
      ),

      ) ,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: normalWhite ,
        primary: lightMainColor,
        textStyle: const TextStyle(fontSize: 15.0),
      )
  ) ,
);

final ThemeData darkTheme = ThemeData(
  /// Properties
  primaryColor: darkMainColor ,
  scaffoldBackgroundColor: darkColorTow ,
  backgroundColor: darkColorOne ,
  indicatorColor: darkColorTow ,
  cardColor: darkColorOne ,
  colorScheme: const ColorScheme.dark().copyWith(
    brightness: Brightness.dark ,
    primary: darkMainColor ,
    secondary: normalWhite
  ) ,


  /// Normal Widgets
  appBarTheme: const AppBarTheme(
      backgroundColor: darkColorOne ,
      foregroundColor: normalWhite ,
      actionsIconTheme: IconThemeData(
          color: normalWhite ,
          size: 25.0
      ),
      iconTheme: IconThemeData(
          color: normalWhite ,
          size: 25.0
      )
  ) ,
  iconTheme: const IconThemeData(
      color: normalWhite,
      size: 20.0
  ) ,
  dividerTheme: const DividerThemeData(
      color: helperColorOne,
      thickness: 1.5) ,
  switchTheme: SwitchThemeData(
    trackColor: materialStateColor(normalBlack),
    thumbColor: materialStateColor(darkMainColor),
  ) ,
  checkboxTheme: CheckboxThemeData(
    fillColor: materialStateColor(darkMainColor),
    checkColor: materialStateColor(normalWhite),
    //  overlayColor: MaterialStateProperty.all(Colors.white)
  ) ,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: helperColorOne,
      circularTrackColor: darkMainColor,
      linearTrackColor: darkMainColor,
      refreshBackgroundColor: helperColorOne
  ) ,
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: darkColorOne,
    iconColor: normalWhite,
    suffixIconColor: normalWhite,
    prefixIconColor: normalWhite,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: normalWhite),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: normalWhite),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: normalWhite),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: normalWhite),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: normalWhite),
    ),

  ) ,


  /// Alerts
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: normalWhite ,
    actionTextColor: darkMainColor ,
  ) ,
  bannerTheme: const MaterialBannerThemeData(
      backgroundColor: darkColorOne,
      contentTextStyle: TextStyle(color: normalWhite , fontSize: 17.0)
  ) ,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: darkColorOne,
      selectedItemColor: darkMainColor ,
      unselectedItemColor: normalWhite
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: darkColorOne ,
    modalBackgroundColor: darkColorOne ,
    elevation: 9.0
  ),


  /// Buttons
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: darkMainColor,
    foregroundColor: normalWhite,
    // splashColor: Colors.red,
  ) ,
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: normalWhite,
        backgroundColor: darkMainColor,
        textStyle: const TextStyle(fontSize: 15.0),
      )
  ) ,
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom (
        primary: normalWhite,
          backgroundColor: darkMainColor,
          textStyle: const TextStyle(fontSize: 15.0),
          side: const BorderSide(color: normalWhite,style: BorderStyle.solid)
      )
  ) ,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: normalWhite,
        textStyle: const TextStyle(fontSize: 15.0)),
      )
);