import 'package:flutter/material.dart';

import '../utils/color_helper.dart';
import 'base_color.dart';
import 'base_text_style.dart';

class BaseTheme {
  BaseTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
        fontFamily: BaseTextStyle.baseSemiBoldFont,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: BaseColor.green800,
        primarySwatch: ColorHelper.createMaterialColor(BaseColor.green600));
  }

  static ThemeData get lightTheme {
    return ThemeData(
        fontFamily: BaseTextStyle.baseSemiBoldFont,
        primaryColor: BaseColor.green700,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: ColorHelper.createMaterialColor(BaseColor.green200));
  }
}
