
import 'dart:js_interop';

import 'package:flutter/material.dart';
import './styling.dart' as styling;


class ThemeMap {
  final Map theme;
  const ThemeMap({
    this.theme=styling.theme,
  });

  ThemeMap copyWith(String param, dynamic value) {
    Map<dynamic, dynamic> newTheme = Map.from(theme);
    newTheme[param] = value;
    return ThemeMap(theme: newTheme);
  }

  Map <dynamic, dynamic> get t => theme;
  Color get main => theme["main"];
  Color get secondary => theme["secondary"];
  Color get accent => theme["accent"];
  Color get text => theme["text"];
  double get borderWidth => theme["border-width"];
  double get borderRadius => theme["border-radius"];
  bool get neumorphism => theme["neumorphism"];
  bool get autumn => theme["autumn"];
  bool get additional => theme["additional"];
  double get gridRatio => theme["grid-ratio"];
  double get gridVerticalSpacing => theme["grid-vertical-spacing"];
  double get gridHorizontalSpacing => theme["grid-horizontal-spacing"];
  double get buttonBlur => theme["button-blur"];

  String colorToHexString(Color color) {
    String colorString = color.toString();
    String valueString = colorString.split('(0x')[1].split(')')[0];
    return valueString;
  }

  Color hexStringToColor(String strColor) {
    return Color(int.parse(strColor, radix: 16));
  }

  toString() {
    return {
      main: colorToHexString(main),
      secondary: colorToHexString(secondary),
      accent: colorToHexString(accent),
      text: colorToHexString(text),
      borderRadius: borderRadius.toString(),
      borderWidth: borderWidth.toString(),
      neumorphism: neumorphism.toString(),
      autumn: autumn.toString(),
      additional: additional.toString(),
      gridRatio: gridRatio.toString(),
      gridVerticalSpacing: gridVerticalSpacing.toString(),
      gridHorizontalSpacing: gridHorizontalSpacing.toString(),
      buttonBlur: buttonBlur.toString(),
    }.toString();
  }
  // Todo: convert map to string
}