import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/feature/app/domain/theme_cubit.dart';
import 'calculatorthemechanger_slider.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;
import 'calculatorthemechanger_switch.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
          child: GridView.count(
            childAspectRatio: (100/100),
            crossAxisCount: 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            children: [
              CalculatorThemeChangerSlider(
                  onChangeCallback: (value) {
                    BlocProvider.of<ThemeCubit>(context).updateTheme("border-radius", value);
                  },
                  label: "border radius",
                  currentSliderValue: state.theme["border-radius"],
                  minSliderValue: 0, maxSliderValue: 50,
              ),
              CalculatorThemeChangerSlider(
                onChangeCallback: (value) {
                  BlocProvider.of<ThemeCubit>(context).updateTheme("border-width", value);
                },
                label: "border width",
                currentSliderValue: state.theme["border-width"],
                minSliderValue: 0, maxSliderValue: 20,
              ),
              CalculatorThemeChangerSlider(
                onChangeCallback: (value) {
                  BlocProvider.of<ThemeCubit>(context).updateTheme("button-blur", value/30);
                },
                label: "button blur",
                currentSliderValue: state.theme["button-blur"]*30,
                minSliderValue: 0, maxSliderValue: 30,
              ),
              CalculatorThemeChangerSlider(
                onChangeCallback: (value) {
                  BlocProvider.of<ThemeCubit>(context).updateTheme("grid-horizontal-spacing", value);
                },
                label: "grid x spacing ",
                currentSliderValue: state.theme["grid-horizontal-spacing"],
                minSliderValue: 0, maxSliderValue: 150,
              ),
              CalculatorThemeChangerSlider(
                onChangeCallback: (value) {
                  BlocProvider.of<ThemeCubit>(context).updateTheme("grid-vertical-spacing", value);
                },
                label: "y spacing",
                currentSliderValue: state.theme["grid-vertical-spacing"],
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
                currentSliderValue: state.theme["grid-ratio"]*100,
                minSliderValue: 0,
                maxSliderValue: 200,
              ),
              CalculatorThemeChangerSwitch(
                onChangeCallback: BlocProvider.of<ThemeCubit>(context).updateNeumorphism,
                label: 'neumorphism',
                valueToSwitch: (state.theme["neumorphism"] && true),
              ),
              ColorPicker(
                pickerColor: state.theme["main"], //default color
                onColorChanged: (Color color){ //on color picked
                  BlocProvider.of<ThemeCubit>(context).updateTheme("main", color);
                },
              ),
              ColorPicker(
                pickerColor: state.theme["secondary"], //default color
                onColorChanged: (Color color){ //on color picked
                  BlocProvider.of<ThemeCubit>(context).updateTheme("secondary", color);
                },
              ),
              ColorPicker(
                pickerColor: state.theme["text"], //default color
                onColorChanged: (Color color){ //on color picked
                  BlocProvider.of<ThemeCubit>(context).updateTheme("text", color);
                },
              ),
              ColorPicker(
                pickerColor: state.theme["accent"], //default color
                onColorChanged: (Color color){ //on color picked
                  BlocProvider.of<ThemeCubit>(context).updateTheme("accent", color);
                },
              ),
            ]
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}