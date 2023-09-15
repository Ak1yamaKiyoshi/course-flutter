import 'package:flutter/material.dart';


ThemeData theme(){
  return ThemeData(
      useMaterial3: true,
      textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Colors.blue,
      )
  );
}