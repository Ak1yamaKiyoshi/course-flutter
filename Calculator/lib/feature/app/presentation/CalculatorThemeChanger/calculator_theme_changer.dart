import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/feature/app/domain/theme_cubit.dart';
import 'calculatorthemechanger_slider.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;
import 'calculatorthemechanger_switch.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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



class CalculatorThemeChanger extends StatefulWidget {
  @override
  State<CalculatorThemeChanger> createState() => _CalculatorThemeChangerState();
}

class _CalculatorThemeChangerState extends State<CalculatorThemeChanger>   {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<
    ThemeCubit,
    ThemeState> (
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height/3,
          child: Container(
            color: state.theme.t["main"],
          margin: EdgeInsets.all(10.0),
          child: ListView(
            children: [
              CalculatorThemeChangerSlider(
                  onChangeCallback: (value) {
                    BlocProvider.of<ThemeCubit>(context).updateTheme("border-radius", value);
                  },
                  label: "border radius",
                  currentSliderValue: state.theme.t["border-radius"],
                  minSliderValue: 0, maxSliderValue: 50,
              ),
              CalculatorThemeChangerSlider(
                onChangeCallback: (value) {
                  BlocProvider.of<ThemeCubit>(context).updateTheme("border-width", value);
                },
                label: "border width",
                currentSliderValue: state.theme.t["border-width"],
                minSliderValue: 0, maxSliderValue: 20,
              ),
              CalculatorThemeChangerSlider(
                onChangeCallback: (value) {
                  BlocProvider.of<ThemeCubit>(context).updateTheme("button-blur", value/30);
                },
                label: "button blur",
                currentSliderValue: state.theme.t["button-blur"]*30,
                minSliderValue: 0, maxSliderValue: 30,
              ),
              CalculatorThemeChangerSlider(
                onChangeCallback: (value) {
                  BlocProvider.of<ThemeCubit>(context).updateTheme("grid-horizontal-spacing", value);
                },
                label: "grid x spacing ",
                currentSliderValue: state.theme.t["grid-horizontal-spacing"],
                minSliderValue: 0, maxSliderValue: 150,
              ),
              CalculatorThemeChangerSlider(
                onChangeCallback: (value) {
                  BlocProvider.of<ThemeCubit>(context).updateTheme("grid-vertical-spacing", value);
                },
                label: "y spacing",
                currentSliderValue: state.theme.t["grid-vertical-spacing"],
                minSliderValue: 0, maxSliderValue: 150,
              ),
              CalculatorThemeChangerSlider(
                onChangeCallback: (value) {
                  if (value != 0) {
                    BlocProvider.of<ThemeCubit>(context).updateTheme(
                        "grid-ratio", value / 100);
                    }
                },
                label: "button ratio",
                currentSliderValue: state.theme.t["grid-ratio"]*100,
                minSliderValue: 0,
                maxSliderValue: 200,
              ),
              CalculatorThemeChangerSwitch(
                onChangeCallback: BlocProvider.of<ThemeCubit>(context).updateNeumorphism,
                label: 'neumorphism',
                valueToSwitch: (state.theme.t["neumorphism"] && true),
              ),
              Divider(height: 20,),
              CalculatorThemeChangerSliderText(text: state.theme.t["text"], label: " main color "),
              ColorPicker(
                pickerColor: state.theme.t["main"], //default color
                onColorChanged: (Color color){ //on color picked
                  BlocProvider.of<ThemeCubit>(context).updateTheme("main", color);
                },
              ),
              Divider(height: 20,),
              CalculatorThemeChangerSliderText(text: state.theme.t["text"], label: " secondary ( border ) color "),
              ColorPicker(
                pickerColor: state.theme.t["secondary"], //default color
                onColorChanged: (Color color){ //on color picked
                  BlocProvider.of<ThemeCubit>(context).updateTheme("secondary", color);
                },
              ),
              Divider(height: 20,),
              CalculatorThemeChangerSliderText(text: state.theme.t["text"], label: " text color "),
              ColorPicker(
                pickerColor: state.theme.t["text"], //default color
                onColorChanged: (Color color){ //on color picked
                  BlocProvider.of<ThemeCubit>(context).updateTheme("text", color);
                },
              ),
              Divider(height: 20,),
              CalculatorThemeChangerSliderText(text: state.theme.t["text"], label: " accent color "),
              ColorPicker(
                pickerColor: state.theme.t["accent"], //default color
                onColorChanged: (Color color){ //on color picked
                  BlocProvider.of<ThemeCubit>(context).updateTheme("accent", color);
                },
              ),
            ]
          ),
        ),
        );
      },
      listener: (context, state) {},
    );
  }
}