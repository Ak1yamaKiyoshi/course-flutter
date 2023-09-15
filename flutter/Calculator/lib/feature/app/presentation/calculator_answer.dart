import 'package:flutter/material.dart';
import 'package:hello_world/feature/app/data/styling.dart' as styling;

class CalculatorAnswer extends StatelessWidget {
  final text;
  const CalculatorAnswer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: (MediaQuery.of(context).size.width/100)*80,
      child: Text(text,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: styling.textFontSizeMedium),
      ),
    );
  }
}