import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MatchingGame(),
    ));

class GameItem {
  final String emoji;
  final String word;
  bool matched;
  GameItem(this.emoji, this.word, {this.matched = false});
}

class MatchingGame extends StatefulWidget {
  const MatchingGame({super.key});

  @override
  State<MatchingGame> createState() => _MatchingGameState();
}

class _MatchingGameState extends State<MatchingGame> {
  final List<GameItem> _items = [
    GameItem('🍎', 'APPLE'),
    GameItem('🍌', 'BANANA'),
    GameItem('🍇', 'GRAPES'),
    GameItem('🍉', 'WATERMELON'),
    GameItem('🍍', 'PINEAPPLE'),
    GameItem('🍊', 'ORANGE'),
  ];

  late List<GameItem> leftList;
  late List<GameItem> rightList;
  GameItem? leftSelected;
  GameItem? rightSelected;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  void _shuffle() {
    leftList = List.from(_items)..shuffle(Random());
    rightList = List.from(_items)..shuffle(Random());
    for (var i in _items) i.matched = false;
    leftSelected = rightSelected = null;
    score = 0;
    setState(() {});
  }

  void _select(GameItem item, bool left) {
    if (item.matched) return;
    setState(() => left ? leftSelected = item : rightSelected = item);
    if (leftSelected != null && rightSelected != null) {
      _checkMatch();
    }
  }

  void _checkMatch() {
    if (leftSelected!.word == rightSelected!.word) {
      setState(() {
        leftSelected!.matched = true;
        rightSelected!.matched = true;
        score += 10;
      });
    }

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        leftSelected = null;
        rightSelected = null;
      });
      if (_items.every((e) => e.matched)) _showWin();
    });
  }

  void _showWin() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1e1e2e),
        title: const Text('🎉 You Won!', style: TextStyle(color: Colors.white)),
        content: Text('Your Score: $score',
            style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _shuffle();
            },
            child: const Text('Play Again',
                style: TextStyle(color: Colors.lightBlueAccent)),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(GameItem item, bool left, bool selected) {
    return GestureDetector(
      onTap: item.matched ? null : () => _select(item, left),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: item.matched
              ? Colors.greenAccent.shade100
              : selected
                  ? Colors.lightBlueAccent.shade100
                  : const Color(0xFF313244),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: item.matched
                ? Colors.greenAccent
                : selected
                    ? Colors.blueAccent
                    : Colors.grey,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            left ? item.emoji : item.word,
            style: TextStyle(
                fontSize: left ? 40 : 20,
                color: item.matched ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1e1e2e),
      appBar: AppBar(
        title: const Text('🍓 Fruit Matching Game'),
        backgroundColor: const Color(0xFF89B4FA),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text('Score: $score',
              style: const TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: leftList.length,
                    itemBuilder: (context, index) => _buildCard(
                        leftList[index], true, leftSelected == leftList[index]),
                  ),
                ),
                Container(width: 2, color: Colors.white12),
                Expanded(
                  child: ListView.builder(
                    itemCount: rightList.length,
                    itemBuilder: (context, index) => _buildCard(
                        rightList[index], false, rightSelected == rightList[index]),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: _shuffle,
            icon: const Icon(Icons.refresh),
            label: const Text('New Game'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF89B4FA),
              foregroundColor: const Color(0xFF1e1e2e),
            ),
          ),
          const SizedBox(height: 8),
          const Text('Made by Kunj Mungalpara (23CS047)',
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
