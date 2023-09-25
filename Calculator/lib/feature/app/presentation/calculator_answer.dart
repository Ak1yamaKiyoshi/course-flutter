import 'package:flutter/material.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;

class CalculatorAnswer extends StatelessWidget {
  final text;
  final Map theme;
  const CalculatorAnswer({super.key, required this.text, this.theme=styling.theme});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(text,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: styling.fontSizeInputSmall, color: theme["accent"]),
      ),
    );
  }
}