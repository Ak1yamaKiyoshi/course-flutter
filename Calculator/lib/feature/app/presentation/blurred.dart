import 'package:flutter/material.dart';
import 'dart:ui' as ui;


class Blurred extends StatelessWidget {
  final Widget child;
  final double blur;
  const Blurred({
    super.key,
    required this.child,
    required this.blur
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: child,
    );
  }
}