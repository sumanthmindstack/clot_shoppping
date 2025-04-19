import 'package:clot_store/presentation/theme/app_colors.dart';

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(context) => ThemeData().copyWith(
        scaffoldBackgroundColor: AppColors.primaryColor,
        bottomAppBarTheme:
            const BottomAppBarTheme(color: AppColors.pureWhiteColor),
        bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: AppColors.pureWhiteColor),
      );
}
