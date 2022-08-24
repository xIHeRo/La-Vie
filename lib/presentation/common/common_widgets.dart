import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/style_manager.dart';

import '../resources/font_manager.dart';
import '../resources/strings_manager.dart';

class CommonWidgets {
  static Widget getBrandName({double fontSize = FontSizeManager.s27}) {
    return SizedBox(
      width: 140,
      height: 70,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: Text(
              StringsManager.brandName,
              style: getMediumFontBrand(
                  fontSize: fontSize, color: ColorManager.black),
            ),
          ),
          Positioned(
            top: 20, // move from left side 10 pixels
            child: Image.asset(ImageAssetsManager.laVieLeaf),
          ),
        ],
      ),
    );
  }
}
