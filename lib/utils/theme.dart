import 'package:flutter/material.dart';

import 'package:localcommunity/utils/constants.dart';

ThemeData appTheme() => ThemeData(
    fontFamily: "Poppins",
    scaffoldBackgroundColor: whiteColor,
    appBarTheme: appBarTheme(),
    splashColor: whiteColor,
    iconTheme: IconThemeData(color: Colors.black),
    inputDecorationTheme: inputDecorationTheme());

appBarTheme() => AppBarTheme(
      elevation: 1,
      backgroundColor: whiteColor,
      centerTitle: true,
      titleTextStyle: TextStyle(color: kPrimaryTextColor),
    );

inputDecorationTheme() => InputDecorationTheme(
      border: UnderlineInputBorder(borderSide: BorderSide(color: orangeColor)),
      labelStyle: TextStyle(
        color: kSecondryColor.withOpacity(0.5),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      hintStyle: TextStyle(
        color: kSecondryColor.withOpacity(0.5),
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
    );
