import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/style_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';

ThemeData getAppThemeData() {
  return ThemeData(
    //--------------------------------------------
    // main Colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey,
    //--------------------------------------------
    //cardView theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      elevation: SizeManager.s4,
    ),
    //--------------------------------------------
    // AppBar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      shadowColor: ColorManager.lightPrimary,
      elevation: SizeManager.s4,
      titleTextStyle: getRegularFont(
        fontSize: SizeManager.s16,
        color: ColorManager.white,
      ),
    ),
    //--------------------------------------------
    //--------------- Button Theme ---------------
    buttonTheme: const ButtonThemeData(
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
      disabledColor: ColorManager.grey,
      shape: StadiumBorder(),
    ),
    //--------------------------------------------
    //----------- Elevated Button Theme ----------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(SizeManager.s150, SizeManager.s50),
        textStyle: getRegularFont(
            fontSize: SizeManager.s16, color: ColorManager.white),
        primary: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeManager.s12),
        ),
      ),
    ),
    //--------------------------------------------
    textButtonTheme: TextButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularFont(
            fontSize: SizeManager.s12, color: ColorManager.primary),
      ),
    ),
    //--------------------------------------------
    //--------------- Text Theme ---------------
    textTheme: TextTheme(
      //-----------
      displayLarge: getSemiBoldFont(
        color: ColorManager.grey,
        fontSize: FontSizeManager.s16,
      ),
      //-----------
      headlineMedium: getMediumFont(
        color: ColorManager.lightGrey,
        fontSize: FontSizeManager.s14,
      ),
      //-----------
      labelMedium: getRegularFont(
        color: ColorManager.grey,
        fontSize: FontSizeManager.s12,
      ),
      //-----------
      bodyLarge: getRegularFont(
        color: ColorManager.lightGrey,
        fontSize: FontSizeManager.s12,
      ),
    ),
    //--------------------------------------------
    //-------- Input Decoration Theme -------------
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(PaddingManager.p12),
      hintStyle:
          getRegularFont(color: ColorManager.grey, fontSize: SizeManager.s14),
      labelStyle:
          getMediumFont(color: ColorManager.grey, fontSize: SizeManager.s12),
      errorStyle:
          getRegularFont(color: ColorManager.error, fontSize: SizeManager.s12),
      //---------Borders Handleing-------
      enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.grey, width: SizeManager.s2),
          borderRadius: BorderRadius.all(
            Radius.circular(SizeManager.s8),
          )),

      focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: SizeManager.s2),
          borderRadius: BorderRadius.all(
            Radius.circular(SizeManager.s8),
          )),

      errorBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.error, width: SizeManager.s2),
          borderRadius: BorderRadius.all(
            Radius.circular(SizeManager.s8),
          )),

      focusedErrorBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: SizeManager.s2),
          borderRadius: BorderRadius.all(
            Radius.circular(SizeManager.s8),
          )),
    ),
// Input decoration theme
  );
}
