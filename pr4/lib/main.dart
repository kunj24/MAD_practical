import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EMI Calculator',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF1e1e2e),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF2BD4B4),
            secondary: Color(0xFF89B4FA),
          ),
        ),
        home: const EMICalculator(),
      );
}

class EMICalculator extends StatefulWidget {
  const EMICalculator({super.key});

  @override
  State<EMICalculator> createState() => _EMICalculatorState();
}

class _EMICalculatorState extends State<EMICalculator> {
  final _loanCtrl = TextEditingController(),
      _rateCtrl = TextEditingController(),
      _tenureCtrl = TextEditingController();
  double _emi = 0, _total = 0, _interest = 0;
  bool _show = false;

  void _calc() {
    if (_loanCtrl.text.isEmpty ||
        _rateCtrl.text.isEmpty ||
        _tenureCtrl.text.isEmpty) {
      _alert('Please fill all fields');
      return;
    }
    try {
      final p = double.parse(_loanCtrl.text),
          r = double.parse(_rateCtrl.text) / 1200,
          n = int.parse(_tenureCtrl.text);
      if (p <= 0 || r < 0 || n <= 0) {
        _alert('Please enter valid values');
        return;
      }
      final emi = r == 0 ? p / n : p * r * pow(1 + r, n) / (pow(1 + r, n) - 1);
      setState(() {
        _emi = emi;
        _total = emi * n;
        _interest = _total - p;
        _show = true;
      });
    } catch (_) {
      _alert('Enter valid numbers');
    }
  }

  void _alert(String msg) => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: const Color(0xFF313244),
          title: const Text('Error', style: TextStyle(color: Color(0xFFf38ba8))),
          content: Text(msg, style: const TextStyle(color: Color(0xFFcdd6f4))),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK', style: TextStyle(color: Color(0xFF89B4FA))),
            )
          ],
        ),
      );

  void _clear() => setState(() {
        _loanCtrl.clear();
        _rateCtrl.clear();
        _tenureCtrl.clear();
        _show = false;
      });

  Widget _input(TextEditingController c, String l, String h, IconData i,
          [String s = '']) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextField(
          controller: c,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: l,
            hintText: h,
            prefixIcon: Icon(i, color: const Color(0xFF89B4FA)),
            suffixText: s,
            filled: true,
            fillColor: const Color(0xFF313244),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );

  Widget _result(String t, String v, IconData i, Color c) => Card(
        color: const Color(0xFF313244),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          leading: Icon(i, color: c),
          title: Text(t, style: const TextStyle(color: Color(0xFFb4befe))),
          subtitle: Text(v,
              style:
                  TextStyle(color: c, fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const Text('EMI Calculator',
                style: TextStyle(fontWeight: FontWeight.bold))),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(children: [
              // Student Info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: const Color(0xFF313244),
                    borderRadius: BorderRadius.circular(12)),
                child: const Column(
                  children: [
                    Text('Student ID: 23CS047',
                        style: TextStyle(
                            color: Color(0xFF2BD4B4),
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 4),
                    Text('Name: Kunj Mungalpara',
                        style: TextStyle(color: Color(0xFFb4befe))),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _input(_loanCtrl, 'Loan Amount', 'Enter amount', Icons.currency_rupee, '₹'),
              _input(_rateCtrl, 'Interest Rate', 'Enter annual rate', Icons.percent, '%'),
              _input(_tenureCtrl, 'Tenure (months)', 'Enter months', Icons.calendar_month, 'mo'),
              const SizedBox(height: 20),
              Row(children: [
                Expanded(
                    child: ElevatedButton.icon(
                        onPressed: _calc,
                        icon: const Icon(Icons.calculate),
                        label: const Text('Calculate'))),
                const SizedBox(width: 10),
                Expanded(
                    child: OutlinedButton.icon(
                        onPressed: _clear,
                        icon: const Icon(Icons.clear),
                        label: const Text('Clear')))
              ]),
              const SizedBox(height: 20),
              if (_show) ...[
                const Text('Results',
                    style: TextStyle(
                        color: Color(0xFF89B4FA),
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                _result('Monthly EMI', '₹${_emi.toStringAsFixed(2)}',
                    Icons.payment, const Color(0xFF89B4FA)),
                _result('Total Payment', '₹${_total.toStringAsFixed(2)}',
                    Icons.account_balance_wallet, const Color(0xFFa6e3a1)),
                _result('Total Interest', '₹${_interest.toStringAsFixed(2)}',
                    Icons.trending_up, const Color(0xFFfab387)),
              ]
            ]),
          ),
        ),
      );

  @override
  void dispose() {
    _loanCtrl.dispose();
    _rateCtrl.dispose();
    _tenureCtrl.dispose();
    super.dispose();
  }
}
