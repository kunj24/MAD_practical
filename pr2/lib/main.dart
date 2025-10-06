import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Kids Calculator',
    theme: ThemeData(primarySwatch: Colors.teal),
    home: const CalculatorPage(),
  );
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '0', operator = '';
  double? firstOperand;
  bool resetDisplay = false;

  void press(String value) {
    setState(() {
      if (resetDisplay || display == '0') {
        display = value;
        resetDisplay = false;
      } else {
        display += value;
      }
    });
  }

  void setOperator(String op) {
    firstOperand = double.tryParse(display);
    operator = op;
    resetDisplay = true;
  }

  void evaluate() {
    final second = double.tryParse(display) ?? 0;
    double result = second;

    if (firstOperand != null && operator.isNotEmpty) {
      switch (operator) {
        case '+':
          result = firstOperand! + second;
          break;
        case '-':
          result = firstOperand! - second;
          break;
        case '×':
          result = firstOperand! * second;
          break;
        case '÷':
          if (second == 0) {
            display = 'Error';
            firstOperand = null;
            operator = '';
            resetDisplay = true;
            return;
          }
          result = firstOperand! / second;
          break;
      }
    }

    display = result % 1 == 0 ? result.toInt().toString() : result.toString();
    firstOperand = null;
    operator = '';
    resetDisplay = true;
    setState(() {});
  }

  void clear() => setState(() {
    display = '0';
    operator = '';
    firstOperand = null;
    resetDisplay = false;
  });

  void backspace() => setState(() {
    if (resetDisplay) {
      display = '0';
      resetDisplay = false;
    } else {
      display = display.length > 1
          ? display.substring(0, display.length - 1)
          : '0';
    }
  });

  Widget buildBtn(
    String text, {
    Key? key,
    Color color = Colors.white,
    Color textColor = Colors.black,
    double size = 24,
    VoidCallback? onTap,
  }) => Material(
    key: key,
    color: color,
    child: InkWell(
      onTap: onTap,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: size, color: textColor),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFe8f5e9),
    appBar: AppBar(title: const Text('Kids Calculator'), centerTitle: true),
    body: Column(
      children: [
        // Display
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(24),
            child: Text(
              display,
              key: const Key('display'),
              style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // Buttons
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                // Top row
                _row([
                  buildBtn(
                    'C',
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    onTap: clear,
                  ),
                  buildBtn(
                    '⌫',
                    color: Colors.orangeAccent,
                    textColor: Colors.white,
                    onTap: backspace,
                  ),
                  buildBtn(
                    '÷',
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onTap: () => setOperator('÷'),
                  ),
                  buildBtn(
                    '×',
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onTap: () => setOperator('×'),
                  ),
                ]),
                _row([
                  buildBtn('7', key: const Key('7'), onTap: () => press('7')),
                  buildBtn('8', key: const Key('8'), onTap: () => press('8')),
                  buildBtn('9', key: const Key('9'), onTap: () => press('9')),
                  buildBtn(
                    '-',
                    key: const Key('-'),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onTap: () => setOperator('-'),
                  ),
                ]),
                _row([
                  buildBtn('4', onTap: () => press('4')),
                  buildBtn('5', onTap: () => press('5')),
                  buildBtn('6', onTap: () => press('6')),
                  buildBtn(
                    '+',
                    key: const Key('+'),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onTap: () => setOperator('+'),
                  ),
                ]),
                _row([
                  buildBtn('1', key: const Key('1'), onTap: () => press('1')),
                  buildBtn('2', key: const Key('2'), onTap: () => press('2')),
                  buildBtn('3', key: const Key('3'), onTap: () => press('3')),
                  buildBtn(
                    '=',
                    key: const Key('='),
                    color: Colors.green,
                    textColor: Colors.white,
                    onTap: evaluate,
                  ),
                ]),
                _row([
                  Expanded(
                    flex: 2,
                    child: buildBtn('0', onTap: () => press('0')),
                  ),
                  buildBtn('.', onTap: () => press('.')),
                  buildBtn('00', onTap: () => press('00')),
                ]),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _row(List<Widget> children) => Expanded(
    child: Row(
      children: children
          .map((w) => w is Expanded ? w : Expanded(child: w))
          .toList(),
    ),
  );
}
