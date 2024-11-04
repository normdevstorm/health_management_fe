part of '../app.dart';

class ThemeManager {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorManager.primaryColorLight,
    scaffoldBackgroundColor: ColorManager.backgroundColorLight,
    cardColor: ColorManager.cardColorLight,
    dividerColor: ColorManager.dividerColorLight,
    appBarTheme: AppBarTheme(
      color: ColorManager.appBarColorLight,
      elevation: 0,
      iconTheme: const IconThemeData(color: ColorManager.iconColorLight),
      toolbarTextStyle: StyleManager.toolbarText,
    ),
    textTheme: TextTheme(
      headlineSmall: StyleManager.h1,
      headlineMedium: StyleManager.h2,
      headlineLarge: StyleManager.h3,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: ColorManager.buttonEnabledColorLight,
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: const IconThemeData(
      color: ColorManager.iconColorLight,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      fillColor: ColorManager.iconButtonColorLight,
      hintStyle: StyleManager.hintText,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.dividerColorLight),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primaryColorLight),
      ),
    ),
  );
  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorManager.primaryColorDark,
    scaffoldBackgroundColor: ColorManager.backgroundColorDark,
    cardColor: ColorManager.cardColorDark,
    dividerColor: ColorManager.dividerColorDark,
    appBarTheme: AppBarTheme(
      color: ColorManager.appBarColorDark,
      elevation: 0,
      iconTheme: const IconThemeData(color: ColorManager.iconColorDark),
      toolbarTextStyle: StyleManager.toolbarText,
    ),
    textTheme: TextTheme(
      headlineSmall: StyleManager.h1,
      headlineMedium: StyleManager.h2,
      headlineLarge: StyleManager.h3,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: ColorManager.buttonColorDark,
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: const IconThemeData(
      color: ColorManager.iconColorDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.iconButtonColorDark,
      hintStyle: StyleManager.hintText,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.dividerColorDark),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primaryColorDark),
      ),
    ),
  );
}
