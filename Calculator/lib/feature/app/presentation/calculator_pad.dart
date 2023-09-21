
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/feature/app/domain/expression_cubit.dart';
import 'package:hello_world/feature/app/domain/theme_cubit.dart';
import 'CalculatorButton/calculatorbutton.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;

class CalculatorPad extends StatelessWidget {
  final Map theme;

  CalculatorPad({super.key,
    this.theme=styling.theme,
  }) {}

  expressionProvider (context) =>  BlocProvider.of<CaluclatorExpressionCubit>(context);
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
        expressionProvider(context).update("");
        expressionProvider(context).solve("");
      };
    } else if ( label == "=" ) {
      callback = () {
        expressionProvider(context).update(state.expression);
        expressionProvider(context).solve(state.expression);
      };
    }else if (label == "×"){
      callback =() {
        expressionProvider(context).update(state.expression + "*");
      };
    } else if (label == "÷"){
      callback =() {
        expressionProvider(context).update(state.expression + "/");
      };
    }else {
      callback =() {
        expressionProvider(context).update(state.expression + label);
      };
    }
    return callback;
  }

  List<Widget> generateCalculatorButtons(context, state, globaltheme) {
    List<Widget> buttons = [];
    final List<String> additionalLabels = [..."()^√!".split(""), "tan", "cos", "sin"];
    final List<String> labels = [ ..."C%⌫÷789×456-123+".split(""), "00", "0", ".", "="];

    if (globaltheme["additional"]) {
      additionalLabels.forEach((label) {
        buttons.add(
            CalculatorButtonThemed(
              title: label,
              callback: getCallbackByLabel(context, state, label),
              theme: globaltheme,
            )
        );
      });
    }

    int counter = 0;
    labels.forEach((label) {
      counter +=1 ;
      Map currentTheme = Map.from(globaltheme);
      currentTheme["main"] = (counter % 4 != 0) ? globaltheme["main"] : globaltheme["accent"];
      currentTheme["text"] = (counter % 4 != 0) ? globaltheme["text"] : globaltheme["main"];
      buttons.add(
        CalculatorButtonThemed(
          title: label,
          callback: getCallbackByLabel(context, state, label),
          theme: currentTheme,
        )
      );
    });

    return buttons;
  }


  Widget build(BuildContext context) {
    return BlocBuilder<CaluclatorExpressionCubit, CaluclatorExpressionState>(
        builder: (context, state) {
          return SizedBox(
            height: (MediaQuery.of(context).size.height),
            width: ((MediaQuery.of(context).size.height/100)*43)%(MediaQuery.of(context).size.height/100*80),
            child: GridView.count(
              childAspectRatio: theme["grid-ratio"],
              crossAxisCount: 4,
              crossAxisSpacing: theme["grid-horizontal-spacing"],
              mainAxisSpacing: theme["grid-vertical-spacing"],
              children: [...generateCalculatorButtons(context, state, theme)],
            ),
          );
        }
    );
  }
}
