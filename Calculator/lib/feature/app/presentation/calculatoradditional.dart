
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_world/feature/app/domain/styling.dart' as styling;

import 'package:flutter/material.dart';
import 'package:hello_world/feature/app/domain/theme_cubit.dart';

class AdditionalCalculatorButton extends StatelessWidget {
  final Map theme;
  AdditionalCalculatorButton({
    super.key,
    this.theme=styling.theme,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return
            SizedBox(
              width: 60,
            child: TextButton(
                style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(theme["main"])
              ),
              onPressed: () {BlocProvider.of<ThemeCubit>(context).updateAdditional(!state.theme.t["additional"]); },
              child: Text(
                "more",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: theme["text"]
                ),
              )
          ),
            );
        }
    );


  }
}