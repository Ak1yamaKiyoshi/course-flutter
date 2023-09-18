import 'package:flutter/material.dart';
import 'package:hello_world/feature/app/data/styling.dart' as styling;

class CalculatorButton extends StatelessWidget {
  final String title;
  final Function callback;
  const CalculatorButton({super.key, required this.title, required this.callback});

  ButtonStyle generateButtonStyle() {
    return  ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(styling.colorSecondary),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(styling.borderRadius),
            side: const BorderSide(
                color: styling.colorSecondaryFaded,
                width: styling.borderWidth
            ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(styling.borderRadius),
          boxShadow: [
            BoxShadow(
              color: styling.wine,
              blurRadius: 5,
              offset: Offset(2, 4), // Shadow position
            ),
          ],
        ),
        child: TextButton(
          onPressed: () { callback(); },
          style: generateButtonStyle(),
          child: Text(
             title,
            style: TextStyle(
                color: styling.colorBase,
                fontSize: styling.textFontSizeLarge,
            ),
          ),
        )
    );
  }
}