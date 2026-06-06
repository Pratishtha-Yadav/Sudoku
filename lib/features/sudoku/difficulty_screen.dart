import 'package:flutter/material.dart';
import 'game_screen.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Select Difficulty",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            _difficultyTile(
  context,
  "Easy",
  const Color(0xFF4CAF50),
),

            const SizedBox(height: 15),

            _difficultyTile(
  context,
  "Medium",
  const Color(0xFFFF9800),
),

            const SizedBox(height: 15),

            _difficultyTile(
  context,
  "Expert",
  const Color(0xFF9C27B0),
),

            const SizedBox(height: 15),

            _difficultyTile(
  context,
  "Custom",
  const Color(0xFF2196F3),  
),
          ],
        ),
      ),
    );
  }

  Widget _difficultyTile(
  BuildContext context,
  String title,
  Color color,
){
    return GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameScreen(difficulty: title),
      ),
    );
  },
  child: Container(
      height: 80,

      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: color.withOpacity(0.4),
        ),
      ),

      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      ),
);
  }
}