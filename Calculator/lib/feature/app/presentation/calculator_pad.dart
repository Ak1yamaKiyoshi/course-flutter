
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/feature/app/data/calulator_expression_cubit.dart';
import './calculator_button.dart';


class CalculatorPad extends StatelessWidget {
  CalculatorPad({super.key}) {}

  final List<String> lables = [..."789456123".split(""), "00", "0", "+", "*", "/", "-", "X", "Enter", "AC"];

  List<Widget> generateCalculatorButtons(context, state) {
    List<Widget> buttons = [];
    lables.forEach((label) {
      buttons.add(
          CalculatorButton(
              title: label,
              callback: () {
                if (label == "X") {
                  BlocProvider.of<CaluclatorExpressionCubit>(context).update(
                      state.expression.substring(
                          0, state.expression.length - 1));
                } else if ( label == "AC" ){
                  BlocProvider.of<CaluclatorExpressionCubit>(context).update("");
                  BlocProvider.of<CaluclatorExpressionCubit>(context).solve("");
                } else if ( label == "Enter" ) {
                  BlocProvider.of<CaluclatorExpressionCubit>(context).update(state.expression);
                  BlocProvider.of<CaluclatorExpressionCubit>(context).solve(state.expression);
                } else {
                  BlocProvider.of<CaluclatorExpressionCubit>(context).update(state.expression + label);
                }
              }
          ),
      );
    });
    return buttons;
  }


  Widget build(BuildContext context) {
    return
      Container(
        height: 700,
        child: BlocConsumer<
            CaluclatorExpressionCubit,
            CaluclatorExpressionState> (
          listener: (context, state) { },
          builder: (context, state) {
            return GridView.count(
              childAspectRatio: (150 / 100),
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              children: [...generateCalculatorButtons(context, state)],
            );
          },
        ),
    );
  }
}
