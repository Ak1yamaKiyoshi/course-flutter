import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/feature/app/domain/theme_cubit.dart';
import './calculatorthemechanger_slider.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;
import './calculatorthemechanger_switch.dart';
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
                    BlocProvider.of<ThemeCubit>(context).updateBorderRadius(value);
                  },
                  label: "border radius",
                  currentSliderValue: state.borderRadius,
                  minSliderValue: 0,
                  maxSliderValue: 50,
              ),
              CalculatorThemeChangerSlider(
                onChangeCallback: (value) {
                  BlocProvider.of<ThemeCubit>(context).updateBorderWidth(value);
                },
                label: "border width",
                currentSliderValue: state.borderWidth,
                minSliderValue: 0,
                maxSliderValue: 20,
              ),
              CalculatorThemeChangerSlider(
                onChangeCallback: (value) {
                  BlocProvider.of<ThemeCubit>(context).updateButtonBlur(value);
                },
                label: "border blur",
                currentSliderValue: state.buttonBlur,
                minSliderValue: 0,
                maxSliderValue: 3,
              ),
              CalculatorThemeChangerSlider(
                onChangeCallback: (value) {
                  BlocProvider.of<ThemeCubit>(context).updateGridXSpacing(value);
                },
                label: "x spacing ",
                currentSliderValue: state.gridXAxisSpacing,
                minSliderValue: 0,
                maxSliderValue: 150,
              ),
              CalculatorThemeChangerSlider(
                onChangeCallback: (value) {
                  BlocProvider.of<ThemeCubit>(context).updateGridYSpacing(value);
                },
                label: "y spacing",
                currentSliderValue: state.gridYAxisSpacing,
                minSliderValue: 0,
                maxSliderValue: 150,
              ),
              CalculatorThemeChangerSlider(
                onChangeCallback: (value) {
                  if (value != 0)
                    BlocProvider.of<ThemeCubit>(context).updateGridRatio(value/100);
                },
                label: "ratio",
                currentSliderValue: state.gridRratio*100,
                minSliderValue: 0,
                maxSliderValue: 200,
              ),
              CalculatorThemeChangerSwitch(
                onChangeCallback: BlocProvider.of<ThemeCubit>(context).updateNeumorphism,
                label: 'neumorphism',
                valueToSwitch: state.isNeumorphismTheme,
              ),
              ColorPicker(
                pickerColor: state.main, //default color
                onColorChanged: (Color color){ //on color picked
                  BlocProvider.of<ThemeCubit>(context).updateMain(color);
                },
              ),
              ColorPicker(
                pickerColor: state.secondary, //default color
                onColorChanged: (Color color){ //on color picked
                  BlocProvider.of<ThemeCubit>(context).updateSecondary(color);
                },
              ),
              ColorPicker(
                pickerColor: state.text, //default color
                onColorChanged: (Color color){ //on color picked
                  BlocProvider.of<ThemeCubit>(context).updateText(color);
                },
              ),
              ColorPicker(
                pickerColor: state.accent, //default color
                onColorChanged: (Color color){ //on color picked
                  BlocProvider.of<ThemeCubit>(context).updateAccent(color);
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