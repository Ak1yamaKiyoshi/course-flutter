import 'package:flutter/material.dart';

void main() {
  runApp( Calculator() );

}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var buttons = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "*", "/", "-", "+"];
  var txt = TextEditingController();

  List <TextButton> _generateButttons() {
    List <TextButton>  output = [];
    buttons.forEach((element) {
      output.add(
        TextButton(
          onPressed: () => {},
          child: Text(element),
          style: TextButton.styleFrom(
            side: BorderSide(width: 3.0),
          ),
        )
      );
    });
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: 
          Row(children: [
            
            SizedBox(
              height: 300.0,
              
              child: TextField(
                controller: txt,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Expression",
                ),
              ),
            ),
            
            GridView.count(
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 4,
              children: [
                ..._generateButttons()
              ],
            ),
          ],
        ), 
      ),

    );
  }
}