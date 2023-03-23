import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaho_demo/common/styles/base_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(BaseTheme.lightTheme);

  void toggleTheme() {
    if (state == BaseTheme.lightTheme) {
      emit(BaseTheme.darkTheme);
    } else {
      emit(BaseTheme.lightTheme);
    }
  }
}
