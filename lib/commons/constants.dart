// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// final mainFont = GoogleFonts.comicNeue();

String snek = "assets/Snek.png";
String bug = "assets/no_bugs.png";

final List<Widget> painters = <Widget>[];

final mainFont = GoogleFonts.abel();

final codeFont = GoogleFonts.ptMono();

var mainColor = Color.fromARGB(255, 252, 221, 253);
var cardColor = Color.fromARGB(255, 254, 235, 255);
var arrowColor = Color.fromARGB(255, 255, 164, 249);
var textColor = Color.fromARGB(255, 0, 0, 0);
var selectedColor = Colors.white;
var shadowColor = Color(0xffFCD4FF);
var backgroundColor = Colors.white;
var accountDarkColor = cardColor;
var progressColor = arrowColor;
var accountPicColor = Color.fromARGB(255, 246, 198, 248);
var sendColor = Color.fromARGB(255, 253, 221, 255);
var receiveColor = Color.fromARGB(255, 255, 236, 247);

List<Color> gradientColors = [
  Color.fromARGB(255, 253, 207, 255),
  Color.fromARGB(255, 255, 255, 255),
];

List<Color> mapGradientColors = [cardColor, arrowColor];

List<Color> confettiColors = [
  Color.fromARGB(255, 221, 208, 255),
  Color.fromARGB(255, 255, 175, 250),
  Color.fromARGB(255, 255, 139, 247),
  Color.fromARGB(255, 255, 68, 243),
  Color.fromARGB(255, 255, 30, 240),
];

List<Color> floatingCircleColors = [
  Color.fromARGB(255, 221, 208, 255),
  Color.fromARGB(255, 255, 175, 250),
  Color.fromARGB(255, 255, 139, 247),
  Color.fromARGB(255, 255, 68, 243),
  Color.fromARGB(255, 255, 30, 240),
];

setDarkModeColors(bool isDarkMode) {
  if (isDarkMode) {
    snek = "assets/SnekDark.png";
    bug = "assets/no_bugs_dark_mode.png";
    mainColor = Color(0xff000000);
    cardColor = Color(0xff1C1C1E);
    arrowColor = Color.fromARGB(255, 255, 255, 255);
    textColor = Color.fromARGB(255, 193, 193, 210);
    progressColor = Color.fromARGB(255, 147, 147, 221);
    shadowColor = Color.fromARGB(255, 37, 31, 37);
    backgroundColor = Color(0xff2C2C2E);
    accountDarkColor = Color.fromARGB(255, 53, 53, 57);
    accountPicColor = Color.fromARGB(255, 61, 61, 128);
    sendColor = Color.fromARGB(255, 147, 154, 191);
    receiveColor = Color.fromARGB(255, 178, 178, 178);

    gradientColors = [
      Color(0xff000000),
      Color(0xff1C1C1E),
    ];

    mapGradientColors = [cardColor, arrowColor];

    confettiColors = [
      Color.fromARGB(255, 210, 208, 255),
      Color.fromARGB(255, 178, 175, 255),
      Color.fromARGB(255, 139, 139, 255),
      Color.fromARGB(255, 74, 68, 255),
      Color.fromARGB(255, 30, 34, 255),
    ];

    floatingCircleColors = [
      Color.fromARGB(255, 93, 92, 114),
      Color.fromARGB(255, 70, 69, 99),
      Color.fromARGB(255, 46, 46, 83),
      Color.fromARGB(255, 32, 29, 110),
      Color.fromARGB(255, 8, 10, 74),
    ];
  } else {
    snek = "assets/Snek.png";
    bug = "assets/no_bugs.png";

    mainColor = Color.fromARGB(255, 252, 221, 253);
    cardColor = Color.fromARGB(255, 254, 235, 255);
    arrowColor = Color.fromARGB(255, 255, 164, 249);
    textColor = Color.fromARGB(255, 0, 0, 0);
    selectedColor = Colors.white;
    progressColor = arrowColor;
    shadowColor = Color(0xffFCD4FF);
    backgroundColor = Colors.white;
    accountDarkColor = cardColor;
    accountPicColor = Color.fromARGB(255, 246, 198, 248);

    gradientColors = [
      Color.fromARGB(255, 253, 207, 255),
      Color.fromARGB(255, 255, 255, 255),
    ];

    confettiColors = [
      Color.fromARGB(255, 255, 208, 252),
      Color.fromARGB(255, 255, 175, 250),
      Color.fromARGB(255, 255, 139, 247),
      Color.fromARGB(255, 255, 68, 243),
      Color.fromARGB(255, 255, 30, 240),
    ];

    floatingCircleColors = [
      Color.fromARGB(255, 221, 208, 255),
      Color.fromARGB(255, 255, 175, 250),
      Color.fromARGB(255, 255, 139, 247),
      Color.fromARGB(255, 255, 68, 243),
      Color.fromARGB(255, 255, 30, 240),
    ];

    mapGradientColors = [cardColor, arrowColor];
  }
}
