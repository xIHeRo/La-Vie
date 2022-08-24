// ignore_for_file: unused_field

import 'package:flutter/widgets.dart';

class FrameSize {
  //-------------Figma FrameSize--------------
  static const double figmaFrameWidth = 428;
  static const double figmaFrameHeight = 1040;

//---------------------------------------------
  // GET Mobile FramSize Information for designing Screens
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double sliderHeight;
  static late double addToCartButtonHeight;
//------------------------------------------------
//-----------------------Login Piexels---------------
  static late double heightLaVieLogin;
  //----------------------------------------------
  //init method is static so no object creation is required
  static void init(BuildContext context) {
    //instantiate variables here
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    sliderHeight = screenHeight / 6;
    addToCartButtonHeight = screenHeight / 14;
    //----------------------------------------------------
    heightLaVieLogin = screenHeight * (184 / figmaFrameHeight);
  }
}

class MarginManager {
  static const double m8 = 8.0;
  static const double m10 = 10.0;
  static const double m12 = 12.0;
  static const double m14 = 14.0;
  static const double m16 = 16.0;
  static const double m18 = 18.0;
  static const double m20 = 20.0;
}

class PaddingManager {
  static const double p3 = 3.0;
  static const double p5 = 5.0;
  static const double p8 = 8.0;
  static const double p10 = 10.0;
  static const double p12 = 12.0;
  static const double p14 = 14.0;
  static const double p16 = 16.0;
  static const double p18 = 18.0;
  static const double p20 = 20.0;
  static const double p50 = 50.0;
  static const double p100 = 100.0;
}

class SizeManager {
  static const double s0 = 0.0;
  static const double s2 = 2.0;
  static const double s3 = 3.0;
  static const double s4 = 4.0;
  static const double s5 = 5.0;
  static const double s8 = 8.0;
  static const double s10 = 10.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s30 = 30.0;
  static const double s40 = 40.0;
  static const double s50 = 50.0;
  static const double s60 = 60.0;
  static const double s100 = 100.0;
  static const double s150 = 150.0;
}
