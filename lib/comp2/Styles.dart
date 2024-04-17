import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryColor: isDarkTheme ? Colors.white70 : CupertinoColors.darkBackgroundGray,
      textTheme:isDarkTheme ? GoogleFonts.catamaranTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white):GoogleFonts.catamaranTextTheme(Theme.of(context).textTheme).apply(bodyColor: CupertinoColors.darkBackgroundGray),



      appBarTheme: isDarkTheme ?AppBarTheme(
        color: CupertinoColors.darkBackgroundGray,

        shadowColor: Colors.white12,
        //I want the defaults, which is why I'm copying an 'empty' ThemeData
        //perhaps there's a better way to do this?
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
        titleTextStyle: GoogleFonts.montserrat(
            color: CupertinoColors.white,
            fontSize: 21,
            fontWeight: FontWeight.w700),
        iconTheme: IconThemeData(color: Colors.white,),
      ): AppBarTheme(

        color: Colors.white,
        //I want the defaults, which is why I'm copying an 'empty' ThemeData
        //perhaps there's a better way to do this?
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),

        titleTextStyle: GoogleFonts.montserrat(
            color: CupertinoColors.systemBlue,
            fontSize: 21,
            fontWeight: FontWeight.w700),
        iconTheme: IconThemeData(color: Colors.blueAccent,),
      ),

      scaffoldBackgroundColor:isDarkTheme?CupertinoColors.darkBackgroundGray:Colors.white,

      pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          }
      ),


      brightness: isDarkTheme ? Brightness.dark : Brightness.light,

    );
  }
}