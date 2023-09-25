
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/feature/app/domain/theme_cubit.dart';
import 'package:hello_world/feature/app/presentation/CalculatorThemeChanger/calculator_theme_changer.dart';
import 'package:hello_world/feature/app/presentation/calculator_input.dart';
import 'package:hello_world/feature/app/presentation/calculator_pad.dart';
import '../calculator_answer.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;

import '../calculatoradditional.dart';

class CalculatoBodyConatiner extends StatelessWidget {
  final children;
  const CalculatoBodyConatiner(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: children
        ),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<StatefulWidget> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              color: state.theme["main"],
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: state.theme["main"],
                  ),
                  CalculatoBodyConatiner(
                    [
                      CalculatorInput(theme: state.theme),
                      AdditionalCalculatorButton(),
                      CalculatorPad(theme: state.theme)
                    ],
                  ),
              Container(color: state.theme["main"],
                  child: ExpandablePanel(
                    collapsed: const Text(""),
                    header:   Text("", textAlign: TextAlign.center,),
                    expanded: CalculatorThemeChanger(),
                  ) ,),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          setState(() { });
        }
    );


  }
}