import 'package:flutter/material.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;


class CalculatorButtonStyle {
  final Color main;
  final Color secondary;
  final double borderRadius;
  final double borderWidth;

  const CalculatorButtonStyle({
    this.main=styling.originMain,
    this.secondary=styling.originSecondary,
    this.borderRadius=styling.borderRadius,
    this.borderWidth=styling.borderWidth,
  });

  bool hasBorder (borderWidth) { return (borderWidth > 0.0) ? true : false; }

  MaterialStateProperty<OutlinedBorder> withBorder() {
    return  MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side:  BorderSide(
                color: secondary,
                width: borderWidth
            )
        )
    );
  }

  MaterialStateProperty<OutlinedBorder> withoutBorder() {
    return MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        )
    );
  }

  ButtonStyle style() {
    return  ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(main),
      shape: (hasBorder(borderWidth)) ? withBorder() : withoutBorder(),
    );
  }
}
