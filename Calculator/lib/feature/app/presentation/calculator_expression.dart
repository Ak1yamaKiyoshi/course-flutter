import 'package:flutter/material.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;

class CalculatorExpression extends StatelessWidget {
  final String text;
  final Map theme;
  const CalculatorExpression({super.key, required this.text, this.theme=styling.theme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: styling.fontSizeInputNormal,
      width: (MediaQuery.of(context).size.width/100)*80,
      child: Text(text,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: styling.fontSizeInputNormal, color: theme["text"]),
      ),
    );
  }
}