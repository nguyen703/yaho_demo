import 'package:flutter/material.dart';

import '../utils/color_helper.dart';
import 'base_color.dart';
import 'base_text_style.dart';

class BaseTheme {
  static ThemeData get theme {
    final ThemeData base = ThemeData(
        fontFamily: BaseTextStyle.baseSemiBoldFont,
        primaryColor: BaseColor.green600,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: ColorHelper.createMaterialColor(BaseColor.green600));
    return base;
  }
}
