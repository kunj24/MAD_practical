import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Calculator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
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
  String _display = '0';
  String _operator = '';
  double? _firstOperand;
  bool _shouldResetDisplay = false;

  void _numPress(String num) {
    setState(() {
      if (_shouldResetDisplay || _display == '0') {
        _display = num;
        _shouldResetDisplay = false;
      } else {
        _display = _display + num;
      }
    });
  }

  void _decimalPress() {
    setState(() {
      if (_shouldResetDisplay) {
        _display = '0.';
        _shouldResetDisplay = false;
      } else if (!_display.contains('.')) {
        _display = _display + '.';
      }
    });
  }

  void _clear() {
    setState(() {
      _display = '0';
      _operator = '';
      _firstOperand = null;
      _shouldResetDisplay = false;
    });
  }

  void _backspace() {
    setState(() {
      if (_shouldResetDisplay) {
        _display = '0';
        _shouldResetDisplay = false;
        return;
      }
      if (_display.length <= 1) {
        _display = '0';
      } else {
        _display = _display.substring(0, _display.length - 1);
      }
    });
  }

  void _setOperator(String op) {
    setState(() {
      _operator = op;
      _firstOperand = double.tryParse(_display) ?? 0;
      _shouldResetDisplay = true;
    });
  }

  void _evaluate() {
    setState(() {
      final second = double.tryParse(_display) ?? 0;
      double result = second;

      if (_firstOperand != null && _operator.isNotEmpty) {
        switch (_operator) {
          case '+':
            result = _firstOperand! + second;
            break;
          case '-':
            result = _firstOperand! - second;
            break;
          case '×':
            result = _firstOperand! * second;
            break;
          case '÷':
            if (second == 0) {
              _display = 'Error';
              _firstOperand = null;
              _operator = '';
              _shouldResetDisplay = true;
              return;
            }
            result = _firstOperand! / second;
            break;
        }
      }

      // Trim trailing .0 for integers
      final text = result.toString();
      if (text.endsWith('.0')) {
        _display = text.substring(0, text.length - 2);
      } else {
        _display = text;
      }

      _firstOperand = null;
      _operator = '';
      _shouldResetDisplay = true;
    });
  }

  Widget _buildButton(
    String label, {
    Color? color,
    Color? textColor,
    double fontSize = 24,
    VoidCallback? onTap,
  }) {
    return Material(
      color: color ?? Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: textColor ?? Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe8f5e9),
      appBar: AppBar(title: const Text('Kids Calculator'), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _operator.isNotEmpty && _firstOperand != null
                          ? '${_firstOperand!.toString().replaceAll(RegExp(r"\.0+"), "")} $_operator\''
                          : '',
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _display,
                      style: const TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildButton(
                              'C',
                              color: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 22,
                              onTap: _clear,
                            ),
                          ),
                          Expanded(
                            child: _buildButton(
                              '⌫',
                              color: Colors.orangeAccent,
                              textColor: Colors.white,
                              fontSize: 22,
                              onTap: _backspace,
                            ),
                          ),
                          Expanded(
                            child: _buildButton(
                              '÷',
                              color: Colors.blueAccent,
                              textColor: Colors.white,
                              fontSize: 22,
                              onTap: () => _setOperator('÷'),
                            ),
                          ),
                          Expanded(
                            child: _buildButton(
                              '×',
                              color: Colors.blueAccent,
                              textColor: Colors.white,
                              fontSize: 22,
                              onTap: () => _setOperator('×'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildButton(
                              '7',
                              onTap: () => _numPress('7'),
                            ),
                          ),
                          Expanded(
                            child: _buildButton(
                              '8',
                              onTap: () => _numPress('8'),
                            ),
                          ),
                          Expanded(
                            child: _buildButton(
                              '9',
                              onTap: () => _numPress('9'),
                            ),
                          ),
                          Expanded(
                            child: _buildButton(
                              '-',
                              color: Colors.blueAccent,
                              textColor: Colors.white,
                              onTap: () => _setOperator('-'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildButton(
                              '4',
                              onTap: () => _numPress('4'),
                            ),
                          ),
                          Expanded(
                            child: _buildButton(
                              '5',
                              onTap: () => _numPress('5'),
                            ),
                          ),
                          Expanded(
                            child: _buildButton(
                              '6',
                              onTap: () => _numPress('6'),
                            ),
                          ),
                          Expanded(
                            child: _buildButton(
                              '+',
                              color: Colors.blueAccent,
                              textColor: Colors.white,
                              onTap: () => _setOperator('+'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildButton(
                              '1',
                              onTap: () => _numPress('1'),
                            ),
                          ),
                          Expanded(
                            child: _buildButton(
                              '2',
                              onTap: () => _numPress('2'),
                            ),
                          ),
                          Expanded(
                            child: _buildButton(
                              '3',
                              onTap: () => _numPress('3'),
                            ),
                          ),
                          Expanded(
                            child: _buildButton(
                              '=',
                              color: Colors.green,
                              textColor: Colors.white,
                              fontSize: 22,
                              onTap: _evaluate,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: _buildButton(
                              '0',
                              onTap: () => _numPress('0'),
                            ),
                          ),
                          Expanded(
                            child: _buildButton('.', onTap: _decimalPress),
                          ),
                          Expanded(
                            child: _buildButton(
                              '00',
                              onTap: () => _numPress('00'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
