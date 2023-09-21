import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;
import 'package:hello_world/feature/app/domain/theme_cubit.dart';

import 'package:hello_world/feature/app/presentation/CalculatorButtonLegacy/calculatorbutton_textbutton_text.dart';
import 'package:hello_world/feature/app/presentation/blurred.dart';
import 'package:hello_world/feature/app/presentation/CalculatorButtonLegacy/calculatorbutton_textbutton_style.dart';
import 'package:hello_world/feature/app/presentation/CalculatorButtonLegacy/calculatorbutton_textbutton_conatiner.dart';

class CalculatorButton extends StatelessWidget {
  final String title;
  final Function callback;
  final bool isSmall;

  final Color main;
  final Color secondary;
  final Color text;
  final double borderRadius;
  final double borderWidth;

  final double buttonBlur;
  final bool isNeumorphism;

  const CalculatorButton({
    super.key,
    required this.title,
    required this.callback,
    this.isSmall=false,
    this.main=styling.originMain,
    this.secondary=styling.originSecondary,
    this.text= styling.originText,
    this.borderRadius=styling.borderRadius,
    this.borderWidth=styling.borderWidth,
    this.buttonBlur=styling.buttonBlur,
    this.isNeumorphism=true,
  });

   bool hasBorder (borderWidth) {
     return (borderWidth > 0.0) ? true : false;
   }

  @override
  Widget build(BuildContext context) {
      return Blurred(
        blur: buttonBlur,
        child: CalculatorButtonContainer(
          borderRadius: borderRadius,
          neumorphismTheme: isNeumorphism,
          child: TextButton(
              onPressed: () { callback(); },
              style: CalculatorButtonStyle(
                main: main,
                secondary: secondary,
                borderRadius: borderRadius,
                borderWidth: borderWidth,
              ).style(),
              child: CalculatorTextButtonText(
                title: title,
                textColor: text,
              ),
            )
        ),
      );
   }
}


