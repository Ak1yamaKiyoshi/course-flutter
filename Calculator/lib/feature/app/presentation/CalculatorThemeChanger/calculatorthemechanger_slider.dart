import 'package:flutter/material.dart';

import 'package:hello_world/feature/app/domain/styling.dart' as styling;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/feature/app/domain/theme_cubit.dart';

class CalculatorThemeChangerSlider extends StatefulWidget {
  final Function onChangeCallback;
  double currentSliderValue;
  final double maxSliderValue;
  final double minSliderValue;
  final Color main;
  final Color secondary;
  final Color accent;
  final String label;
  final Color text;
  CalculatorThemeChangerSlider({super.key,
    required this.onChangeCallback,
    required this.currentSliderValue,
    required this.minSliderValue,
    required this.maxSliderValue,
    required this.label,
    this.main = styling.originMain,
    this.secondary = styling.originSecondary,
    this.accent = styling.originAccent,
    this.text = styling.originText,
  });

  @override
  State<CalculatorThemeChangerSlider> createState() => _CalculatorThemeChangerSliderState();
}



class CalculatorThemeChangerSliderText extends StatelessWidget {
  final String label;
  final Color text;

  const CalculatorThemeChangerSliderText({
    super.key,
    required this.label,
    this.text = styling.originText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: text,
          fontSize: styling.fontSizeSliderTextNormal
        ),
    );
  }

}


class _CalculatorThemeChangerSliderState extends State<CalculatorThemeChangerSlider>  {
  _CalculatorThemeChangerSliderState();

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
                Slider(
                  value: widget.currentSliderValue,
                  max: widget.maxSliderValue - widget.minSliderValue,
                  divisions: (widget.maxSliderValue - widget.minSliderValue).round(),
                  label: widget.currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() { widget.currentSliderValue = value; });
                    widget.onChangeCallback(value);
                  },
                ),
              ]
          );
        },
        listener: (context, state){}
    );
  }
}