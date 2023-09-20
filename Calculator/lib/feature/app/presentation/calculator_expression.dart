import 'package:flutter/material.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;

class CalculatorExpression extends StatelessWidget {
  final String text;
  const CalculatorExpression({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: (MediaQuery.of(context).size.width/100)*80,
      child: Text(text,
        textAlign: TextAlign.right,
        style: const TextStyle(fontSize: styling.textFontSizeMedium),
      ),
    );
  }
}