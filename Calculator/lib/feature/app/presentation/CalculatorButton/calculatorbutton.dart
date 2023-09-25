import 'package:flutter/material.dart';
import '../CalculatorButtonLegacy/calculatorbutton_legacy.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;


class CalculatorButtonThemed extends StatelessWidget {
  final Map theme;
  final String title;
  final Function callback;

  CalculatorButtonThemed({
    super.key,
    required this.title,
    required this.callback,
    this.theme=styling.theme,
  });

  @override
  Widget build(BuildContext context) {
    return CalculatorButton(
        title: title,
        callback: callback,
        main: theme["main"],
        secondary: theme["secondary"],
        text: theme["text"],
        borderWidth: theme["border-width"],
        borderRadius: theme["border-radius"],
        isNeumorphism: theme["neumorphism"],
        buttonBlur: theme["button-blur"],
    );
  }


}