import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1e1e2e),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2BD4B4),
          foregroundColor: Color(0xFF1e1e2e),
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFcdd6f4)),
          bodyMedium: TextStyle(color: Color(0xFFcdd6f4)),
          titleLarge: TextStyle(color: Color(0xFFcdd6f4)),
        ),
      ),
      home: const EMICalculator(),
    );
  }
}

class EMICalculator extends StatefulWidget {
  const EMICalculator({super.key});

  @override
  State<EMICalculator> createState() => _EMICalculatorState();
}

class _EMICalculatorState extends State<EMICalculator> {
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _tenureController = TextEditingController();

  double _emi = 0.0;
  double _totalPayment = 0.0;
  double _totalInterest = 0.0;
  bool _showResults = false;

  void _calculateEMI() {
    if (_loanAmountController.text.isEmpty ||
        _interestRateController.text.isEmpty ||
        _tenureController.text.isEmpty) {
      _showErrorDialog('Please fill all fields');
      return;
    }

    try {
      double principal = double.parse(_loanAmountController.text);
      double annualRate = double.parse(_interestRateController.text);
      int tenureMonths = int.parse(_tenureController.text);

      if (principal <= 0 || annualRate < 0 || tenureMonths <= 0) {
        _showErrorDialog('Please enter valid positive values');
        return;
      }

      // Convert annual rate to monthly rate and percentage to decimal
      double monthlyRate = (annualRate / 12) / 100;

      // EMI calculation formula: P * r * (1+r)^n / ((1+r)^n - 1)
      double emi;
      if (monthlyRate == 0) {
        // If interest rate is 0, EMI is simply principal divided by tenure
        emi = principal / tenureMonths;
      } else {
        double factor = pow(1 + monthlyRate, tenureMonths).toDouble();
        emi = (principal * monthlyRate * factor) / (factor - 1);
      }

      double totalPayment = emi * tenureMonths;
      double totalInterest = totalPayment - principal;

      setState(() {
        _emi = emi;
        _totalPayment = totalPayment;
        _totalInterest = totalInterest;
        _showResults = true;
      });
    } catch (e) {
      _showErrorDialog('Please enter valid numbers');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF313244),
          title: const Text(
            'Error',
            style: TextStyle(color: Color(0xFFf38ba8)),
          ),
          content: Text(
            message,
            style: const TextStyle(color: Color(0xFFcdd6f4)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFF89B4FA)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _clearAll() {
    setState(() {
      _loanAmountController.clear();
      _interestRateController.clear();
      _tenureController.clear();
      _emi = 0.0;
      _totalPayment = 0.0;
      _totalInterest = 0.0;
      _showResults = false;
    });
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String suffix = '',
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Color(0xFFcdd6f4), fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffixText: suffix,
          prefixIcon: Icon(icon, color: const Color(0xFF89B4FA)),
          labelStyle: const TextStyle(color: Color(0xFFb4befe)),
          hintStyle: const TextStyle(color: Color(0xFF6c7086)),
          suffixStyle: const TextStyle(color: Color(0xFFb4befe)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF45475a), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF89B4FA), width: 2),
          ),
          filled: true,
          fillColor: const Color(0xFF313244),
        ),
      ),
    );
  }

  Widget _buildResultCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF313244),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF45475a), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFb4befe),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EMI Calculator',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Student Info
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF313244),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF45475a), width: 1),
              ),
              child: Column(
                children: [
                  Text(
                    'Student ID: 23CS047',
                    style: TextStyle(
                      color: const Color(0xFF2BD4B4),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Name: Kunj Mungalpara',
                    style: TextStyle(
                      color: const Color(0xFFb4befe),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Input Fields
            _buildInputField(
              controller: _loanAmountController,
              label: 'Loan Amount',
              hint: 'Enter loan amount',
              icon: Icons.currency_rupee,
              suffix: '₹',
            ),
            _buildInputField(
              controller: _interestRateController,
              label: 'Annual Interest Rate',
              hint: 'Enter interest rate',
              icon: Icons.percent,
              suffix: '%',
            ),
            _buildInputField(
              controller: _tenureController,
              label: 'Loan Tenure',
              hint: 'Enter tenure in months',
              icon: Icons.calendar_month,
              suffix: 'months',
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _calculateEMI,
                    icon: const Icon(Icons.calculate),
                    label: const Text(
                      'Calculate EMI',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2BD4B4),
                      foregroundColor: const Color(0xFF1e1e2e),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _clearAll,
                    icon: const Icon(Icons.clear_all),
                    label: const Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFf38ba8),
                      side: const BorderSide(
                        color: Color(0xFFf38ba8),
                        width: 2,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Results Section
            if (_showResults) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF313244),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF45475a), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'EMI Calculation Results',
                      style: TextStyle(
                        color: Color(0xFF89B4FA),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildResultCard(
                      title: 'Monthly EMI',
                      value: '₹${_emi.toStringAsFixed(2)}',
                      icon: Icons.payment,
                      color: const Color(0xFF89B4FA),
                    ),
                    _buildResultCard(
                      title: 'Total Payment',
                      value: '₹${_totalPayment.toStringAsFixed(2)}',
                      icon: Icons.account_balance_wallet,
                      color: const Color(0xFFa6e3a1),
                    ),
                    _buildResultCard(
                      title: 'Total Interest',
                      value: '₹${_totalInterest.toStringAsFixed(2)}',
                      icon: Icons.trending_up,
                      color: const Color(0xFFfab387),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loanAmountController.dispose();
    _interestRateController.dispose();
    _tenureController.dispose();
    super.dispose();
  }
}
