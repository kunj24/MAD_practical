import 'package:flutter/material.dart';

class Alphabet extends StatelessWidget {
  const Alphabet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alphabets')),
      body: Container(
        color: const Color(0xFF1e1e2e),
        child: const Center(
          child: Text(
            'A B C D E F G',
            style: TextStyle(color: Color(0xFFcdd6f4), fontSize: 28),
          ),
        ),
      ),
    );
  }
}
