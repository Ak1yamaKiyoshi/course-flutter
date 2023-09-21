
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/feature/app/domain/expression_cubit.dart';
import 'package:hello_world/feature/app/presentation/calculator_expression.dart';
import './calculator_answer.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;



class CalculatorInput extends StatefulWidget {
  final Map theme;
  const CalculatorInput({super.key,
  this.theme=styling.theme});

  @override
  State<CalculatorInput> createState() => _CalculatorInputState();
}


class _CalculatorInputState extends State<CalculatorInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<CaluclatorExpressionCubit, CaluclatorExpressionState>(
          builder: (context, state) {
            return Column(
              children: [
                CalculatorExpression(
                    text: state.expression,
                    theme: widget.theme
                ),
                CalculatorAnswer(
                  text: state.solvedExpression,
                  theme: widget.theme
                ),
              ],
            );
          }
      );
  }
}
