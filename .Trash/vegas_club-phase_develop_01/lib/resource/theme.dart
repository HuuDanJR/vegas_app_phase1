import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/file_asset_gen/fonts.gen.dart';

class ThemeCustom {
  ThemeCustom._();
  static ThemeData get configTheme {
    return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        disabledColor: Colors.grey,
        appBarTheme: AppBarTheme(
            // color: Colors.white,
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.light
                .copyWith(statusBarColor: Colors.transparent)),
        fontFamily: FontFamily.quicksand,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              color: Colors.black, fontSize: 34, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(
              color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500),
          displaySmall: TextStyle(
              color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500),
          headlineMedium: TextStyle(
              color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
          titleLarge: TextStyle(
              color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
          labelLarge: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(
              color: Colors.grey, fontSize: 13, fontWeight: FontWeight.normal),
          bodySmall: TextStyle(
              color: Colors.grey, fontSize: 12, fontWeight: FontWeight.normal),
          titleMedium: TextStyle(
              color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w500),
          titleSmall: TextStyle(
              color: Colors.grey, fontSize: 10, fontWeight: FontWeight.normal),
        ),
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.black,
            minWidth: 90,
            height: 46,
            textTheme: ButtonTextTheme.normal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.quicksand)),
                foregroundColor:
                    MaterialStateProperty.all<Color>(ColorName.primary),
                // overlayColor: MaterialStateProperty.all<Color>(
                //     Colors.blue1Color),
                backgroundColor:
                    MaterialStateProperty.all<Color>(ColorName.primary),
                // shadowColor: MaterialStateProperty.all<Color>(
                //     Colors.blue1Color),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))))),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: Colors.black, width: 1))),
          textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(color: Colors.white)),
        )),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(background: Colors.white));
  }
}
