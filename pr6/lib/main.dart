import 'package:flutter/material.dart';

void main() {
  runApp(const ITQuizApp());
}

class ITQuizApp extends StatelessWidget {
  const ITQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IT Quiz App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1e1e2e),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF89B4FA),
          foregroundColor: Color(0xFF1e1e2e),
        ),
      ),
      home: const QuizHomePage(),
    );
  }
}

class QuizHomePage extends StatelessWidget {
  const QuizHomePage({super.key});

  final List<QuizSubject> subjects = const [
    QuizSubject(
        name: 'Programming',
        description: 'Java, Python, C++ basics',
        difficulty: 'Intermediate',
        icon: Icons.code,
        questionCount: 10),
    QuizSubject(
        name: 'DS & Algorithms',
        description: 'Arrays, Trees, Graphs',
        difficulty: 'Advanced',
        icon: Icons.account_tree,
        questionCount: 12),
    QuizSubject(
        name: 'Databases',
        description: 'SQL, NoSQL, DBMS concepts',
        difficulty: 'Intermediate',
        icon: Icons.storage,
        questionCount: 8),
    QuizSubject(
        name: 'Web Dev',
        description: 'HTML, CSS, JS, React',
        difficulty: 'Beginner',
        icon: Icons.web,
        questionCount: 15),
    QuizSubject(
        name: 'Networking',
        description: 'TCP/IP, OSI model, Security',
        difficulty: 'Advanced',
        icon: Icons.wifi,
        questionCount: 10),
    QuizSubject(
        name: 'Mobile Dev',
        description: 'Flutter, React Native',
        difficulty: 'Intermediate',
        icon: Icons.phone_android,
        questionCount: 9),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IT Quiz App', style: TextStyle(fontWeight: FontWeight.bold)), centerTitle: true),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF89B4FA).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              children: [
                Icon(Icons.quiz, size: 48, color: Color(0xFF89B4FA)),
                SizedBox(height: 12),
                Text('IT Knowledge Quiz', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFcdd6f4))),
                SizedBox(height: 8),
                Text('Test your IT skills across subjects', style: TextStyle(color: Color(0xFFb4befe)), textAlign: TextAlign.center),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: subjects.length,
              itemBuilder: (context, i) {
                final sub = subjects[i];
                return Card(
                  color: const Color(0xFF313244),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(backgroundColor: const Color(0xFF89B4FA), child: Icon(sub.icon, color: const Color(0xFF1e1e2e))),
                    title: Text(sub.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFcdd6f4))),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(sub.description, style: const TextStyle(color: Color(0xFFb4befe))),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _tag(sub.difficulty, const Color(0xFF89B4FA).withOpacity(0.2), const Color(0xFF89B4FA)),
                            const SizedBox(width: 8),
                            _tag('${sub.questionCount} questions', const Color(0xFFb4befe).withOpacity(0.2), const Color(0xFFb4befe)),
                          ],
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.play_arrow, color: Color(0xFF89B4FA)),
                    onTap: () => _showQuizDetails(context, sub),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          const Text('Kunj Mungalpara (23CS047)', style: TextStyle(color: Color(0xFFcdd6f4), fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _tag(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w500)),
    );
  }

  void _showQuizDetails(BuildContext context, QuizSubject sub) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF313244),
        title: Row(
          children: [
            Icon(sub.icon, color: const Color(0xFF89B4FA)),
            const SizedBox(width: 12),
            Expanded(child: Text(sub.name, style: const TextStyle(color: Color(0xFFcdd6f4), fontWeight: FontWeight.bold))),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Difficulty: ${sub.difficulty}', style: const TextStyle(color: Color(0xFF89B4FA))),
            const SizedBox(height: 4),
            Text('${sub.questionCount} Questions', style: const TextStyle(color: Color(0xFFb4befe))),
            const SizedBox(height: 12),
            Text(sub.description, style: const TextStyle(color: Color(0xFFb4befe))),
            const SizedBox(height: 16),
            const Text('Click "Start Quiz" to begin!', style: TextStyle(color: Color(0xFFcdd6f4), fontSize: 14)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: Color(0xFFb4befe)))),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Starting ${sub.name} quiz...'), backgroundColor: const Color(0xFF89B4FA)));
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF89B4FA), foregroundColor: const Color(0xFF1e1e2e)),
            child: const Text('Start Quiz', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class QuizSubject {
  final String name;
  final String description;
  final String difficulty;
  final IconData icon;
  final int questionCount;

  const QuizSubject({required this.name, required this.description, required this.difficulty, required this.icon, required this.questionCount});
}
