import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();
  ColorScheme scheme({
    required Color backgroundColor,
    required Brightness brightness,
  }) =>
      ColorScheme(
        primary: kPrimaryColor,
        primaryVariant: kPrimaryDarkColor,
        secondary: kSecondaryColor,
        secondaryVariant: kSecondaryDarkColor,
        surface: kPlaceholderDarkColor,
        background: backgroundColor,
        error: kErrorColor,
        onPrimary: kWhiteColor,
        onSecondary: kBlackColor,
        onSurface: kPlaceholderColor,
        onBackground: backgroundColor,
        onError: kErrorColor.withOpacity(.7),
        brightness: brightness,
      );

  final ThemeData defaultTheme = ThemeData(
    hintColor: kPlaceholderColor,
    focusColor: kSecondaryColor,
  );

  TextTheme defaultFonts(BuildContext context) {
    return GoogleFonts.openSansTextTheme(Theme.of(context).textTheme).copyWith(
        headline1: GoogleFonts.architectsDaughter(
            fontWeight: FontWeight.bold, fontSize: 54.0),
        headline6: GoogleFonts.architectsDaughter(
            fontWeight: FontWeight.bold, fontSize: 36.0));
  }

  static final AppTheme theme = AppTheme._();

  static ThemeData lightTheme(context) {
    return theme.defaultTheme.copyWith(
      colorScheme: theme.scheme(
        backgroundColor: kWhiteColor,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: kWhiteColor,
      backgroundColor: kWhiteColor,
      hintColor: kPlaceholderDarkColor,
      dividerColor: kPlaceholderColor,
      iconTheme: Theme.of(context).iconTheme.copyWith(color: kBlackColor),
      textTheme: theme.defaultFonts(context).apply(
            bodyColor: kBlackColor,
            displayColor: kBlackColor,
          ),
    );
  }

  static ThemeData darkTheme(context) {
    return theme.defaultTheme.copyWith(
      colorScheme: theme.scheme(
        backgroundColor: kBlackColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: kBlackColor,
      backgroundColor: kBlackColor,
      hintColor: kPlaceholderColor,
      dividerColor: kPlaceholderColor,
      iconTheme: Theme.of(context).iconTheme.copyWith(color: kBlackColor),
      textTheme: theme.defaultFonts(context).apply(
            bodyColor: kWhiteColor,
            displayColor: kWhiteColor,
          ),
    );
  }
}
