import 'package:flutter/material.dart';


/* - - - - - - - - - - - - - - - - - - - - */

const Color originMain =      Color(0xffc7c7c7);
const Color originSecondary = Color(0x00f0f0f0);//Color(0xff303030);
const Color originAccent =    Color(0xff8f7ca7);
const Color originText =      Color(0xff605454);

const Color effectOutHighlight = Color.fromRGBO(255, 255, 255, 0.5);
const Color effectOutShadow = Color.fromRGBO(1, 0, 18, 0.5);

const double fontSizeInputSmall = 40.0;
const double fontSizeInputNormal = 50.0;
const double fontSizeButtonSmall = 64.0;
const double fontSizeButtonNormal = 78.0;
const double fontSizeSliderTextNormal = 25.0;

const double borderRadius = 50.0;
const double borderWidth = 0;

const double buttonBlur = 0;

const double gridXAxisSpacing = 20;
const double gridYAxisSpacing = 20;

const double gridAspectRatio = (100/100);

const theme = {
    "main": originMain,
    "secondary": originSecondary,
    "accent": originAccent,
    "text": originText,
    "border-width": borderWidth,
    "border-radius": borderRadius,
    "neumorphism": true,
    "autumn": false,
    "additional":false,
    "grid-ratio": gridAspectRatio,
    "grid-horizontal-spacing": gridXAxisSpacing,
    "grid-vertical-spacing": gridYAxisSpacing,
    "button-blur": buttonBlur,
};


List<BoxShadow> calculatorEffectOut = [
    const BoxShadow(
      color: effectOutShadow,
      blurRadius: 10,
      offset: Offset(7, 7), // Shadow position
    ),
    const BoxShadow(
      color: effectOutHighlight,
      blurRadius:10,
      offset: Offset(-7, -7), // Shadow position
    )
  ];

/* - - - - - - - - - - - - - - - - - - - - */



const white = Color.fromRGBO(238, 226, 222, 1.0);
const orange = Color.fromRGBO(234, 144, 108, 1.0);
const wine = Color.fromRGBO(179, 19, 18, 0.2);
const blue = Color.fromRGBO(43, 42, 76, 1.0);

const Color colorAccent = wine;
const Color colorBase = white;
const Color colorSecondary = Color.fromRGBO(130, 115, 156, 1.0);//orange;
const Color colorSecondaryFaded = white;
const Color colorText = blue;

const double textFontSizeSmall = 12.0;
const double textFontSizeMedium = 20.0;
const double textFontSizeLarge = 25.0;
const double textFontSizeExtra = 35.0;

const calculatorInputHint = "Enter math expression here";
const calculatorInputLabel = "Your expression";