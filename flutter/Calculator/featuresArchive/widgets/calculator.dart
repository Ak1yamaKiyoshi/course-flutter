import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eval_ex/expression.dart';
import '../../lib/feature/app/presentation/calculator_button.dart';
import '../validation/expression.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorApp extends MaterialApp {
  const Calculator({super.key}) : super(home: const CalculatorView)
  //State<Calculator> createState() => _Calculator();

}


class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext) {
    return Container();
  }
}

class CalculatorObserver extends BlocObserver {
  const CalculatorObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    print(" - bloc runtime: ${bloc.runtimeType} \n > change: $change");
  }
}



class CalculatorInput extends StatelessWidget {
  const CalculatorInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) { return Null; },
      child: CalculatorInputView(),
    );
  }
}

class CalculatorInputView extends StatelessWidget {
  CalculatorInputView({super.key});
  // styling
  final Color accent = Colors.blue;
  final Color base = Colors.white;
  final Color secondary = Colors.black87;
  final Color fadedSecondary = Colors.black26;
  final double borderRadius = 10.0;
  final double borderWidth = 1.0;
  final double fontSize = 20.0;

  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.deny(RegExp(r'[\-+%\/*]{2,}')),
          FilteringTextInputFormatter.deny(RegExp(r'^[+%\/*]')),
          FilteringTextInputFormatter.deny(RegExp('[^0-9+\-/*+]')),
        ],
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10.0),
          hintText: 'Enter your math expression here',
          hintStyle: TextStyle(
              fontSize: fontSize,
              color: fadedSecondary
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: borderWidth,
                color: secondary,
              )),
        ),
      ),
    );
  }
}


class _Calculator extends State<Calculator> {
  final ExpressionValidator validator = new ExpressionValidator();
  final expressionController = TextEditingController();

  bool justEvaluated = false;
  String expression = "";


  List<Widget> _generateCalculatorButtons() {
    List<Widget> buttons = [];
    List<String> lables = "123456789+0-*/XE".split("");
    lables.forEach((label) {
      buttons.add(
        CalculatorButton(title: label, callback: () {_handleButtonPress(label); })
      );
    });
    return buttons;
  }

  void _handleButtonPress(String label) {

    if (label == "X") {
      if (justEvaluated) {
        expressionController.text = "";
      }
      expressionController.text =
          expressionController.text.substring(0,
              expressionController.text.length-1,
          );
      this.justEvaluated = false;

    } else if (label == "E") {
        this.justEvaluated = true;
        _handleSubmit(expressionController.text);
    } else {
      this.justEvaluated = false;
      String futureExpression = expressionController.text + label;
      if (validator.isValidExpression(futureExpression)) {
        expressionController.text = futureExpression;
      }
    }

    expressionController.selection =
        TextSelection.collapsed(offset: expressionController.text.length);
  }


  String _eval_expression(String expression) {
    Expression exp = Expression(expression);
    return (exp.eval().toString());
  }

  void _handleSubmit(String str) {
    expressionController.text = _eval_expression(expressionController.text);
  }

  @override
  void dispose() {
    expressionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [
          AppBar(
            title: Text("Calculator"),
            centerTitle: true,
          ),
          TextField(
            controller: expressionController,
            onSubmitted: _handleSubmit,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp(r'[\-+%\/*]{2,}')),
              FilteringTextInputFormatter.deny(RegExp(r'^[+%\/*]')),
              FilteringTextInputFormatter.deny(RegExp('[^0-9+\-/*+]')),
            ],
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              hintText: 'Enter your math expression here',
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.black26),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                width: 1,
                color: Colors.black87,
              )),
            ),
          ),
          Container(
            height: 700,
            child: GridView.count(
                childAspectRatio: (150 / 100),
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: [..._generateCalculatorButtons()],
            ),
          ),
        ],
      ),
    ));
  }
}
