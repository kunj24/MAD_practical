import 'package:flutter/material.dart';
import 'alphabet.dart';
import 'numbers.dart';

void main() {
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Alphabet()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Numbers()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Practical - 1",
          style: TextStyle(color: Color(0xFFcdd6f4)),
        ),
        backgroundColor: Color(0xFF89B4FA),
      ),
      body: Container(
        color: Color(0xFF1e1e2e),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "23CS047",
                style: TextStyle(
                  color: Color(0xFFcdd6f4),
                  fontSize: 54,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  letterSpacing: 6.0,
                  shadows: [
                    Shadow(
                      offset: Offset(4.0, 4.0),
                      blurRadius: 8.0,
                      color: Color(0xFF45475a),
                    ),
                  ],
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF89B4FA),
                  decorationThickness: 3.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18),
              Text(
                "Kunj Mungalpara",
                style: TextStyle(
                  color: Color(0xFFb4befe),
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0,
                      color: Color(0xFF313244),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF11111b),
        selectedItemColor: Color(0xFF89B4FA),
        unselectedItemColor: Color(0xFF6c7086),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Alphabets'),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered),
            label: 'Numbers',
          ),
        ],
      ),
    );
  }
}
