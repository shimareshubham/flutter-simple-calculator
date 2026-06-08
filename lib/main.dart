import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String expression = '';
  String result = '0';

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        expression = '';
        result = '0';
      } else if (value == '=') {
        try {
          Parser parser = Parser();
          Expression exp = parser.parse(expression);

          ContextModel cm = ContextModel();

          double eval =
          exp.evaluate(EvaluationType.REAL, cm);

          result = eval.toString();
        } catch (e) {
          result = 'Error';
        }
      } else {
        expression += value;
      }
    });
  }

  Widget buildButton(
      String text, {
        Color? backgroundColor,
        Color? textColor,
      }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: SizedBox(
          height: 75,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
              backgroundColor ?? Colors.grey.shade200,
              foregroundColor:
              textColor ?? Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20),
              ),
            ),
            onPressed: () => buttonPressed(text),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      body: SafeArea(
        child: Column(
          children: [
            /// DISPLAY AREA
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.end,
                  crossAxisAlignment:
                  CrossAxisAlignment.end,
                  children: [
                    Text(
                      expression.isEmpty
                          ? "0"
                          : expression,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 32,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      result,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// KEYPAD
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      buildButton('7'),
                      buildButton('8'),
                      buildButton('9'),
                      buildButton(
                        '/',
                        backgroundColor:
                        Colors.orange,
                        textColor: Colors.white,
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      buildButton('4'),
                      buildButton('5'),
                      buildButton('6'),
                      buildButton(
                        '*',
                        backgroundColor:
                        Colors.orange,
                        textColor: Colors.white,
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      buildButton('1'),
                      buildButton('2'),
                      buildButton('3'),
                      buildButton(
                        '-',
                        backgroundColor:
                        Colors.orange,
                        textColor: Colors.white,
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      buildButton('0'),

                      buildButton(
                        'C',
                        backgroundColor:
                        Colors.red,
                        textColor: Colors.white,
                      ),

                      buildButton(
                        '=',
                        backgroundColor:
                        Colors.green,
                        textColor: Colors.white,
                      ),

                      buildButton(
                        '+',
                        backgroundColor:
                        Colors.orange,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}