import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/config/theme/app_themes.dart';
import 'package:hello_world/feature/app/domain/theme_cubit.dart';
import 'package:hello_world/feature/app/presentation/Calculator/calculator.dart';
import './feature/app/domain/expression_cubit.dart';


void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp (
      title: 'Calculator by Akiyama',
      theme: theme(),
      home: BlocProvider<CaluclatorExpressionCubit>(
        create: (context) => CaluclatorExpressionCubit(),
        child: BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
          child: Calculator(),
        )
      ),
    );
  }
}