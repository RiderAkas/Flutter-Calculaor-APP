// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String userInput = '';
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 51, 85),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: resultwidget()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonwidget(text: 'AC'),
                buttonwidget(text: 'C'),
                buttonwidget(text: '('),
                buttonwidget(text: ')'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonwidget(text: '/'),
                buttonwidget(text: '7'),
                buttonwidget(text: '8'),
                buttonwidget(text: '9'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonwidget(text: 'x'),
                buttonwidget(text: '4'),
                buttonwidget(text: '5'),
                buttonwidget(text: '6'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonwidget(text: '+'),
                buttonwidget(text: '1'),
                buttonwidget(text: '2'),
                buttonwidget(text: '3'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonwidget(text: '-'),
                buttonwidget(text: '0'),
                buttonwidget(text: '.'),
                buttonwidget(text: '='),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget resultwidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(top: 5, left: 10),
          alignment: Alignment.centerRight,
          child: Text(
            userInput,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 45, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget buttonwidget({required String text}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        child: MaterialButton(
          onPressed: () {
            buttonfunction(text);
          },
          shape: StadiumBorder(),
          color: Color.fromARGB(255, 15, 51, 85),
          padding: EdgeInsets.all(15),
          elevation: 5.0,
          child: Text(text, style: TextStyle(fontSize: 35, color: Colors.blue)),
        ),
      ),
    );
  }

  buttonfunction(String butntext) {
    String expressin = '';
    setState(() {
      if (butntext == 'AC') {
        userInput = '';
        result = '';
        expressin = '';
      } else if (butntext == 'C') {
        if (userInput != null) {
          userInput = userInput.substring(0, userInput.length - 1);
        } else {
          userInput = '';
        }
      } else if (butntext == '.') {
        if (userInput.contains('.')) {
          print('Already contains');
          return;
        } else {
          userInput += butntext;
        }
      } else if (butntext == '=') {
        expressin = userInput;
        expressin = expressin.replaceAll('x', '*');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expressin);
          ContextModel cm = ContextModel();
          userInput = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          print(e);
        }
      } else {
        userInput = userInput + butntext;
      }
    });
  }
}
