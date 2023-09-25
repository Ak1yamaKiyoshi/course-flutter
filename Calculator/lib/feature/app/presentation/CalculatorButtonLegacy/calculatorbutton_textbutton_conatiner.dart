import 'package:flutter/material.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;



class CalculatorButtonContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final bool neumorphismTheme;

  const CalculatorButtonContainer({
    super.key,
    required this.child,
    this.neumorphismTheme=true,
    this.borderRadius=styling.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: (neumorphismTheme) ? styling.calculatorEffectOut : [],
      ),
      child: child,
    );
  }
}

