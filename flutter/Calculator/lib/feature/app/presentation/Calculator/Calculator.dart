
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/feature/app/presentation/calculator_input.dart';
import 'package:hello_world/feature/app/presentation/calculator_pad.dart';
import '../calculator_answer.dart';
import 'package:hello_world/feature/app/data/styling.dart' as styling;

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        color: styling.colorBase,
      child: Column(
        children: [
          AppBar(
            backgroundColor: styling.colorBase,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height/100)*90,
            child: Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: [
                  CalculatorInput(),
                  CalculatorPad(),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}