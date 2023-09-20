
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/feature/app/domain/expression_cubit.dart';
import 'package:hello_world/feature/app/domain/theme_cubit.dart';
import 'CalculatorButton/calculatorbutton.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;

class CalculatorPad extends StatelessWidget {
  Color main;
  Color secondary;
  Color accent;
  Color text;

  double borderRadius;
  double borderWidth;

  double buttonBlur;

  double gridXAxisSpacing;
  double gridYAxisSpacing;

  CalculatorPad({super.key,
    this.main=styling.originMain,
    this.secondary=styling.originSecondary,
    this.accent=styling.originAccent,
    this.text = styling.originText,
    this.gridYAxisSpacing=styling.gridYAxisSpacing,
    this.gridXAxisSpacing=styling.gridXAxisSpacing,
    this.buttonBlur=styling.buttonBlur,
    this.borderRadius=styling.borderRadius,
    this.borderWidth=styling.borderWidth,
    //required this.isAutumnTheme,
    //required this.isNeumorphismTheme,
    //required this.showAdditionalButtons,
  }) {}

  Function getCallbackByLabel(context, state, label) {
    Function callback;
    if (label == "⌫") {
      callback = () {
        BlocProvider.of<CaluclatorExpressionCubit>(context).update(
          state.expression.substring(
              0, state.expression.length - 1));
      };
    } else if ( label == "C" ){
      callback =() {
        BlocProvider.of<CaluclatorExpressionCubit>(context).update("");
        BlocProvider.of<CaluclatorExpressionCubit>(context).solve("");
      };
    } else if ( label == "=" ) {
      callback =() {
        BlocProvider.of<CaluclatorExpressionCubit>(context).update(state.expression);
        BlocProvider.of<CaluclatorExpressionCubit>(context).solve(state.expression);
      };
    }else if (label == "×"){
      callback =() {
        BlocProvider.of<CaluclatorExpressionCubit>(context).update(state.expression + "*");
      };
    } else if (label == "÷"){
      callback =() {
        BlocProvider.of<CaluclatorExpressionCubit>(context).update(state.expression + "/");
      };
    }else {
      callback =() {
        BlocProvider.of<CaluclatorExpressionCubit>(context).update(state.expression + label);
      };
    }
    return callback;
  }

  List<Widget> generateCalculatorButtons(oldcontext, oldstate) {
    List<Widget> buttons = [];
    final List<String> additionalLabels = [..."()^√!".split(""), "tan", "cos", "sin"];
    final List<String> labels = [ ..."C%⌫÷789×456-123+".split(""), "00", "0", ",", "="];

    if (oldstate.showAdditionalButtons) {
      additionalLabels.forEach((label) {
        buttons.add(
            BlocConsumer<CaluclatorExpressionCubit, CaluclatorExpressionState>(
                listener: (context, stateCalculator) {},
                builder: (context, state) {
                  return CalculatorButton(
                    title: label,
                    callback: getCallbackByLabel(context, state, label),
                    main: main,
                    text: accent,
                    buttonBlur: buttonBlur,
                  );
                }
            )
        );
      });
    }

    int i = 0;
    labels.forEach((label) {
      i +=1 ;
      Color maincolor =  (i % 4 != 0) ? main : accent;
      Color textcolor = (i % 4 != 0) ? text : main;
      buttons.add(
          BlocConsumer<CaluclatorExpressionCubit, CaluclatorExpressionState>(
              listener: (context, stateCalculator) {},
              builder: (context, state) {
                return CalculatorButton(
                  title: label,
                  callback: getCallbackByLabel(context, state, label),
                  main: maincolor,
                  text: textcolor,
                  secondary: secondary,
                  borderRadius: borderRadius,
                  borderWidth: borderWidth,
                );
              }
          )
      );
    });

    return buttons;
  }

  Widget build(BuildContext context) {
    return
      Expanded(
        child:BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return GridView.count(
                childAspectRatio: (state.gridRratio),
                crossAxisCount: 4,
                crossAxisSpacing: state.gridXAxisSpacing,
                mainAxisSpacing: state.gridYAxisSpacing,
                children: [...generateCalculatorButtons(context, state)],
              );
          },
        ),
    );
  }
}
