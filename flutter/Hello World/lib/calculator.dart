import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eval_ex/expression.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});
  State<Calculator> createState() => _Calculator();
}

class _Calculator extends State<Calculator> {
  String expression = "";
  final expressionController = TextEditingController();
  bool justEvaluated = false;

  List<Container> _generateCalculatorButtons() {
    List<Container> buttons = [];
    List<String> lables = "123456789+0-*/XE".split("");
    lables.forEach((label) {
      buttons.add(
          Container(
            child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black87)
                        ),
                  ),
                ),
                onPressed: (){
                  _handleButtonPress(label);
                },
                child: Text(label)
            )
          )
      );
    });
    return buttons;
  }

  bool _isValidExpression(String expression) {
    Set <bool> isValid = {
        RegExp(r'[\-+%\/*]{2,}').hasMatch(expression),
        RegExp(r'^[+%\/*]').hasMatch(expression),
        RegExp('[^0-9+\-/*+]').hasMatch(expression),
    };
    return !isValid.contains(true);
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
      if (_isValidExpression(futureExpression)) {
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
