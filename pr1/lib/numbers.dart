import 'package:flutter/material.dart';

class Numbers extends StatelessWidget {
  const Numbers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Numbers')),
      body: Container(
        color: const Color(0xFF1e1e2e),
        child: const Center(
          child: Text(
            '1 2 3 4 5 6 7',
            style: TextStyle(color: Color(0xFFcdd6f4), fontSize: 28),
          ),
        ),
      ),
    );
  }
}
