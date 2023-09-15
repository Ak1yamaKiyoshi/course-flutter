
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/feature/app/data/calulator_expression_cubit.dart';
import './calculator_answer.dart';
import 'package:hello_world/feature/app/data/styling.dart' as styling;

class CalculatorInput extends StatefulWidget {
  const CalculatorInput({super.key});

  @override
  State<CalculatorInput> createState() => _CalculatorInputState();
}


class _CalculatorInputState extends State<CalculatorInput> {
  final TextEditingController expressionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List<TextInputFormatter> filters = [
    FilteringTextInputFormatter.deny(RegExp(r'[\-+\/*]{2,}')),
    FilteringTextInputFormatter.deny(RegExp(r'^[+\/*]')),
    FilteringTextInputFormatter.deny(RegExp('[^0-9+\-/*+]')),
  ];

  void handleChange(String newExpression, state) {
    BlocProvider.of<CaluclatorExpressionCubit>(context).update(newExpression);
    expressionController.selection = TextSelection.collapsed(offset: state.expression.length);
  }

  void handleSubmit(String newExpression, state) {
    BlocProvider.of<CaluclatorExpressionCubit>(context).solve(newExpression);
    expressionController.text = state.expression;
    expressionController.selection = TextSelection.collapsed(offset: state.expression.length);
  }


  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<CaluclatorExpressionCubit, CaluclatorExpressionState>(
          builder: (context, state) {
            return Column(
              children: [
                BlocConsumer<
                    CaluclatorExpressionCubit,
                    CaluclatorExpressionState>(
                  listener: (context, state) {
                    if (state.expression != expressionController.text) {
                      expressionController.text = state.expression;
                      handleChange(state.expression, state);
                    }
                  },
                  builder: (context, state) {
                    return TextField(
                      autofocus: false,
                      controller: expressionController,
                      onChanged: (String temp) {handleChange(temp, state); },
                      onSubmitted: (String temp) {handleSubmit(temp, state); },
                      inputFormatters: filters,
                      style: TextStyle(
                          color: styling.colorText,
                          fontSize: styling.textFontSizeExtra,
                      ),
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: styling.calculatorInputHint,
                        hintStyle: TextStyle(
                            fontSize: styling.textFontSizeMedium,
                            color: styling.colorSecondaryFaded
                        ),
                        focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(
                              width: styling.borderWidth,
                              color: styling.colorBase,
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: styling.borderWidth,
                              color: styling.colorBase,
                            )
                        ),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0,
                  color: styling.colorSecondary,
                ),
                CalculatorAnswer(
                  text: state.solvedExpression,
                ),
              ],
            );
          }
      );
  }
}
