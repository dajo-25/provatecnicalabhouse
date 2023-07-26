import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

class AppStyles {
  static var defaultButtonStyle = ButtonStyle();

  static final buttonTheme = ButtonStyle(
    fixedSize: MaterialStatePropertyAll(Size(280, 50)),
    backgroundColor: MaterialStatePropertyAll(AppColors.primary),
    elevation: MaterialStatePropertyAll(3),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    ),
  );

  static final textTheme = TextTheme(
    displayMedium: TextStyle(fontFamily: "Mulish", fontSize: 45, fontWeight: FontWeight.w400),
    headlineLarge: TextStyle(fontFamily: "Mulish", fontSize: 32),
    headlineMedium: TextStyle(fontFamily: "Mulish", fontSize: 28),
    headlineSmall: TextStyle(fontFamily: "Mulish", fontSize: 28),
    titleLarge: TextStyle(fontFamily: "Mulish", fontSize: 22),
    titleMedium: TextStyle(fontFamily: "Mulish", fontSize: 16),
    titleSmall: TextStyle(fontFamily: "Mulish", fontSize: 14),
    labelLarge: TextStyle(fontFamily: "Mulish", fontSize: 14),
    labelSmall: TextStyle(fontFamily: "Mulish", fontSize: 11),
    bodyLarge: TextStyle(fontFamily: "Mulish", fontSize: 16),
    bodyMedium: TextStyle(fontFamily: "Mulish", fontSize: 14),
    bodySmall: TextStyle(fontFamily: "Mulish", fontSize: 12),
  );

  static final inputDecorationTheme = InputDecorationTheme();
  // static final inputDecorationTheme = InputDecorationTheme(floatingLabelStyle: TextStyle(color: AppColors.primary));

  static final mainTheme = ThemeData(
      useMaterial3: true,
      focusColor: AppColors.primary,
      fontFamily: 'Noto Sans',
      primaryColor: Color(0xFFFFFFFF),
      indicatorColor: AppColors.primary,
      accentColor: AppColors.primary,
      scaffoldBackgroundColor: Colors.white,
      bottomAppBarColor: Colors.white,
      buttonColor: Color(0xFF4D4D4D),
      appBarTheme:
          AppBarTheme(iconTheme: IconThemeData(color: Color(0xFF4D4D4D))),
      primaryColorLight: Color(0xFFcbcbcb),
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(),
      inputDecorationTheme: inputDecorationTheme);

  static var primaryButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
      backgroundColor: AppColors.blue,
      minimumSize:
          Size(AppSizes.primaryButtonWidth, AppSizes.primaryButtonHeight));

  static ButtonStyle outlinedButtonStyle({required Color color}) {
    return ElevatedButton.styleFrom(
      side: BorderSide(color: color),
      foregroundColor: Colors.transparent,
      surfaceTintColor: AppColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
      backgroundColor: AppColors.white,
      minimumSize: Size(0, AppSizes.primaryButtonHeight),
    );
  }

  static InputDecoration inputDecoration(
      {required String label,
        FocusNode? focusNode,}) {
    return InputDecoration(
        label: Text(label),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        fillColor: AppColors.surface,
        // floatingLabelStyle: AppStyles.textTheme.bodySmall?.copyWith(
        //   color: focusNode?.hasFocus ?? true ? AppColors.primary: AppColors.outline
        // ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.blue),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppSizes.borderRadius),
                topLeft: Radius.circular(AppSizes.borderRadius),
            bottomLeft: Radius.circular(AppSizes.borderRadius),
            bottomRight: Radius.circular(AppSizes.borderRadius))),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.blue),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppSizes.borderRadius),
                topLeft: Radius.circular(AppSizes.borderRadius),
                bottomLeft: Radius.circular(AppSizes.borderRadius),
                bottomRight: Radius.circular(AppSizes.borderRadius))),
        );
  }

  static BoxDecoration defaultBannerBoxDecoration({Color? color}) {
    return BoxDecoration(
      color: color != null ? color: AppColors.white2,
      borderRadius: BorderRadius.circular(8)
    );

  }
}
