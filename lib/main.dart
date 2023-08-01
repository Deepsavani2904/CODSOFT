import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';




void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}


class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);


  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {

  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = "";
  var output = "";
  var operation = "";
  var hideInput = false;
  var outputSize = 38.0;


  onButtonClick(value) {
    if (value == "AC") {
      input = "";
      output = "";
    }
    else if (value == "<") {
      if(input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    }
    else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();

        if(output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }

        input = output;
        hideInput = true;
        outputSize = 49;
      }

    }
    else{
      input = input + value;
      hideInput = false;
      outputSize = 38;
    }

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.blueGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(hideInput ? " " : input,
                    style: TextStyle(fontSize: 45, color: Colors.white),),

                  SizedBox(
                    height: 18,
                  ),

                  Text(output, style: TextStyle(
                      fontSize: outputSize, color: Colors.white.withOpacity(0.8)),),

                  SizedBox(
                    height: 28,
                  ),
                ],
              ),
            ),
          ),

          Row(
            children: [
              button(text: "AC", buttonBgColor: Colors.lightBlueAccent),
              button(text: "( )", buttonBgColor: Colors.cyan[200]),
              button(text: "%", buttonBgColor: Colors.cyan[200]),
              button(text: "/", buttonBgColor: Colors.cyan[200]),
            ],
          ),

          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "x", buttonBgColor: Colors.cyan[200]),
            ],
          ),

          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(text: "-", buttonBgColor: Colors.cyan[200]),
            ],
          ),

          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+", buttonBgColor: Colors.cyan[200]),
            ],
          ),

          Row(
            children: [
              button(text: "0"),
              button(text: "."),
              button(text: "<"),
              button(text: "=", buttonBgColor: Colors.cyan[400]),
            ],
          ),


        ],
      ),
    );
  }

  Widget button({
    text, buttonBgColor = Colors.white, tColor = Colors.black
  }) {
    return Expanded(
        child: Container(
          margin: EdgeInsets.all(10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: buttonBgColor,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                )
            ),
            onPressed: () => onButtonClick(text),


            child: Text(text, style: TextStyle(
                color: tColor, fontSize: 18, fontWeight: FontWeight.bold),),
          ),
        )
    );
  }


}
