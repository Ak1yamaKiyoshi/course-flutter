
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/feature/app/domain/expression_cubit.dart';
import 'package:hello_world/feature/app/presentation/calculator_expression.dart';
import 'package:hello_world/feature/app/presentation/calculatoradditional.dart';
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
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((widget.theme["border-radius"])/100*50),
                boxShadow: (widget.theme["neumorphism"]) ? styling.calculatorEffectIn(widget.theme["main"]) : [],
              ),
              child: Column(
                children: [
                  CalculatorExpression(
                      text: state.expression,
                      theme: widget.theme
                  ),
                  Row(
                    children: [
                      //AdditionalCalculatorButton(
                      //  theme: widget.theme,
                      //),
                      CalculatorAnswer(
                        text: state.solvedExpression,
                        theme: widget.theme
                      ),
                    ],
                  )
                ],
              ),
            );
          }
      );
  }
}
