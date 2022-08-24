import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';

// Function Get Paramters of TextSyle and return it as a widget
TextStyle _getTextStyle(Color color, double fontSize, FontWeight fontWeight) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: FontConstantsManager.fontFamilyApp,
  );
}

//-------- Font weight is set for each function----------
// To Return Bold Font
TextStyle getBoldFont(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(color, fontSize, FontWeighManager.bold);
}

// To Return SemiBold Font
TextStyle getSemiBoldFont(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(color, fontSize, FontWeighManager.semiBold);
}

// To Return Regular Font
TextStyle getRegularFont(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(color, fontSize, FontWeighManager.regular);
}

// To Return Medium Font
TextStyle getMediumFont(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(color, fontSize, FontWeighManager.medium);
}

// To Return Light Font
TextStyle getLightFont(
    {double fontSize = FontSizeManager.s12, required Color color}) {
  return _getTextStyle(color, fontSize, FontWeighManager.light);
}

//------------------------Brand Name-----------------------------
TextStyle _getTextStyleBrand(
    Color color, double fontSize, FontWeight fontWeight) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: FontConstantsManager.fontFamilyBrand,
  );
}

TextStyle getMediumFontBrand(
    {double fontSize = FontSizeManager.s27, required Color color}) {
  return _getTextStyleBrand(color, fontSize, FontWeighManager.medium);
}
