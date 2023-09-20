import 'package:flutter/material.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;


class CalculatorTextButtonText extends StatelessWidget {
  final String title;
  final Color textColor;
  final bool isSmall;

  const CalculatorTextButtonText({
    super.key,
    required this.title,
    this.textColor=styling.originText,
    this.isSmall=false
  });

  @override
  Widget build(BuildContext context) {
    return Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: (isSmall)
              ? styling.textFontSizeSmall
              : styling.textFontSizeLarge,
        )
    );
  }
}