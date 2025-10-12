import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'base_tool.dart';

class CalculatorTool extends BaseTool {
  @override
  String get name => 'CalculatorTool';

  @override
  Map<String, dynamic> execute(Map<String, dynamic> parameters) {
    final String equation = parameters['equation'] as String;

    // Создаем toolSummary
    final String toolSummary = '<tool_summary>I have provided a calculator interface for the user to evaluate the equation: $equation</tool_summary>';

    // Возвращаем Map с toolWidget и toolSummary
    return {
      'toolWidget': CalculatorToolWidget(initialEquation: equation),
      'toolSummary': toolSummary,
    };
  }
}

class CalculatorToolWidget extends StatefulWidget {
  final String initialEquation;

  const CalculatorToolWidget({Key? key, required this.initialEquation}) : super(key: key);

  @override
  _CalculatorToolWidgetState createState() => _CalculatorToolWidgetState();
}

class _CalculatorToolWidgetState extends State<CalculatorToolWidget> {
  late TextEditingController _equationController;
  String _result = '';

  @override
  void initState() {
    super.initState();
    _equationController = TextEditingController(text: widget.initialEquation);
  }

  @override
  void dispose() {
    _equationController.dispose();
    super.dispose();
  }

  void _calculateResult() {
    String equation = _equationController.text;
    equation = equation.replaceAll('×', '*').replaceAll('÷', '/');

    try {
      Parser p = Parser();
      Expression exp = p.parse(equation);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        _result = eval.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _equationController,
            decoration: InputDecoration(
              labelText: 'Equation',
              hintText: 'Enter an equation',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _calculateResult,
            child: Text('='),
          ),
          SizedBox(height: 16.0),
          Text(
            _result,
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}