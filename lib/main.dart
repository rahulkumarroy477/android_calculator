import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

//  ctrl + shift + R to wrap the widget
void main() {
  runApp(const MaterialApp(
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
  var input = '';
  var output = '';
  var op = '';
  var hideInput = false;
  var outputsize = 34.0;
  onButtonClk(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      var userInput = input;
      userInput = input.replaceAll("x", "*");
      Parser p = Parser();
      Expression exp = p.parse(userInput);
      ContextModel cm = ContextModel();
      var finalValue = exp.evaluate(EvaluationType.REAL, cm);
      output = finalValue.toString();
      if (output.endsWith(".0")) {
        output = output.substring(0, output.length - 2);
      }
      input = output;
      hideInput = true;
      outputsize = 52;
    } else {
      input = input + value;
      hideInput = false;
      outputsize = 34;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      //     centerTitle: true,
      //     title: const Text(
      //       'Calculator',
      //       style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      //     )),
      backgroundColor: Colors.black,
      body: Column(children: [
        // input output area
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          // color: Colors.red,
          // specifying this becaz expanded will take only space of padding
          // but we want it on complete upper part
          child: Column(
              // alignment of input and output
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(hideInput ? '' : input,
                    style: const TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Text(output,
                    style: TextStyle(
                      fontSize: outputsize,
                      color: Colors.white.withOpacity(0.7),
                    )),
                const SizedBox(
                  height: 30,
                )
              ]),
        )),
        Container(
          margin: const EdgeInsets.all(12),
          height: 2,
          color: Colors.white,
        ),
        Row(
          children: [
            smallbutton(
                text: "AC", tcolor: const Color.fromARGB(255, 18, 239, 26)),
            smallbutton(text: "<<", tcolor: Colors.orange),
            smallbutton(text: "(", tcolor: Colors.cyan),
            smallbutton(text: ")", tcolor: Colors.cyan),
            // button(text: ")", bgcolor: Colors.transparent),
            smallbutton(text: "/", tcolor: Colors.orange),
          ],
        ),
        Row(
          children: [
            button(text: "7"),
            button(text: "8"),
            button(text: "9"),
            button(text: "x", tcolor: Colors.orange),
          ],
        ),
        Row(
          children: [
            button(text: "4"),
            button(text: "5"),
            button(text: "6"),
            button(text: "-", tcolor: Colors.orange),
          ],
        ),
        Row(
          children: [
            button(text: "1"),
            button(text: "2"),
            button(text: "3"),
            button(text: "+", tcolor: Colors.orange),
          ],
        ),
        Row(
          children: [
            button(text: "%", tcolor: Colors.orange),
            button(text: "0"),
            button(text: "."),
            button(text: "=", bgcolor: Colors.orange),
          ],
        ),
      ]),
    );
  }

  Widget button({text, tcolor = Colors.white, bgcolor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(25),
          ),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: tcolor),
          ),
          onPressed: () => onButtonClk(text),
        ),
      ),
    );
  }

  Widget smallbutton({text, tcolor = Colors.white, bgcolor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(20),
          ),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: tcolor),
          ),
          onPressed: () => onButtonClk(text),
        ),
      ),
    );
  }
}
