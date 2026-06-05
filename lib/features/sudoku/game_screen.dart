import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Medium",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            // Timer Row
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "02:15",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),

                Row(
                  children: [
                    Icon(Icons.lightbulb_outline,
                        color: Colors.white),
                    SizedBox(width: 12),
                    Icon(Icons.pause,
                        color: Colors.white),
                  ],
                )
              ],
            ),

            const SizedBox(height: 25),

            // Sudoku Board Placeholder
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF15152B),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Number Pad
            SizedBox(
              height: 60,
              child: Row(
                children: List.generate(
                  9,
                  (index) => Expanded(
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF15152B),
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}