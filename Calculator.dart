import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  double _firstNumber = 0;
  double _secondNumber = 0;
  String _operation = "";

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      _firstNumber = 0;
      _secondNumber = 0;
      _operation = "";
    } else if (buttonText == "+/-") {
      _output = (-double.parse(_output)).toString();
    } else if (buttonText == "%") {
      _output = (double.parse(_output) / 100).toString();
    } else if (buttonText == ".") {
      if (!_output.contains(".")) {
        _output += ".";
      }
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      _firstNumber = double.parse(_output);
      _operation = buttonText;
      _output = "0";
    } else if (buttonText == "=") {
      _secondNumber = double.parse(_output);
      switch (_operation) {
        case "+":
          _output = (_firstNumber + _secondNumber).toString();
          break;
        case "-":
          _output = (_firstNumber - _secondNumber).toString();
          break;
        case "×":
          _output = (_firstNumber * _secondNumber).toString();
          break;
        case "÷":
          _output = (_firstNumber / _secondNumber).toString();
          break;
      }
      _operation = "";
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output += buttonText;
      }
    }

    setState(() {});
  }

  Widget _buildButton(String buttonText, {Color? bgColor, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor ?? Colors.white,
            foregroundColor: textColor ?? Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(24),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: const TextStyle(fontSize: 48),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("C", bgColor: Colors.grey),
                  _buildButton("+/-", bgColor: Colors.grey),
                  _buildButton("%", bgColor: Colors.grey),
                  _buildButton("÷", bgColor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("×", bgColor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("-", bgColor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("+", bgColor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _buildButton("."),
                  _buildButton("0"),
                  _buildButton("00"),
                  _buildButton("=", bgColor: Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}