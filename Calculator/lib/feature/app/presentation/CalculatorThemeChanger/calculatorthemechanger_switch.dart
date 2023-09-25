import 'package:flutter/material.dart';

import 'package:hello_world/feature/app/domain/styling.dart' as styling;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/feature/app/domain/theme_cubit.dart';
import 'calculatorthemechanger_slider.dart';


class CalculatorThemeChangerSwitch extends StatefulWidget {
  final Function onChangeCallback;
  final Color main;
  final Color secondary;
  final Color accent;
  final String label;
  final Color text;
  final bool valueToSwitch;
  CalculatorThemeChangerSwitch({super.key,
    required this.onChangeCallback,
    required this.label,
    required this.valueToSwitch,
    this.main = styling.originMain,
    this.secondary = styling.originSecondary,
    this.accent = styling.originAccent,
    this.text = styling.originText,
  });

  @override
  State<CalculatorThemeChangerSwitch> createState() => _CalculatorThemeChangerSwitchState();
}


class _CalculatorThemeChangerSwitchState extends State<CalculatorThemeChangerSwitch>  {
  _CalculatorThemeChangerSwitchState();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
        ThemeCubit,
        ThemeState> (
        builder: (context, state) {
          return Column(
              children: [
                CalculatorThemeChangerSliderText(
                    label: widget.label,
                    text: widget.text
                ),
                Switch(
                    value: widget.valueToSwitch,
                    onChanged: (value) {
                      widget.onChangeCallback(value);
                 }),
              ]
          );
        },
        listener: (context, state){}
    );
  }
}